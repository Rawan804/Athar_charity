import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../api/api.dart';
part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileLoading());
  TextEditingController first_nameController =TextEditingController();
  TextEditingController father_nameController =TextEditingController();
  TextEditingController mother_nameController =TextEditingController();
  TextEditingController addressController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController emailController =TextEditingController();
TextEditingController  passwordController =TextEditingController();
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString("beneficiary") ?? "unknown";
    first_nameController.text = prefs.getString('beneficiary_first_name') ?? '';
    father_nameController.text = prefs.getString('beneficiary_father_name') ?? '';
    mother_nameController.text=prefs.getString('beneficiary_mother_name')??'';
    phoneController.text = prefs.getString('beneficiary_phone') ?? '';
    emailController.text=prefs.getString('beneficiary_email')??'';
    addressController.text = prefs.getString('beneficiary_address') ?? '';

   emit( UpdateProfileSuccess());
  }
  void updateInfo() async {
    emit(UpdateProfileLoading());

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('beneficiary_token');

    // جلب FCM token
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $fcmToken");

    var headers = {
      'Accept-Language': 'en',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var request = http.Request(
      'PUT',
      Uri.parse('${ApiConstants.baseUrl}/update-profile'),
    );

    request.body = json.encode({
      "first_name": first_nameController.text,
      "father_name": father_nameController.text,
      "mother_name": mother_nameController.text,
      "phone": phoneController.text,
      "email": emailController.text,
      "password":passwordController.text,
      "address": addressController.text,
      "fcm_token": fcmToken, // إرسال الـ FCM token
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      print(respStr);

      // تحديث SharedPreferences إذا لزم
      final data = json.decode(respStr);
      await prefs.setString('beneficiary_first_name', data['beneficiary']['first_name'] ?? '');
      await prefs.setString('beneficiary_father_name', data['beneficiary']['father_name'] ?? '');
      await prefs.setString('beneficiary_mother_name', data['beneficiary']['mother_name'] ?? '');
      await prefs.setString('beneficiary_phone', data['beneficiary']['phone'] ?? '');
      await prefs.setString('beneficiary_email', data['beneficiary']['email'] ?? '');
      await prefs.setString('beneficiary_address', data['beneficiary']['address_ar'] ?? '');

      await prefs.setString('fcm_token', data['beneficiary']['fcm_token'] ?? '');

      emit(UpdateProfileSuccess());
    } else {
      final respStr = await response.stream.bytesToString();
      print("Error: $respStr");
      emit(UpdateProfileFail());
    }
  }

}
