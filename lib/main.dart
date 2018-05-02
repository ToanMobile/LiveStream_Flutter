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
  @override
  void dispose() {
    super.dispose();
  }

  Widget _loadPage() {
    Widget widget = new Container(width: 0.0, height: 0.0);
    switch (0) {
      case 0:
        widget = DetailsPage();
        break;
      case 1:
        widget = DetailsPage1();
        break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hamster"),
          actions: <Widget>[
            PopupMenuButton<BottomNavigationBarType>(
              onSelected: (BottomNavigationBarType value) {
                setState(() {
                  //  _type = value;
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
        bottomNavigationBar: buildNavigationBar());
  }
}

var buildNavigationBar = () => ScopedModelDescendant<MainModel>(
    builder: (context, child, model) => BottomNavigationBar(
            currentIndex: model.currentIndex,
            onTap: model.clickTabCurrentIndex,
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.access_alarm),
                  title: Text('Stream'),
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_a_photo),
                  title: Text('Stream'),
                  backgroundColor: Colors.lightBlue),
            ]));
