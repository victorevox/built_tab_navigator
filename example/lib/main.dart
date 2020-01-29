import 'package:built_collection/built_collection.dart';
import 'package:built_tab_navigator/built_tab_navigator.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart';

import 'example1_routes.dart';
import 'example2_routes.dart';
import 'example3_routes.dart';

part 'main.g.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BuiltTabNavigator(
        activeTabColor: Colors.red,
        inactiveTabColor: Colors.white,
        bodyBuilder: (context, tabs, tabView) {
          return Column(
            children: <Widget>[
              Material(
                elevation: 9,
                color: Colors.blue[200],
                child: Container(
                  height: 100,
                  child: Row(
                    children: tabs,
                  ),
                ),
              ),
              Expanded(
                child: tabView,
              ),
            ],
          );
        },
        tabs: {
          ExampleTabs.example1: TabRoutesDefinition(
            initialRoute: Example1Routes.root,
            routes: example1Routes,
            tabTitle: "Example 1",
            tabIcon: Icons.ac_unit,
          ),
          ExampleTabs.example2: TabRoutesDefinition(
            initialRoute: Example2Routes.root,
            routes: example2Routes,
            tabTitle: "Example 2",
            tabIcon: Icons.accessibility_new,
          ),
          ExampleTabs.example3: TabRoutesDefinition(
            initialRoute: Example2Routes.root,
            routes: example3Routes,
            tabTitle: "Example 3",
            tabIcon: Icons.adb,
          ),
        },
      ),
    );
  }
}

class ExampleTabs extends EnumClass {
  static const ExampleTabs example1 = _$example1;
  static const ExampleTabs example2 = _$example2;
  static const ExampleTabs example3 = _$example3;

  const ExampleTabs._(String name) : super(name);

  static BuiltSet<ExampleTabs> get values => _$values;
  static ExampleTabs valueOf(String name) => _$valueOf(name);
}
