## [0.2.0] - 1/03/20.

* Change `built_value` dependencies to 7.0.x

## [0.1.7] - 20/02/20.

* Changed behavior of [onGenerateRoute] prperty, now it can be used to override the [Route] returned by `onGenerateRoute` of [Navigator].
* Added an opacity transition when changing tabs, transition can be customized by [contentAnimationDuration] property.
* Added ability to implement a custom builder to override each tab content wrapper, this can be used to implement a custom animation

## [0.1.6] - 30/01/20.

* Added new property ```tabsHeight```
* Removed use of [`BottomNavigationBar`] to prevent errors when not using the widget inside `Scaffold` or weird styles overrides
* Fix `iconBuilder` not being called if not `tabIcon` was defined

## [0.1.5] - 30/01/20.

* Added new API ```overridePopBehavior``` to allow nested navigation to pop just inner stack or root navigator if prefered

## [0.1.4] - 28/01/20.

* Added navigation observer callbacks
* Added ```BuiltTabNavigatorState``` API to get inner navigator routeContext ```getTabNavigatorState```
* Update README.md

## [0.1.3] - 28/01/20.

* Expose ```BuiltTabNavigatorState``` so it can be accesed via ```GlobalKey<BuiltTabNavigatorState>```

## [0.1.2] - 28/01/20.

* Added new getter to state: `navigatorKeys`, useful for retriving tabs NavigatorState , ie: via ```GlobalKey<State<BuiltTabNavigator>>```
## [0.1.1] - 28/01/20.

* Updated README
* New ```tabContainerBackgroundColor``` property

## [0.1.0] - 28/01/20.

* Initial release

## [0.0.1] - TODO: Add release date.

* TODO: Describe initial release.
