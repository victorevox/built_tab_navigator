import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({
    Key key,
    @required this.navigatorKey,
    @required this.routes,
    this.initialRoute,
    this.onGenerateRoute,
  })  : assert(routes != null),
        assert(navigatorKey != null),
        super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final Map<EnumClass, Widget Function(BuildContext)> routes;
  final String initialRoute;
  final void Function(RouteSettings routeSettings, EnumClass route)
      onGenerateRoute;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    return routes.map((i, builder) {
      return MapEntry(i.name, builder);
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: initialRoute,
      onGenerateRoute: (routeSettings) {
        final EnumClass routeEnum = routes.keys.where((route) {
          return route.name == routeSettings.name;
        }).first;
        if (onGenerateRoute is Function) {
          onGenerateRoute(routeSettings, routeEnum);
        }
        return MaterialPageRoute(
          builder: (context) {
            final builder = routeBuilders[routeSettings.name];
            return builder != null
                ? builder(context)
                : Text("No implemented: ${routeSettings.name}");
          },
        );
      },
    );
  }
}
