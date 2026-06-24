import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../api/api.dart'; // ✅ استيراد Firebase Messaging

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginLoading());
  void toggle() {
    final newValue = !state.isObscure;
    emit(toogle(isObscure: newValue));
  }
  void login(String email, String password) async {
    emit(LoginLoading());
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    var headers = {
      'Accept-Language': 'ar',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('${ApiConstants.baseUrl}/login'));
    request.body = json.encode({
      "email": email,
      "password": password,
      "fcm_token": fcmToken,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      print(body);
      final jsonData = json.decode(body);
      String token = jsonData['token'];
      final user = jsonData['user'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await prefs.setString('user_type', user['user_type']);
      await prefs.setString('fcm_token', user['fcm_token'] ?? '');

      switch(user['user_type']) {
        case 'beneficiary':
          await prefs.setString('beneficiary_token', token);
          await prefs.setInt('beneficiary_id', user['id']);
          await prefs.setString('beneficiary_first_name', user['first_name'] ?? '');
          await prefs.setString('beneficiary_father_name', user['father_name'] ?? '');
          await prefs.setString('beneficiary_mother_name', user['mother_name'] ?? '');
          await prefs.setString('beneficiary_email', user['email'] ?? '');
          await prefs.setString('beneficiary_phone', user['phone'] ?? '');
          await prefs.setString('beneficiary_address', user['address'] ?? '');

          break;

        case 'donor':
          await prefs.setString('donor_token', token);
          await prefs.setString('donor_first_name', user['first_name'] ?? '');
          await prefs.setString('donor_last_name', user['last_name'] ?? '');
          await prefs.setString('donor_email', user['email'] ?? '');
          break;

        case 'volunteer':
          await prefs.setString('volunteer_token', token);
          await prefs.setString('volunteer_name', user['name'] ?? '');
          await prefs.setString('volunteer_email', user['email'] ?? '');
          await prefs.setString('volunteer_phone', user['phone'] ?? '');
          await prefs.setString('volunteer_address', user['address'] ?? '');
        await prefs.setString('volunteer_academic_certificate', user['academic_certificate']??'');
          await prefs.setString('volunteer_experiences', user['experiences']??'');
          break;

        default:

          break;
      }

      emit(LoginSuccess());
    } else {

      final body = await response.stream.bytesToString();
      print(body);
      emit(LoginFail(body));
    }
  }

}
