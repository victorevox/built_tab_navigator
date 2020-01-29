import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget baseScreen(BuildContext context, String title, [EnumClass route]) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 32,
              color: Colors.blue[300],
            ),
          ),
          MaterialButton(
            onPressed: () {
              if(route != null) {
                Navigator.of(context).pushNamed(route.name);
              } else {
                Navigator.of(context).popUntil((route) {
                  return route.isFirst;
                });
              }
            },
            child: Text( route != null? "Go Next" : "Back to first"),
          ),
        ]
      ),
    ),
  );
}
