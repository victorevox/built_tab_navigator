import 'package:flutter/widgets.dart';

class TabPageRoute extends StatefulWidget {
  final Widget child;
  TabPageRoute({Key key, this.child}) : super(key: key);

  @override
  TabPageRouteState createState() => TabPageRouteState();
}

class TabPageRouteState extends State<TabPageRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: widget.child,
    );
  }
}