import 'dart:convert';

import 'package:Athar_Charity/cubit/updateProfile/update_profile_donor_state.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../api/api.dart';

class UpdateProfileDonorCubit extends Cubit<UpdateProfileDonorState> {
  UpdateProfileDonorCubit() : super(UpdateProfileDonorLoading());
  TextEditingController first_nameController =TextEditingController();
  TextEditingController last_nameController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController wallet_balance=TextEditingController();

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    first_nameController.text = prefs.getString('donor_first_name') ?? '';
    last_nameController.text = prefs.getString('donor_last_name') ?? '';
    emailController.text=prefs.getString('donor_email')??'';
    emit( UpdateProfileDonorSuccess());
  }
  void updateInfo() async {
    emit(UpdateProfileDonorLoading());

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('donor_token');

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
      Uri.parse('${ApiConstants.baseUrl}/donor/profile'),
    );

    request.body = json.encode({
      "first_name": first_nameController.text,
      "last_name": last_nameController.text,
      "email": emailController.text,
     "wallet_balance":wallet_balance.text,
      "fcm_token": fcmToken, // إرسال الـ FCM token
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      print(respStr);

      // تحديث SharedPreferences إذا لزم
      final data = json.decode(respStr);
      await prefs.setString('donor_first_name', data['donor']['first_name'] ?? '');
      await prefs.setString('donor_last_name', data['donor']['last_name'] ?? '');
      await prefs.setString('donor_email', data['donor']['email'] ?? '');
      await prefs.setString('wallet_balance', data['donor']['wallet_balance']??'');


      emit(UpdateProfileDonorSuccess());
    } else {
      final respStr = await response.stream.bytesToString();
      print("Error: $respStr");
      emit(UpdateProfileDonorFail());
    }
  }

}
