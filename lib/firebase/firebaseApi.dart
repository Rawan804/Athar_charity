// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:overlay_support/overlay_support.dart';
//
//
// import '../NotificationScreen.dart';
//
// // class FirebaseApi{
// //   getToken()async{
// //     String? Mytoken = await FirebaseMessaging.instance.getToken();
// //     print("==================================");
// //     print(Mytoken);
// //   }
// //
// //
// // }
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import '../main.dart'; // يحتوي على navigatorKey
//
// class FireBaseNotification with WidgetsBindingObserver {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   bool _isAppInForeground = true;
//
//   FireBaseNotification() {
//     WidgetsBinding.instance.addObserver(this); // لمراقبة حالة التطبيق
//   }
//
//   Future<void> initNotification() async {
//     await _firebaseMessaging.requestPermission();
//
//     String? token = await _firebaseMessaging.getToken();
//     print("Firebase token: $token");
//
//     //  لحالة التطبيق مغلق (terminated)
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if (message != null) {
//         print("App opened from terminated state via notification");
//         _handleMessage(message);
//       }
//     });
//
//     // استماع لحالة التطبيق بالخلفية وضغط على الإشعار
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       print("App opened from background via notification");
//       _handleMessage(message);
//     });
//
//     // استماع للإشعارات الواردة أثناء فتح التطبيق (foreground)
//
//
//     FirebaseMessaging.onMessage.listen((message) {
//       print("Notification received while app in foreground");
//       if (message.notification != null && _isAppInForeground) {
//         showSimpleNotification(
//           Text(message.notification!.title ?? 'يوجد إشعار'),
//           background: Colors.white,
//           position: NotificationPosition.top,
//         );
//       }
//     });
//
//   }
//
//   void _handleMessage(RemoteMessage message) {
//     navigatorkey.currentState?.push(
//       MaterialPageRoute(
//         builder: (context) => NotificationsScreen(),
//       ),
//     );
//   }
//
//   // مراقبة حالة التطبيق (foreground/background)
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _isAppInForeground = true;
//       print("App is in foreground");
//     } else {
//       _isAppInForeground = false;
//       print("App is in background or inactive");
//     }
//   }
//
//   // تنظيف Observer عند إلغاء الكائن
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//   }
// }
