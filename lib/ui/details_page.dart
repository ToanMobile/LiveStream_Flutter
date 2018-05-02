import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key}) : super(key: key);

  @override
  _DetailsPageState createState() => new _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var document =
        parse('<body>Hello world! <a href="www.html5rocks.com">HTML5 rocks!');
    print("testLogger=" + document.outerHtml);
    return new Text(document.outerHtml);
  }
}
