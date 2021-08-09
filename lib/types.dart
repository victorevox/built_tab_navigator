part of built_tab_navigator;

typedef TabContentWrapBuilder = Widget Function(
    BuildContext context, EnumClass? tab, bool isActive, Widget content);
typedef OnGenerateRouteFn<T> = Route<dynamic> Function(
    RouteSettings routeSettings, T tab, EnumClass route, WidgetBuilder? child);
typedef IconBuilder<T> = Widget Function(
  BuildContext context,
  T tab,
  TabRoutesDefinition definition,
  bool isSelected,
);
typedef BodyBuilder = Widget Function(
  BuildContext context,
  List<Widget> tabs,
  Widget tabsViewsContainer,
);
typedef TabBuilder<T> = Widget Function(
  BuildContext context,
  T tab,
  TabRoutesDefinition definition,
  bool isSelected,
  Widget title,
  Widget icon,
  Function() cb,
);
typedef TitleBuilder<T> = Widget Function(
  BuildContext context,
  T tab,
  TabRoutesDefinition definition,
  bool isSelected,
);
