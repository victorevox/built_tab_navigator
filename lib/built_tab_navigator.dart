library built_tab_navigator;

import 'package:built_tab_navigator/tab_navigator.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BuiltTabNavigator<T extends EnumClass> extends StatefulWidget {
  /// Defines default [selectedTab]

  /// Defines the [tabs] of this widget
  /// Each [tab] must define a [TabRoutesDefinition]
  final Map<T, TabRoutesDefinition> tabs;

  /// Defines a [bodyBuilder], if you need something very custom, maybe the tabs located at different position: ie on Top
  /// you can place [tabs] and [tabsViews] in a custom layout arrangement
  final Widget Function(
    BuildContext context,
    List<Widget> tabs,
    Widget tabsViewsContainer,
  ) bodyBuilder;

  /// Builds a custom [tab] widget for each tab, make sure to call the [cb] parameter if you're using a custom [GestureDetector|InkWell]  or whatever widget that could handle touch events
  /// calling [cb] will trigger state build and change tab content as expected
  final Widget Function(
    BuildContext context,
    T tab,
    TabRoutesDefinition definition,
    bool isSelected,
    Widget title,
    Widget icon,
    Function() cb,
  ) tabBuilder;

  /// Defines [Color] used for the tab [title] and [icon] when [tab] is active
  final Color activeTabColor;

  /// Defines [Color] used for the tab [title] and [icon] when [tab] is inactive
  final Color inactiveTabColor;

  /// Defines a tap handler when a [tab]
  final Function(T) tabTap;

  /// Builds a custom [title] [Widget]
  final Widget Function(
    BuildContext context,
    T tab,
    TabRoutesDefinition definition,
    bool isSelected,
  ) titleBuilder;

  /// Builds a custom [icon] [Widget]
  final Widget Function(
    BuildContext context,
    T tab,
    TabRoutesDefinition definition,
    bool isSelected,
  ) iconBuilder;

  /// Called everytime a route is being generated, it passes the actual [RouteSettings], the [T] tab who owns that navigator, and the actual route used to produce the page
  final Function(RouteSettings routeSettings, T tab, EnumClass route)
      onGenerateRoute;

  /// Set [activetab], if not defined will default to the firs [tab] key defined at [tabs]
  final T activeTab;

  /// Change defaults tab container background
  final Color tabContainerBackgroundColor;

  /// [didPop] navigationObserver callback
  final void Function(T tab, Route route, Route previousRoute) didPop;

  /// [didPush] navigationObserver callback
  final void Function(T tab, Route route, Route previousRoute) didPush;

  /// [didRemove] navigationObserver callback
  final void Function(T tab, Route route, Route previousRoute) didRemove;

  /// [didReplace] navigationObserver callback
  final void Function(T tab, Route newRoute, Route oldRoute) didReplace;

  /// If [true] , it will implement [WillPopScope] widget for the nested navigation views, if [false],
  /// back navigation will target the root navigator
  /// defaults to [true]
  final bool overridePopBehavior;

  /// Set a custom [height] for the tabs container
  /// defaults to [60]
  /// This property doesnt take any effect if [bodyBuilder] is defined
  final double tabsHeight;

  BuiltTabNavigator({
    Key key,
    @required this.tabs,
    this.bodyBuilder,
    this.tabBuilder,
    this.activeTabColor,
    this.tabTap,
    this.inactiveTabColor,
    this.titleBuilder,
    this.iconBuilder,
    this.onGenerateRoute,
    this.activeTab,
    this.tabContainerBackgroundColor,
    this.didPop,
    this.didPush,
    this.didRemove,
    this.didReplace,
    this.overridePopBehavior = true,
    this.tabsHeight = 60,
  }) : super(key: key);

  @override
  BuiltTabNavigatorState<T> createState() => BuiltTabNavigatorState<T>();
}

