import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../api/api.dart';
part 'update_profile_volunteer_state.dart';

class UpdateProfileVolunteerCubit extends Cubit<UpdateProfileVolunteerState> {
  UpdateProfileVolunteerCubit() : super(UpdateProfileVolunteerLoading());
  TextEditingController nameController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController academic_certificateController=TextEditingController();
  TextEditingController experiencesController=TextEditingController();

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('volunteer_name') ?? '';
    emailController.text=prefs.getString('volunteer_email')??'';
    phoneController.text=prefs.getString('volunteer_phone')??'';
    addressController.text=prefs.getString('volunteer_address')??'';
    academic_certificateController.text=prefs.getString('volunteer_academic_certificate')??'';
    experiencesController.text=prefs.getString('volunteer_experiences')??'';
    emit( UpdateProfileVolunteerSuccesses());
  }
  void updateInfo() async {
    emit(UpdateProfileVolunteerLoading());

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('volunteer_token');

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
      Uri.parse('${ApiConstants.baseUrl}/volunteer/profile'),
    );

    request.body = json.encode({
      "name": nameController.text,
      "email": emailController.text,
      "phone":phoneController.text,
      "address":addressController.text,
      "academic_certificate":academic_certificateController.text,
      "experiences":experiencesController.text,
      "fcm_token": fcmToken, // إرسال الـ FCM token
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      print(respStr);

      // تحديث SharedPreferences إذا لزم
      final data = json.decode(respStr);
      await prefs.setString('volunteer_name', data['volunteer']['name'] ?? '');
      await prefs.setString('volunteer_email', data['volunteer']['email'] ?? '');
      await prefs.setString('volunteer_phone', data['volunteer']['phone'] ?? '');
      await prefs.setString('volunteer_academic_certificate', data['volunteer']['academic_certificate']??'');
      await prefs.setString('volunteer_experiences', data['volunteer']['experiences']??'');

      emit(UpdateProfileVolunteerSuccesses());
    } else {
      final respStr = await response.stream.bytesToString();
      print("Error: $respStr");
      emit(UpdateProfileVolunteerFail());
    }
  }
}
