
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../api/api.dart';
import 'RegisterVoulnteer_state.dart';


class RegisterVoulnteerCubit extends Cubit<RegistervoulnteerState>{
  RegisterVoulnteerCubit ():super(RegisterVoulnteerInitial());

Future<void> RegisterVoulnteer({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String address,
    required String academic_certificate,
    required String experiences,

})
  async{
    emit(RegisterVoulnteerLoading());


    String? fcmToken = await FirebaseMessaging.instance.getToken();

    try{
      var headers = {
        'Accept': 'application/json',
        'Accept-Language': 'ar',
        'Cookie': 'laravel_session=IuvD24RJMNwZZrfHVoCPz0upSQM1nNS2fOiheB3q'
      };
      var request = http.MultipartRequest('POST', Uri.parse('${ApiConstants.baseUrl}/register-as-volunteer'));
      request.fields.addAll({
        'name': name,
        'email':    email,
        'password':  password,
        'password_confirmation': passwordConfirmation,
        'address_en': address,
        'address_ar': address,
        'academic_certificate_en': academic_certificate,
        'academic_certificate_ar': academic_certificate,
        'experiences_en': experiences,
        'experiences_ar': experiences,
        'phone': phone,
        "fcm_token": fcmToken??""

      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode==201){

        final body = await response.stream.bytesToString();

        print("تم التسجيل بنجاح: $body");

        final jsonData= json.decode(body);
        final volunteer= jsonData['volunteer'];
        final volunteerToken =jsonData['volunteer_token'];
        final prefs = await SharedPreferences.getInstance();

        await prefs.setInt("id", volunteer['id']);
        await prefs.setString("volunteer_name", volunteer['name']);
        await prefs.setString("volunteer_email", volunteer['email']);
        await prefs.setString("volunteer_token", jsonData['token']);
        await prefs.setString("volunteer_phone", volunteer['phone']);
        await prefs.setString("volunteer_address", volunteer['address']);
        await prefs.setString("volunteer_academic_certificate", volunteer['academic_certificate']);
        await prefs.setString("volunteer_experiences", volunteer['experiences']);
        await prefs.setString('fcm_token', volunteer['fcm_token'] ?? '');

        emit(RegisterVoulnteerSuccess());
      }
      else {
        final errorBody = await response.stream.bytesToString();
        print("فشل التسجيل: ${response.statusCode} - $errorBody");
        emit(RegisterVoulnteerError("فشل التسجيل: ${response.statusCode}"));      }

    }
    catch(e){
      print('اشتثناء: $e');
      emit(RegisterVoulnteerError("حدث خطأ أثناء الاتصال بالخادم"));

    }
  }

}