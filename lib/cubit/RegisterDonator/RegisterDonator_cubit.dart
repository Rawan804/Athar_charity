import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import 'RegisterDonator_state.dart';

class RegisterDonatorCubit extends Cubit<RegisterDonatorState> {
  RegisterDonatorCubit() : super(RegisterDonatoreInitial());

  Future<void> registerDonor({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
  })
  async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    emit(RegisterDonatorLoading());

    try {
      var headers = {
        'Accept': 'application/json',
        'Accept-Language': 'ar',
        'Cookie': 'laravel_session=SI3LCgAP4XpuuSjBvaPQhoc1kjqej085jldGDmSx',
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiConstants.baseUrl}/register-donor'),
      );

      request.fields.addAll({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        "fcm_token": fcmToken??""
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {

        final body = await response.stream.bytesToString();
        print("تم التسجيل بنجاح: $body");

        final jsonData = json.decode(body);
        final donor = jsonData['donor'];
        final token=jsonData['donor_token'];
        final prefs= await SharedPreferences.getInstance();
        print(token);
        await prefs.setInt("id", donor['id']);

        await prefs.setString("donor_first_name", donor['first_name']?? '');
        await prefs.setString("donor_last_name", donor['last_name']?? '');
        await prefs.setString("donor_email", donor['email']);
        await prefs.setString('donor_created_at', donor['created_at']);
        await prefs.setString('donor_token', jsonData['token']);
        await prefs.setString('fcm_token', donor['fcm_token'] ?? '');


        emit(RegisterDonatorSuccess());
      }
      else {
        final errorBody = await response.stream.bytesToString();
        print("فشل التسجيل: ${response.statusCode} - $errorBody");
        emit(RegisterDonatorError("فشل التسجيل: ${response.statusCode}"));
      }
    } catch (e) {
      print("استثناء: $e");
      emit(RegisterDonatorError("حدث خطأ أثناء الاتصال بالخادم"));
    }
  }
}
