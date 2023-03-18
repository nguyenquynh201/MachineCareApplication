import 'dart:async';
import 'dart:io';
import 'package:machine_care/device.dart';
import 'package:machine_care/routers/app_routes.dart';
import 'package:machine_care/translation/app_translation.dart';
import 'package:overlay_support/overlay_support.dart';
import 'constants/app_values.dart';
import 'routers/app_pages.dart';
import 'ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'utils/utils.dart';
import 'package:lifecycle/lifecycle.dart';
void main() async => MyApp.appRunner();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static Future<void> appRunner() async {
    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await AppPref.initListener();
      final id = await DeviceService.getDeviceId();
      print("iddd $id");
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      await OneSignal.shared.setAppId(AppValues.oneSignalID);
      if (!Platform.isIOS) {
        OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) async {
          AppLogger.getLogger().shout("Accepted permission: $accepted");
        });
      }
      runApp(const AppLifecycleWatcher(
        child: AppConfig(
          childWidget: MyApp(),
        ),
      ));
    }, (error, stack) {
      AppLogger.getLogger().shout(error.toString());
      AppLogger.getLogger().shout(stack.toString());
    });
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        builder: (context, widget) {
          return OverlaySupport.global(
            child: GetMaterialApp(
              enableLog: true,
              logWriterCallback: localLogWriter,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: (RouteSettings settings) {
                switch (settings.name) {
                  case Routes.navigation:
                    return MaterialPageRoute(builder: (_) => NavigationScreen());
                }
                return null;
              },
              initialRoute: Routes.navigation,
              builder: appBuilder,
              navigatorObservers: [defaultLifecycleObserver],
              initialBinding: NavigationBinding(),
              // theme: appThemeData,
              defaultTransition: Transition.fadeIn,
              getPages: AppPages.pages,
              locale: Locale(AppPref.locale!),
              translationsKeys: AppTranslation.translations,
            ),
          );
        });
  }
  void localLogWriter(String text, {bool isError = false}) {
    AppLogger.getLogger().shout(text);
  }
  Widget appBuilder(BuildContext context, Widget? child) {
    AppValues.scaleSize(context);
    ScreenUtil.init(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: child ?? const SizedBox(),
      ),
    );
  }
}
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
