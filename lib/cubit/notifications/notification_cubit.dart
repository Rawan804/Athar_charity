
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../api/api.dart';
import '../../model/notificationModel.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial()) {
    _initLocalNotifications();
    initFCM();
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// تهيئة الإشعارات المحلية
  void _initLocalNotifications() async {
    print(" تهيئة الإشعارات المحلية في NotificationCubit...");

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
    InitializationSettings(android: androidSettings, iOS: null);

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        print("تم الضغط على الإشعار المحلي");
        // هنا يمكنك فتح صفحة معينة
      },
    );

    // إنشاء قناة الإشعارات
    await _createNotificationChannel();
  }

  /// إنشاء قناة الإشعارات
  Future<void> _createNotificationChannel() async {
    print(" إنشاء قناة الإشعارات...");

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

    print(" تم إنشاء قناة الإشعارات");
  }

  /// تهيئة Firebase والاستماع للإشعارات
  Future<void> initFCM() async {
    print(" تهيئة FCM في NotificationCubit...");

    await _requestPermission();
    await _saveFcmTokenToServer();

    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(" إشعار في المقدمة: ${message.notification?.title}");
      await _showLocalNotification(message); // لازم تستخدم await
      await fetchNotifications();
    });


    // Background / Terminated
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(" إشعار تم فتحه من الخلفية");
      _handleMessage(message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(" فتح التطبيق من terminated state");
        _handleMessage(message);
      }
    });

    print(" تم تهيئة FCM بنجاح");
  }

  Future<void> _requestPermission() async {
    print(" طلب صلاحيات الإشعارات...");

    NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      criticalAlert: false,
      announcement: false,
    );

    print(" حالة صلاحية الإشعارات: ${settings.authorizationStatus}");

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      print(' لم يتم منح صلاحية الإشعارات');
    }
  }

  Future<void> _saveFcmTokenToServer() async {
    print(" حفظ FCM Token على السيرفر...");


    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('donor_token')
        ?? prefs.getString('beneficiary_token')
        ?? prefs.getString('volunteer_token');

    String? fcmToken = await FirebaseMessaging.instance.getToken();

    print("FCM Token: $fcmToken");
    await prefs.setString('fcm_token', fcmToken!);
  
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/update-fcm-token'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'fcm_token': fcmToken}),
      );

      if (response.statusCode == 200) {
        print(" FCM Token تم حفظه على السيرفر");
      } else {
        print(" فشل حفظ FCM Token. رمز: ${response.statusCode}");
        print(" استجابة السيرفر: ${response.body}");
      }
    } catch (e) {
      print("خطأ عند حفظ FCM Token: $e");
    }
    }

  /// التعامل مع أي رسالة FCM
  void _handleMessage(RemoteMessage message) {
    print("�� معالجة إشعار جديد: ${message.notification?.title ?? 'Data-only'}");
    print("�� بيانات الرسالة: ${message.data}");

    _showLocalNotification(message);
    fetchNotifications();
  }

  /// عرض إشعار محلي
  Future<void> _showLocalNotification(RemoteMessage message) async {
    print(" عرض إشعار محلي...");

    RemoteNotification? notification = message.notification;

    String? title = notification?.title ?? message.data['title'];
    String? body = notification?.body ?? message.data['body'];

    if (title == null && body == null) {
      print(" لا يوجد عنوان أو محتوى للإشعار");
      return;
    }

    print(" عنوان الإشعار: $title");
    print(" محتوى الإشعار: $body");

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'default_channel',
      'Default',
      channelDescription: 'Default notification channel',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,

      icon: '@mipmap/ic_launcher',

    );

    const NotificationDetails details =
    NotificationDetails(android: androidDetails);

    try {
      await flutterLocalNotificationsPlugin.show(
        message.hashCode,
        title,
        body,
        details,
      );
      print("تم عرض الإشعار المحلي بنجاح");
    } catch (e) {
      print(" خطأ في عرض الإشعار المحلي: $e");
    }
  }

  /// جلب الإشعارات من السيرفر
  Future<void> fetchNotifications() async {
    print(" جلب الإشعارات من السيرفر...");

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('donor_token')
        ?? prefs.getString('beneficiary_token')
        ?? prefs.getString('volunteer_token');


    emit(NotificationLoading());

    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/notifications'),
        headers: {
          'Accept-Language': 'ar',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("📡 استجابة السيرفر: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['notifications'];
        final notifications = data.map((n) => MyNotification.fromJson(n)).toList();
        print(" تم جلب ${notifications.length} إشعار");
        emit(NotificationLoaded(notifications));
      } else {
        print(" فشل في جلب الإشعارات. رمز: ${response.statusCode}");
        print(" استجابة السيرفر: ${response.body}");
        emit(NotificationError('فشل في جلب الإشعارات. رمز: ${response.statusCode}'));
      }
    } catch (e) {
      print(" خطأ في جلب الإشعارات: $e");
      emit(NotificationError('خطأ: $e'));
    }
  }

  /// تعليم كل الإشعارات كمقروءة
  Future<void> markAllAsRead() async {

    await _postToApi('notifications/mark-all-read');
  }

  /// حذف كل الإشعارات
  Future<void> deleteAll() async {

    await _deleteFromApi('notifications/clear');
  }

  /// حذف إشعار معين
  Future<void> deleteById(String id) async {

    await _deleteFromApi('notifications/$id');
  }

  Future<void> _postToApi(String endpoint) async {
    final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('donor_token')
      ?? prefs.getString('beneficiary_token')
      ?? prefs.getString('volunteer_token');

    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/$endpoint'),
        headers: {
          'Accept-Language': 'ar',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print("تم تنفيذ العملية بنجاح");
        await fetchNotifications();
      } else {
        print(" فشل في العملية. رمز: ${response.statusCode}");
        emit(NotificationError('فشل في العملية. رمز: ${response.statusCode}'));
      }
    } catch (e) {
      print(" خطأ في العملية: $e");
      emit(NotificationError('خطأ: $e'));
    }
  }

  Future<void> _deleteFromApi(String endpoint) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('donor_token')
        ?? prefs.getString('beneficiary_token')
        ?? prefs.getString('volunteer_token');

    try {
      final response = await http.delete(
        Uri.parse('${ApiConstants.baseUrl}/$endpoint'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        print(" تم حذف الإشعارات بنجاح");
        await fetchNotifications();
      } else {
        print(" فشل في العملية. رمز: ${response.statusCode}");
        emit(NotificationError('فشل في العملية. رمز: ${response.statusCode}'));
      }
    } catch (e) {
      print(" خطأ في العملية: $e");
      emit(NotificationError('خطأ: $e'));
    }
  }

  /// تحديث FCM Token
  Future<void> updateFcmToken() async {
    print(" تحديث FCM Token...");
    await _saveFcmTokenToServer();
  }

  /// اختبار الإشعارات المحلية
  Future<void> testLocalNotification() async {
    print(" اختبار الإشعارات المحلية...");

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'default_channel',
      'Default',
      channelDescription: 'Default notification channel',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
        );

    const NotificationDetails details =
    NotificationDetails(android: androidDetails);

    try {
      await flutterLocalNotificationsPlugin.show(
        999,
        'إشعار تجريبي',
        'هذا إشعار تجريبي لاختبار النظام',
        details,
      );
      print(" تم عرض الإشعار التجريبي بنجاح");
    } catch (e) {
      print(" خطأ في عرض الإشعار التجريبي: $e");
    }
  }
}