library example2_routes;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/widgets.dart';
import './utils.dart';

part 'example2_routes.g.dart';

Map<Example2Routes, WidgetBuilder> example2Routes = {
  Example2Routes.root: (context) {
    return baseScreen(context, "Example2 Root", Example2Routes.nested1);
  },
  Example2Routes.nested1: (context) {
    return baseScreen(context, "Example2 Nested1");
  },
};

class Example2Routes extends EnumClass {

  static const Example2Routes root = _$root;
  static const Example2Routes nested1 = _$nested1;

  const Example2Routes._(String name) : super(name);

  static BuiltSet<Example2Routes> get values => _$values;
  static Example2Routes valueOf(String name) => _$valueOf(name);
}