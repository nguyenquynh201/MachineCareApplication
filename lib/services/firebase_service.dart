import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


typedef HandleMessageCallback = Function(RemoteMessage);
typedef HandleMessageCallbackApp = Function(RemoteMessage);
typedef HandleMessageCallbackInApp = Function(String);

class FireBaseServices {
  FireBaseServices._() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    ///iOS Configuration
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  static FireBaseServices? _instance;

  static FireBaseServices get instance {
    _instance ??= FireBaseServices._();
    return _instance!;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  late InitializationSettings initializationSettings;
  AndroidInitializationSettings initializationSettingsAndroid =
  const AndroidInitializationSettings('@mipmap/ic_launcher');
  IOSInitializationSettings initializationSettingsIOS =
  const IOSInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );

  // request Permission User
  void requestPermission() async {
    // var iOSSettings = IOSInitializationSettings(
    //     onDidReceiveLocalNotification:
    //         (int id, String? title, String? body, String? payload) =>
    //             callbackInApp!(payload));
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (vale) {});
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> setupInteractedMessage(
      {HandleMessageCallback? callback,
        HandleMessageCallbackApp? callbackInApp}) async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      callback?.call(initialMessage);
      // callbackInApp?.call(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(callback);
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //   LogUtils.methodIn(message: message.toMap().toString());
    //   LogUtils.methodIn(message: "$message");
    //   print("${message.toMap().toString()}");
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification!.android;
    //   if (notification != null) {
    //     /// Handle event tap
    //     flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channelDescription: channel.description,
    //             icon: android?.smallIcon,
    //           ),
    //           iOS: IOSNotificationDetails()),
    //     );
    //   }
    // });
    // FirebaseMessaging.onMessage.listen(callbackInApp);
  }

// void _handleMessageInApp(RemoteMessage message) async {
//   int sId = Random().nextInt(999);
//
//   /// Handle event in app
//   await _showBannerNotification(sId, message.notification!.title!,
//       message.notification!.body!, json.encode(message.data));
//
//   /// Tap in app
//   // requestPermission(callbackInApp: (String? payload) {
//   //   final value = json.decode(payload!);
//   //   LogUtils.methodIn(message: "$value");
//   NotificationData data = NotificationData.fromJson(message.data);
//   print("1 1 1 1 ${sId}");
//   switch (message.data['type']) {
//     case "todo":
//       NavigationServices.navigationKey.currentState!.push(
//         MaterialPageRoute(
//           builder: (_) => TaskDetailView(taskId: message.data['id']),
//         ),
//       );
//       break;
//     case "internal":
//       NavigationServices.navigationKey.currentState!.push(
//         MaterialPageRoute(
//           builder: (_) => NotificationView(),
//         ),
//       );
//       break;
//   }
//
//   // });
// }

// /// Show banner notification
// Future<void> _showBannerNotification(
//     int? sId, String title, String notification, String payload) async {
//   final notificationPlugin = FlutterLocalNotificationsPlugin();
//
//   /// Set android platform
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails('mChannelID', 'mChannelName',
//           channelDescription: 'mChannelDescription',
//           channelShowBadge: true,
//           onlyAlertOnce: true,
//           importance: Importance.max,
//           priority: Priority.high);
//
//   /// Set iOS platform
//   const IOSNotificationDetails iOSPlatformChannelSpecifics =
//       IOSNotificationDetails(
//           presentAlert: true, presentBadge: true, presentSound: true);
//
//   const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics);
//   if (sId == null) {
//     sId = 0;
//   }
//   await notificationPlugin.show(
//       sId, title, notification, platformChannelSpecifics,
//       payload: payload);
// }
}
