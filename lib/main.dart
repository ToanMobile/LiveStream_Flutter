import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/model.dart';
import 'ui/details_page.dart';
import 'ui/details_page1.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(home: SportTV()),
    );
  }
}

class SportTV extends StatefulWidget {
  @override
  SportTVState createState() => SportTVState();
}

class SportTVState extends State<SportTV> with TickerProviderStateMixin {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        icon: Icon(Icons.access_alarm),
        title: 'Stream',
        color: Colors.blue,
        vsync: this,
      ),
      NavigationIconView(
        icon: Icon(Icons.add_a_photo),
        title: 'Lịch',
        color: Colors.lightBlue,
        vsync: this,
      )
    ];
    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);
    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews) view.controller.dispose();
    super.dispose();
  }

  Widget _loadPage() {
    Widget widget = new Container(width: 0.0, height: 0.0);
    switch (_currentIndex) {
      case 0:
        widget = DetailsPage();
        break;
      case 1:
        widget = DetailsPage1();
        break;
    }
    return widget;
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _navigationViews)
      transitions.add(view.transition(_type, context));

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });
    return Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Hamster"),
        actions: <Widget>[
          PopupMenuButton<BottomNavigationBarType>(
            onSelected: (BottomNavigationBarType value) {
              setState(() {
                _type = value;
              });
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuItem<BottomNavigationBarType>>[
                  PopupMenuItem<BottomNavigationBarType>(
                    value: BottomNavigationBarType.fixed,
                    child: Text('Fixed'),
                  ),
                  PopupMenuItem<BottomNavigationBarType>(
                    value: BottomNavigationBarType.shifting,
                    child: Text('Shifting'),
                  )
                ],
          )
        ],
      ),
      body: Center(
        child: _loadPage(),
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}
