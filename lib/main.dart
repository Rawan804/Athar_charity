import 'package:Athar_Charity/cubit/updateProfile/update_profile_cubit.dart';
import 'package:Athar_Charity/cubit/updateProfile/update_profile_donor_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cubit/updateProfile/update_profile_volunteer_cubit.dart';
import 'firebase_options.dart';
import 'NotificationScreen.dart';

// Cubits
import 'cubit/notifications/notification_cubit.dart';
import 'cubit/Theme/theme_cubit.dart';
import 'cubit/BottomBar Cubit/bottomba_cubit.dart';
import 'cubit/Categories_cubit/categories_cubit.dart';
import 'cubit/Sub_project/Subproject_cubit.dart';
import 'cubit/DetailsCubit/DetailsCubit.dart';
import 'cubit/voulnteerCubit/voulnteerDetails_cubit.dart';
import 'cubit/voulnteerCubit/voulnteer_cubit.dart';
import 'cubit/CartCubit/cart_cubit.dart';
import 'cubit/Beneficary/beneficary_cubit.dart';
import 'cubit/login/login_cubit.dart';
import 'cubit/Logout/logout_cubit.dart';
import 'cubit/Achievements/achievements_cubit.dart';
import 'cubit/Achievements/achievements_details_cubit.dart';
import 'cubit/EmDetails/EmDetails_Cubite.dart';
import 'cubit/Emergency/Emergency_cubite.dart';
import 'cubit/RegisterDonator/RegisterDonator_cubit.dart';
import 'cubit/RegisterVoulnteer/RegisterVoulnteer_cubite.dart';
import 'cubit/Wallet/wallet_cubit.dart';

// Pages
import 'home.dart';
import 'cart.dart';
import 'voulnteer.dart';
import 'Setting.dart';
import 'Emergency.dart';

// Global navigator key
final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

// Local Notifications Plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _showLocalNotification(message);
  print(" رسالة في الخلفية: ${message.messageId}");
}

// عرض إشعار محلي
Future<void> _showLocalNotification(RemoteMessage message) async {
  String? title = message.notification?.title ?? message.data['title'];
  String? body = message.notification?.body ?? message.data['body'];

  if (title == null && body == null) return;

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'default_channel',
    'Default',
    channelDescription: 'Default notification channel',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );

  const NotificationDetails platformDetails =
  NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    message.hashCode,
    title,
    body,
    platformDetails,
  );
}

// تهيئة الإشعارات المحلية
Future<void> _initLocalNotifications() async {
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings =
  InitializationSettings(android: androidSettings, iOS: null);

  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (details) {
      navigatorkey.currentState?.pushNamed("notifications");
    },
  );

  // إنشاء قناة الإشعارات
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'default_channel',
    'Default',
    description: 'Default notification channel',
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
    showBadge: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

Future<void> main() async {
  // إشعار تجريبي عند فتح التطبيق
  // Future<void> _sendTestNotification() async {
  //   RemoteMessage testMessage = RemoteMessage(
  //     data: {
  //       'title': 'إشعار تجريبي',
  //       'body': 'هذا إشعار لتجربة الإشعارات المحلية.'
  //     },
  //     notification: RemoteNotification(
  //       title: 'إشعار تجريبي',
  //       body: 'هذا إشعار لتجربة الإشعارات المحلية.',
  //     ),
  //   );
  //
  //   await _showLocalNotification(testMessage);
  // }

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize local notifications
  await _initLocalNotifications();

  // Request permissions
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false,
  );

  print(" حالة صلاحية الإشعارات: ${settings.authorizationStatus}");

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $fcmToken");

    // حفظ التوكن محلياً
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', fcmToken ?? '');
  }

  // Foreground message listener
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print(" إشعار في المقدمة: ${message.notification?.title}");
    await _showLocalNotification(message);
  });

  // Open app from background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    navigatorkey.currentState?.pushNamed("notifications");
  });

  // Open app from terminated state
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    navigatorkey.currentState?.pushNamed("notifications");
  }

  final themeCubit = ThemeCubit();
  await themeCubit.setInitialTheme();
// إرسال إشعار تجريبي للتأكد من عمل الإشعارات
//  await _sendTestNotification();
 
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: "assets/translate", // 🔹 مجلد الترجمات عندك
      saveLocale: true,
      fallbackLocale: const Locale('en'),
      child: MyApp(themeCubit: themeCubit),
    )
   // OverlaySupport.global(child: MyApp(themeCubit: themeCubit)),


  );
}

class MyApp extends StatelessWidget {
  final ThemeCubit themeCubit;
  const MyApp({super.key, required this.themeCubit});

  @override
  Widget build(BuildContext context) {
    final lang= context.locale.languageCode;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavigationCubit()),
        BlocProvider(create: (_) => CategoriesCubit()),
        BlocProvider(create: (_) => SubprojectCubit()),
        BlocProvider(create: (_) => Detailscubit()),
        BlocProvider(create: (_) => VolunteerCubit()),
        BlocProvider(create: (_) => VolunteerdetailsCubite()),
        BlocProvider(create: (_) => CartCubit(lang)),
        BlocProvider(create: (_) => BeneficaryCubit()),
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => LogoutCubit()),
        BlocProvider.value(value: themeCubit),
        BlocProvider(create: (_) => AchievementsCubit()),
        BlocProvider(create: (_) => AchievementsDetailsCubit()),
        BlocProvider(create: (_) => NotificationCubit()),
        BlocProvider(create: (_) => EmergencyCubite()),
        BlocProvider(create: (_) => EmdetailsCubite()),
        BlocProvider(create: (_) => RegisterDonatorCubit()),
        BlocProvider(create: (_) => RegisterVoulnteerCubit()),
        BlocProvider(create: (_) => WalletCubit(lang)),
        BlocProvider(create: (_) => UpdateProfileCubit()),
        BlocProvider(create: (_) => UpdateProfileDonorCubit()),
        BlocProvider(create: (_) => UpdateProfileVolunteerCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            navigatorKey: navigatorkey,
            theme: state.themeData,
            debugShowCheckedModeBanner: false,
            routes: {
              "cart": (_) => Cart(),
              "volunteer": (_) => Voulnteer(),
              "home": (_) => Home(),
              "setting": (_) => Setting(),
              "emergency": (_) => Emergency(),
              "notifications": (_) => NotificationsScreen(),
            },
            home: Home(),
          );
        },
      ),
    );
  }
}
