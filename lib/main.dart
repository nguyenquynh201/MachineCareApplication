import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:machine_care/routers/app_routes.dart';
import 'package:machine_care/translation/app_translation.dart';
import 'package:overlay_support/overlay_support.dart';
import 'constants/app_values.dart';
import 'firebase_options.dart';
import 'routers/app_pages.dart';
import 'services/service.dart';
import 'ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      await setupLocator();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );

      FireBaseServices.instance.requestPermission();
      await AppPref.initListener();
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
  final FlutterLocalNotificationsPlugin _localPlugin =
  FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DataFilter.banners.value = AppPref.banner.map((e) => e).toList();
    _handleFirebase();

  }
  /// Handle firebase
  ///
  ///
  void _handleFirebase() async {
    _initLocalPlugin();
    handleOnMessage();
    handleInitialMessage();
  }

  /// Handle initial message
  void handleInitialMessage() async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message == null) {
        return;
      }
      print('handleInitialMessage');
      _handleEventTap(message);
    });
  }

  /// Handle on message
  void handleOnMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('handleOnMessage');

      _handleEventTap(message);
    });
  }

  /// Handle event tap
  void _handleEventTap(RemoteMessage message) async {
    int sId = Random().nextInt(999);

    /// Handle event in app
    await _showBannerNotification(sId, message.notification!.title!,
        message.notification!.body!, json.encode(message.data));

    /// Tap in app
    _tapEvenNotification(callback: (String? payload) {
      final value = json.decode(payload!);
      NotificationData data = NotificationData.fromJson(value);
      switch (data.type) {

      }
    });
  }

  /// Init local plugin
  void _initLocalPlugin() {
    var androidSettings = AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSSettings = IOSInitializationSettings();
    var initSettings =
    InitializationSettings(android: androidSettings, iOS: iOSSettings);
    _localPlugin.initialize(initSettings);
  }

  /// Tap event notification
  void _tapEvenNotification({Function(String? payload)? callback}) {
    var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) =>
            callback!(payload));
    var initSettings =
    InitializationSettings(android: androidSettings, iOS: iOSSettings);
    _localPlugin.initialize(initSettings,

        /// Tap notification
        onSelectNotification: callback);
  }

  /// Show banner notification
  Future<void> _showBannerNotification(
      int? sId, String title, String notification, String payload) async {
    final notificationPlugin = FlutterLocalNotificationsPlugin();

    // var androidSettings = AndroidInitializationSettings('mipmap/ic_launcher');

    /// Set android platform
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('mChannelID', 'mChannelName',
        channelDescription: 'mChannelDescription',
        channelShowBadge: true,
        onlyAlertOnce: true,
        importance: Importance.max,
        priority: Priority.high);

    /// Set iOS platform
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
    IOSNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    if (sId == null) {
      sId = 0;
    }
    await notificationPlugin.show(
        sId, title, notification, platformChannelSpecifics,
        payload: payload);
  }

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
                  case Routes.login:
                    return MaterialPageRoute(builder: (_) => LoginScreen());
                  case Routes.mainNavigation:
                    return MaterialPageRoute(builder: (_) => MainNavigationScreen());
                }
                return null;
              },
              initialRoute: Routes.navigation,
              builder: appBuilder,
              navigatorKey: AppPages.navigationKey,
              navigatorObservers: [defaultLifecycleObserver],
              // initialBinding: NavigationBinding(),
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
