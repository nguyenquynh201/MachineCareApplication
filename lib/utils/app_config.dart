import 'package:flutter/cupertino.dart';
class AppConfig extends InheritedWidget {
  final Widget childWidget;
  const AppConfig({Key? key, required this.childWidget})
      : super(key: key, child: childWidget);

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}