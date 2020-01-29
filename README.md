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

<img src="" align = "right" height = "350" alt="Network">

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

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
