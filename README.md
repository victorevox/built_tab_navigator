# built_tab_navigator

Creates a Tab Style UI with Navigation capabilities.

This Plugin is intended to be used in conjuntion with [built_value](://pub.dev/packages/built_value) & [built_collection](https://github.com/google/built_collection.dart) since some of the API properties expect  `EnumClass` objects.

# 💻 Installation
In the `dependencies:` section of your `pubspec.yaml`, add the following line:

```yaml
dependencies:
  built_tab_navigator: <latest version>
```

# ❔ Usage

### Import this class

```dart
import 'package:built_tab_navigator/built_tab_navigator.dart';
```

### Default Tav

<img src="https://raw.githubusercontent.com/victorevox/built_tab_navigator/master/example/Screenshot_1.png" align = "right" height = "350" alt="Network">

```dart
BuiltTabNavigator(
        tabs: {
          ExampleTabs.example1: TabRoutesDefinition(
            initialRoute: Example1Routes.root,
            routes: example1Routes,
            tabTitle: "Example 1",
            tabIcon: Icons.ac_unit,
          ),
          ExampleTabs.example2: TabRoutesDefinition(
            initialRoute: Example2Routes.root,
            routes: example2Routes,
            tabTitle: "Example 2",
            tabIcon: Icons.accessibility_new,
          ),
          ExampleTabs.example3: TabRoutesDefinition(
            initialRoute: Example2Routes.root,
            routes: example3Routes,
            tabTitle: "Example 3",
            tabIcon: Icons.adb,
          ),
        },
      )
  ```

### Try Custom Builders

  <img src="https://raw.githubusercontent.com/victorevox/built_tab_navigator/master/example/Screenshot_3.png" align = "right" height = "350" alt="Network">

```dart
BuiltTabNavigator(
    iconBuilder: (context, tab, definition, selected) {
        return Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(definition.tabIcon, color: selected? Colors.white : Colors.black,),
        );
    },
    titleBuilder: (context, tab, definition, selected) {
        return Text(definition.tabTitle, style: TextStyle(fontSize: 20, color: selected? Colors.purple : Colors.grey),);
    },
    tabs: {
        ExampleTabs.example1: TabRoutesDefinition(
        initialRoute: Example1Routes.root,
        routes: example1Routes,
        tabTitle: "Example 1",
        tabIcon: Icons.ac_unit,
        ),
        ExampleTabs.example2: TabRoutesDefinition(
        initialRoute: Example2Routes.root,
        routes: example2Routes,
        tabTitle: "Example 2",
        tabIcon: Icons.accessibility_new,
        ),
        ExampleTabs.example3: TabRoutesDefinition(
        initialRoute: Example2Routes.root,
        routes: example3Routes,
        tabTitle: "Example 3",
        tabIcon: Icons.adb,
        ),
    },
)
```
### Changing Layout is super easy!

  <img src="https://raw.githubusercontent.com/victorevox/built_tab_navigator/master/example/Screenshot_5.png" align = "right" height = "350" alt="Network">

```dart
BuiltTabNavigator(
    activeTabColor: Colors.red,
    inactiveTabColor: Colors.white,
    bodyBuilder: (context, tabs, tabView) {
        return Column(
        children: <Widget>[
            Material(
            elevation: 9,
            color: Colors.blue[200],
            child: Container(
                height: 100,
                child: Row(
                children: tabs,
                ),
            ),
            ),
            Expanded(
            child: tabView,
            ),
        ],
        );
    },
    tabs: {
        ExampleTabs.example1: TabRoutesDefinition(
        initialRoute: Example1Routes.root,
        routes: example1Routes,
        tabTitle: "Example 1",
        tabIcon: Icons.ac_unit,
        ),
        ExampleTabs.example2: TabRoutesDefinition(
        initialRoute: Example2Routes.root,
        routes: example2Routes,
        tabTitle: "Example 2",
        tabIcon: Icons.accessibility_new,
        ),
        ExampleTabs.example3: TabRoutesDefinition(
        initialRoute: Example2Routes.root,
        routes: example3Routes,
        tabTitle: "Example 3",
        tabIcon: Icons.adb,
        ),
    },
)
```

## Available API Options

```dart
  /// Defines default [selectedTab]

  /// Defines the [tabs] of this widget
  /// Each [tab] must define a [TabRoutesDefinition]
  final Map<T, TabRoutesDefinition> tabs;

  /// Defines a [bodyBuilder], if you need something very custom, maybe the tabs located at different position: ie on Top
  /// you can place [tabs] and [tabsViews] in a custom layout arrangement
  final BodyBuilder bodyBuilder;

  /// Builds a custom [tab] widget for each tab, make sure to call the [cb] parameter if you're using a custom [GestureDetector|InkWell]  or whatever widget that could handle touch events
  /// calling [cb] will trigger state build and change tab content as expected
  final TabBuilder<T> tabBuilder;

  /// Defines [Color] used for the tab [title] and [icon] when [tab] is active
  final Color activeTabColor;

  /// Defines [Color] used for the tab [title] and [icon] when [tab] is inactive
  final Color inactiveTabColor;

  /// Defines a tap handler when a [tab]
  final Function(T) tabTap;

  /// Builds a custom [title] [Widget]
  final TitleBuilder<T> titleBuilder;

  /// Builds a custom [icon] [Widget]
  final IconBuilder<T> iconBuilder;

  /// Called everytime a route is being generated, it passes
  /// the actual [RouteSettings],
  /// the tab [T] who owns that navigator,
  /// the actual route [EnumClass] used to produce the page
  /// and the page builder [WidgetBuilder] based on the routes defined
  /// This can be used to return a custom PageRoute Wrapper like `MaterialPageRoute` or wraps the builder with a custom animation, etc
  final OnGenerateRouteFn<T> onGenerateRoute;

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

  /// Defines a cutom builder for the widget that wraps each tab content,
  /// This can be useful for bulding a Widget that implements a custom animation
  /// params:
  /// [BuildContext] The current context
  /// [EnumClass] The current `tab` being builded
  /// [bool] if the current `tab` is active
  /// [Widget] The actual content to be wraped, you neend to pass this widget as a child of your Widget implementation
  final TabContentWrapBuilder contentWrapBuilder;

  /// Define a custom duration for the opacity transition implemented
  /// This has no effect if you're implementing a custom [contentWrapBuilder]
  /// Defaults to [Duration(400ms)]
  final Duration contentAnimationDuration;
```

## Screenshots
<img src="https://raw.githubusercontent.com/victorevox/built_tab_navigator/master/example/Screenshot_2.png"  height = "350" alt="Network">
<img src="https://raw.githubusercontent.com/victorevox/built_tab_navigator/master/example/example.gif"  height = "350" alt="Network">
<img src="https://raw.githubusercontent.com/victorevox/built_tab_navigator/master/example/Screenshot_4.png"  height = "350" alt="Network">

You can try the [example](https://github.com/victorevox/built_tab_navigator/tree/master/example)

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
