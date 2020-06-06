part of built_tab_navigator;

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
  final Route<dynamic> Function(RouteSettings routeSettings, EnumClass route,
      EnumClass tab, WidgetBuilder child) onGenerateRoute;
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
  HeroController _heroController;

  Map<String, WidgetBuilder> _routeBuilders(
    BuildContext context,
  ) {
    return widget.routes.map((i, builder) {
      return MapEntry(i.name, builder);
    });
  }

  @override
  void initState() { 
    super.initState();
    _heroController = HeroController(createRectTween: _createRectTween);
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: widget.initialRoute,
      observers: [
        _heroController,
        _TabNavigatorObserver<T>(
          widget.tab,
          didPop: widget.didPop,
          didPush: widget.didPush,
          didRemove: widget.didRemove,
          didReplace: widget.didReplace,
        )
      ],
      onGenerateRoute: (routeSettings) {
        final EnumClass routeEnum = widget.routes.keys.where((route) {
          return route.name == routeSettings.name;
        }).first;
        final builder = routeBuilders[routeSettings.name];
        if (widget.onGenerateRoute is Function) {
          return widget.onGenerateRoute(
              routeSettings, routeEnum, widget.tab, builder);
        }
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) {
            _buildContext = context;
            return builder != null
                  ? builder(context)
                  : Text("No implemented: ${routeSettings.name}");
          },
        );
      },
    );
  }

  RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectArcTween(begin: begin, end: end);
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

  _TabNavigatorObserver(
    T this.tab, {
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
    if (_didPop != null) {
      _didPop(tab, route, previousRoute);
    }
  }

  @override
  void didPush(Route route, Route previousRoute) {
    if (_didPush != null) {
      _didPush(tab, route, previousRoute);
    }
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    if (_didRemove != null) {
      _didRemove(tab, route, previousRoute);
    }
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    if (_didReplace != null) {
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

class _OpacityAnimationWrapper extends StatefulWidget {
  final Widget child;
  final bool show;
  final Duration duration;
  _OpacityAnimationWrapper({
    Key key,
    @required this.child,
    this.show = false,
    @required this.duration,
  }) : super(key: key);

  @override
  __OpacityAnimationWrapperState createState() =>
      __OpacityAnimationWrapperState();
}

class __OpacityAnimationWrapperState extends State<_OpacityAnimationWrapper> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _setOpacity();
      });
    });
  }

  @override
  void didUpdateWidget (_OpacityAnimationWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.show != widget.show) {
      _setOpacity();
    }
  }

  _setOpacity() {
    _opacity = widget.show ? 1 : 0;
    print(_opacity);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 450),
      opacity: _opacity,
      curve: Curves.easeIn,
      child: widget.child,
    );
  }
}
