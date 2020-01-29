import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart';

class TabNavigator<T extends EnumClass> extends StatefulWidget {
  TabNavigator({
    Key key,
    @required this.navigatorKey,
    @required this.routes,
    @required this.tab,
    this.initialRoute,
    this.onGenerateRoute,
    this.didPop,
    this.didPush,
    this.didRemove,
    this.didReplace,
  })  : assert(routes != null),
        assert(navigatorKey != null),
        super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final Map<EnumClass, Widget Function(BuildContext)> routes;
  final String initialRoute;
  final void Function(RouteSettings routeSettings, EnumClass route)
      onGenerateRoute;
  final T tab;

  /// [didPop] navigationObserver callback
  final void Function(T tab, Route route, Route previousRoute) didPop;

  /// [didPush] navigationObserver callback
  final void Function(T tab, Route route, Route previousRoute) didPush;

  /// [didRemove] navigationObserver callback
  final void Function(T tab, Route route, Route previousRoute) didRemove;

  /// [didReplace] navigationObserver callback
  final void Function(T tab, Route newRoute, Route oldRoute) didReplace;

  @override
  TabNavigatorState<T> createState() => TabNavigatorState<T>();
}

class TabNavigatorState<T extends EnumClass> extends State<TabNavigator> {
  BuildContext _buildContext;

  BuildContext get buildContext => _buildContext;

  Map<String, WidgetBuilder> _routeBuilders(
    BuildContext context,
  ) {
    return widget.routes.map((i, builder) {
      return MapEntry(i.name, builder);
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: widget.initialRoute,
      observers: [_TabNavigatorObserver<T>(
        widget.tab,
        didPop: widget.didPop,
        didPush: widget.didPush,
        didRemove: widget.didRemove,
        didReplace: widget.didReplace,
      )],
      onGenerateRoute: (routeSettings) {
        final EnumClass routeEnum = widget.routes.keys.where((route) {
          return route.name == routeSettings.name;
        }).first;
        if (widget.onGenerateRoute is Function) {
          widget.onGenerateRoute(routeSettings, routeEnum);
        }
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) {
            _buildContext = context;
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

class _TabNavigatorObserver<T extends EnumClass> extends NavigatorObserver {

  final T tab;
  /// [didPop] navigationObserver callback
  void Function(T tab, Route route, Route previousRoute) _didPop;

  /// [didPush] navigationObserver callback
  void Function(T tab, Route route, Route previousRoute) _didPush;

  /// [didRemove] navigationObserver callback
  void Function(T tab, Route route, Route previousRoute) _didRemove;

  /// [didReplace] navigationObserver callback
  void Function(T tab, Route newRoute, Route oldRoute) _didReplace;

  _TabNavigatorObserver(T this.tab, {
    void Function(T tab, Route route, Route previousRoute) didPop, 
    void Function(T tab, Route route, Route previousRoute) didPush, 
    void Function(T tab, Route route, Route previousRoute) didRemove, 
    void Function(T tab, Route newRoute, Route oldRoute) didReplace,
  }) {
    this._didPop = didPop;
    this._didPush = didPush;
    this._didRemove = didRemove;
    this._didReplace = didReplace;
  }

  @override
  void didPop(Route route, Route previousRoute) {
    if(_didPop != null) {
      _didPop(tab, route, previousRoute);
    }
  }

  @override
  void didPush(Route route, Route previousRoute) {
    if(_didPush != null) {
      _didPush(tab, route, previousRoute);
    }
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    if(_didRemove != null) {
      _didRemove(tab, route, previousRoute);
    }
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    if(_didReplace != null) {
      _didReplace(tab, newRoute, oldRoute);
    }
  }

  // @override
  // void didStartUserGesture(Route route, Route previousRoute) {
  //   // TODO: implement didStartUserGesture
  // }

  // @override
  // void didStopUserGesture() {
  //   // TODO: implement didStopUserGesture
  // }

  // @override
  // // TODO: implement navigator
  // NavigatorState get navigator => throw UnimplementedError();

}
