import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  navigate(Widget widget) {
    return navigationKey.currentState!
        .push(MaterialPageRoute(builder: (context) => widget));
  }

  void goBack() {
    if (navigationKey.currentState?.canPop() ?? false) {
      navigationKey.currentState?.pop();
    }
  }
}
