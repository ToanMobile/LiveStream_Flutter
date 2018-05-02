import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;

class DetailsPage1 extends StatefulWidget {
  DetailsPage1({Key key}) : super(key: key);

  @override
  _DetailsPageState1 createState() => new _DetailsPageState1();
}

class _DetailsPageState1 extends State<DetailsPage1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var document =
        parse('<body>Hhuhuhuhuhuu! <a href="www.html5rocks.com">HTML5 rocks!');
    print("testLogger=" + document.outerHtml);
    return new Text(document.outerHtml);
  }
}
