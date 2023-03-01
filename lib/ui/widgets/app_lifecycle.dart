import 'package:flutter/cupertino.dart';

class AppLifecycleWatcher extends StatefulWidget {
  final Widget child;

  const AppLifecycleWatcher({Key? key, required this.child}) : super(key: key);

  @override
  State<AppLifecycleWatcher> createState() => _AppLifecycleWatcherState();
}

class _AppLifecycleWatcherState extends State<AppLifecycleWatcher> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      // if (Get.isRegistered<ChatController>()) {
      //   FlutterAppBadger.updateBadgeCount(Get.find<ChatController>().getNumBadge());
      // }

    }
    if (state == AppLifecycleState.resumed) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
