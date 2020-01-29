library example3_routes;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/widgets.dart';
import './utils.dart';

part 'example3_routes.g.dart';

Map<Example3Routes, WidgetBuilder> example3Routes = {
  Example3Routes.root: (context) {
    return baseScreen(context, "Example3 Root", Example3Routes.nested1);
  },
  Example3Routes.nested1: (context) {
    return baseScreen(context, "Example3 Nested1");
  },
};

class Example3Routes extends EnumClass {

  static const Example3Routes root = _$root;
  static const Example3Routes nested1 = _$nested1;

  const Example3Routes._(String name) : super(name);

  static BuiltSet<Example3Routes> get values => _$values;
  static Example3Routes valueOf(String name) => _$valueOf(name);
}