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