class BuiltTabNavigatorState<T extends EnumClass>
    extends State<BuiltTabNavigator> {
  Map<T, GlobalKey<NavigatorState>> _navigatorKeys;
  Map<T, GlobalKey<TabNavigatorState>> _tabNavigatorKeys;
  T _currentTab;

  Map<T, NavigatorState> get navigatorKeys {
    return _navigatorKeys.map((tab, navigatorKey) {
      return MapEntry(tab, navigatorKey.currentState);
    });
  }

  @override
  void initState() {
    super.initState();
    _currentTab =
        widget.activeTab != null ? widget.activeTab : widget.tabs.keys.first;
    _navigatorKeys = widget.tabs.map((tab, _) {
      return MapEntry(tab, GlobalKey<NavigatorState>());
    });
    _tabNavigatorKeys = widget.tabs.map((tab, _) {
      return MapEntry(tab, GlobalKey<TabNavigatorState>());
    });
  }

  @override
  Widget build(BuildContext context) {
    _currentTab = widget.activeTab ?? _currentTab;
    final Widget body = widget.bodyBuilder != null
        ? widget.bodyBuilder(context, _buildTabs(), _buildTabViews())
        : _defaultBodyBuilder(context, _buildTabs(), _buildTabViews());
    return widget.overridePopBehavior
        ? WillPopScope(
            onWillPop: () async {
              return !await _navigatorKeys[_currentTab].currentState.maybePop();
            },
            child: widget.bodyBuilder != null
                ? widget.bodyBuilder(context, _buildTabs(), _buildTabViews())
                : _defaultBodyBuilder(context, _buildTabs(), _buildTabViews()),
          )
        : body;
  }

  /// returns internal [NavigatorState] of give [T] tab
  NavigatorState getTabNavigatorState(T tab) {
    if (_navigatorKeys == null) {
      return null;
    }
    return _navigatorKeys[tab].currentState;
  }

  /// returns internal [BuildContext] of give [T] tab
  ///
  BuildContext getTabNavigatorBuildContext(T tab) {
    if (_navigatorKeys == null) {
      return null;
    }
    return _tabNavigatorKeys[tab].currentState.buildContext;
  }

  _defaultBodyBuilder(
    BuildContext context,
    List<Widget> tabs,
    Widget tabsView,
  ) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: tabsView,
          ),
        ),
        Container(
          height: widget.tabsHeight,
          child: Material(
            elevation: 9,
            // color: Colors.red,
            shadowColor: Colors.black,
            child: Container(
              // decoration: BoxDecoration(color: Colors.red),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: tabs,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTabs() {
    return widget.tabs
        .map((tab, definition) {
          return MapEntry(
            tab,
            _buildTab(
              context,
              tab,
              definition,
              _currentTab == tab,
            ),
          );
        })
        .values
        .toList();
  }

  Widget _buildTabViews() {
    return Stack(
      children: widget.tabs
          .map((tab, definition) {
            return MapEntry(
                tab,
                _buildTabView(
                  context,
                  tab,
                  definition,
                  _currentTab == tab,
                ));
          })
          .values
          .toList(),
    );
  }

  Widget _buildTab(
    BuildContext context,
    T tab,
    TabRoutesDefinition definition,
    bool isSelected,
  ) {
    final Color color = _currentTab == tab
        ? widget.activeTabColor ?? Colors.blue[400]
        : widget.inactiveTabColor ?? Colors.grey[400];
    final tapHandler = () {
      if (widget.tabTap != null) {
        widget.tabTap(tab);
      }
      setState(() {
        _currentTab = tab;
      });
    };
    final Widget title = widget.titleBuilder != null
        ? widget.titleBuilder(context, tab, definition, _currentTab == tab)
        : Text(
            definition.tabTitle ?? "",
            style: TextStyle(
              color: color,
            ),
          );
    final Widget icon = widget.iconBuilder != null
        ? widget.iconBuilder(context, tab, definition, _currentTab == tab)
        : Icon(
            definition.tabIcon,
            color: color,
          );
    return widget.tabBuilder != null
        ? GestureDetector(
            onTap: tapHandler,
            child: widget.tabBuilder(
                context, tab, definition, isSelected, title, icon, tapHandler),
          )
        : Expanded(
            child: InkWell(
            // customBorder: BorderRadius.circular(10),
            // radius: constraints.maxHeight / 2,
            onTap: tapHandler,
            child: Container(
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[]
                  ..addAll(icon != null
                      ? [
                          icon,
                        ]
                      : [])
                  ..add(title),
              ),
            ),
          ));
  }

  Widget _buildTabView(
    BuildContext context,
    T tab,
    TabRoutesDefinition definition,
    bool isSelected,
  ) {
    return Offstage(
      offstage: _currentTab != tab,
      child: TabNavigator<T>(
        tab: tab,
        key: _tabNavigatorKeys[tab],
        navigatorKey: _navigatorKeys[tab],
        initialRoute: definition.initialRoute.name,
        routes: definition.routes,
        didPop: widget.didPop,
        didPush: widget.didPush,
        didRemove: widget.didRemove,
        didReplace: widget.didReplace,
        onGenerateRoute: (routeSettings, route) {
          final onGenerateRoute = widget.onGenerateRoute;
          if (onGenerateRoute != null) {
            onGenerateRoute(routeSettings, tab, route);
          }
        },
      ),
    );
  }
}

class TabRoutesDefinition<T extends EnumClass> {
  final Map<EnumClass, WidgetBuilder> routes;
  final EnumClass initialRoute;
  final String tabTitle;
  final IconData tabIcon;

  TabRoutesDefinition({
    @required this.routes,
    @required this.initialRoute,
    this.tabTitle,
    this.tabIcon,
  });
}
