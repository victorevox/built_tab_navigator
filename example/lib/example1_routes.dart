library example1_routes;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/widgets.dart';
import './utils.dart';

part 'example1_routes.g.dart';

Map<Example1Routes, WidgetBuilder> example1Routes = {
  Example1Routes.root: (context) {
    return baseScreen(context, "Example1 Root", Example1Routes.nested1);
  },
  Example1Routes.nested1: (context) {
    return baseScreen(context, "Example1 Nested1", Example1Routes.nested2);
  },
  Example1Routes.nested2: (context) {
    return baseScreen(context, "Example1 Nested2");
  },
};
class Example1Routes extends EnumClass {

  static const Example1Routes root = _$root;
  static const Example1Routes nested1 = _$nested1;
  static const Example1Routes nested2 = _$nested2;

  const Example1Routes._(String name) : super(name);

  static BuiltSet<Example1Routes> get values => _$values;
  static Example1Routes valueOf(String name) => _$valueOf(name);
}