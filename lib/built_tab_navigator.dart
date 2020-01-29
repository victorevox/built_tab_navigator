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
      Function() cb) tabBuilder;

  // /// Builds a
  // final Widget Function(
  //   BuildContext context,
  //   T tab,
  //   TabRoutesDefinition definition,
  //   bool isSelected,
  // ) tabViewBuilder;

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
  final Function(RouteSettings routeSettings, T tab, EnumClass route) onGenerateRoute;

  /// Set [activetab], if not defined will default to the firs [tab] key defined at [tabs]
  final T activeTab;

  BuiltTabNavigator({
    Key key,
    @required this.tabs,
    this.bodyBuilder,
    this.tabBuilder,
    this.activeTabColor,
    this.tabTap,
    this.inactiveTabColor,
    this.titleBuilder,
    this.iconBuilder, this.onGenerateRoute, this.activeTab,
  }) : super(key: key);

  @override
  _BuiltTabNavigatorState<T> createState() => _BuiltTabNavigatorState<T>();
}

class _BuiltTabNavigatorState<T extends EnumClass>
    extends State<BuiltTabNavigator> {
  Map<T, GlobalKey<NavigatorState>> _navigatorKeys;
  T _currentTab;

  @override
  void initState() {
    super.initState();
    _currentTab = widget.activeTab != null? widget.activeTab : widget.tabs.keys.first;
    _navigatorKeys = widget.tabs.map((index, _) {
      return MapEntry(index, GlobalKey<NavigatorState>());
    });
  }

  @override
  Widget build(BuildContext context) {
    _currentTab = widget.activeTab?? _currentTab;
    return widget.bodyBuilder != null
        ? widget.bodyBuilder(context, _buildTabs(), _buildTabViews())
        : _defaultBodyBuilder(context, _buildTabs(), _buildTabViews());
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
          height: 60,
          child: Material(
            elevation: 26,
            color: Colors.black,
            shadowColor: Colors.black,
            child: BottomAppBar(
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: tabs,
                ),
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
                  ..addAll(definition.tabIcon != null
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
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tab],
        initialRoute: definition.initialRoute.name,
        routes: definition.routes,
        onGenerateRoute: (routeSettings, route) {
          if (widget.onGenerateRoute != null) {
            widget.onGenerateRoute(routeSettings, tab, route);
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
