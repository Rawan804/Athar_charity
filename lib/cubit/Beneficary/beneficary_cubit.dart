import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
part 'beneficary_state.dart';

class BeneficaryCubit extends Cubit<BeneficaryState> {
  BeneficaryCubit() : super(BeneficaryLoading());
  void RegisterBeneficary (

    String firstName,
    String fatherName,
    String motherName,
    String address,
    String phone,
    String email,
    String password,
    String passwordConfirmation,
  )

  async{
    String? fcmToken = await FirebaseMessaging.instance.getToken();


    var headers = {
      'Accept-Language': 'ar',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Cookie': 'laravel_session=Tji71koebrLUS33GtXDtA2r4SRSh7BODmNCVS0e8',
    };
    var request = http.Request(
      'POST',
      Uri.parse('${ApiConstants.baseUrl}/register-as-beneficiary'),
    );
    request.body = json.encode({
      "first_name": firstName,
      "father_name": fatherName,
      "mother_name": motherName,
      "address_ar": address,
      "phone": phone,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "fcm_token": fcmToken,
    });




    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final responseBody=await response.stream.bytesToString();
    if (response.statusCode == 201) {
      print(responseBody);
      final jsonData = json.decode(responseBody);
      String token = jsonData['token'];
      print(token);

      final beneficiary = jsonData['beneficiary'];
      final prefs = await SharedPreferences.getInstance();

      // خزن التوكن
      await prefs.setString('beneficiary_token', token);
      if (jsonData['message'] == "messages.registered_as_beneficiary") {
        await prefs.setString("role", "beneficiary");

      await prefs.setInt('id', beneficiary['id']);
      await prefs.setString('beneficiary_first_name', beneficiary['first_name'] ?? '');
      await prefs.setString('beneficiary_father_name', beneficiary['father_name'] ?? '');
      await prefs.setString('beneficiary_mother_name', beneficiary['mother_name'] ?? '');
      await prefs.setString('beneficiary_email', beneficiary['email'] ?? '');
      await prefs.setString('beneficiary_phone', beneficiary['phone'] ?? '');
      await prefs.setString('beneficiary_address', beneficiary['address'] ?? '');
      await prefs.setString('fcm_token', beneficiary['fcm_token'] ?? '');


      print('Address: ${prefs.getString('address')}');


      emit(BeneficarySuccess());
    }} else {
      print("Error: $responseBody");
    }
  }
  void support_request(
      String healthStatusEn ,String healthStatusAr
      ,double monthlyIncome,
      String jobStatusEn,
      String jobStatusAr,
      bool isSingle,
      bool isUrgent,
      String supportTypeEn,
      String supportTypeAr,
      bool isMale,
      bool hasFamily,
      bool isMaleBreadwinnerForFamily,
      bool isFemaleBreadwinnerForFamily,
      bool isYouthWithoutFamily,
      bool isGirlWithoutFamily,
      bool isOrphan,
      bool isInjured,
      bool isDisabled,
      int totalNumberOfChildren,
      int numberOfDisabledChildren,
      String needsEn,
      String needsAr


      )async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('beneficiary_token');


    if (token == null) {
      print('❌ فشل في العثور على التوكن. تأكد من تسجيل الدخول أولاً.');
      return;
    }
    var headers = {
      'Accept-Language': 'ar',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Cookie': 'laravel_session=wkZQGQssZ0qimJqM1hrl1OYgGQd4yGEpO83i1F1e'
    };
    var request = http.Request('POST', Uri.parse('${ApiConstants.baseUrl}/support-request'));
    request.body = json.encode({
      "health_status_en": healthStatusEn,
      "health_status_ar": healthStatusAr,
      "monthly_income": monthlyIncome,
      "job_status_en": jobStatusEn,
      "job_status_ar": jobStatusAr,
      "is_single": isSingle,
      "is_urgent": isUrgent,
      "support_type_en": supportTypeEn,
      "support_type_ar": supportTypeAr,
      "is_male": isMale,
      "has_family": hasFamily,
      "is_male_breadwinner_for_family": isMaleBreadwinnerForFamily,
      "is_female_breadwinner_for_family": isFemaleBreadwinnerForFamily,
      "is_youth_without_family": isYouthWithoutFamily,
      "is_girl_without_family": isGirlWithoutFamily,
      "is_orphan": isOrphan,
      "is_injured": isInjured,
      "is_disabled": isDisabled,
      "total_number_of_children": totalNumberOfChildren,
      "number_of_disabled_children": numberOfDisabledChildren,
      "needs_en": needsEn,
      "needs_ar": needsAr
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {


      final body=  await response.stream.bytesToString();
      print(body);
      final jsonData= json.decode(body);
      final request = jsonData['request'][0];
      final message = jsonData['message'];
      print("رسالة السيرفر: $message");
      final prefs = await SharedPreferences.getInstance();
    //  prefs.setInt('beneficiary_id' ,request['id']);
      prefs.setString('health_status_en', request['health_status_en']);
      prefs.setString('health_status_ar', request['health_status_ar']);
      prefs.setDouble('monthly_income', (request['monthly_income'] as num).toDouble());

      prefs.setString('job_status_en', request['job_status_en']);
      prefs.setString('job_status_ar', request['job_status_ar']);
      prefs.setBool('is_single', request['is_single']);
      prefs.setBool('is_urgent', request['is_urgent']);
      prefs.setString('support_type_en', request['support_type_en']);
      prefs.setString('support_type_ar', request['support_type_ar']);
      prefs.setBool('is_male', request['is_male']);
      prefs.setBool('has_family', request['has_family']);
      prefs.setBool('is_male_breadwinner_for_family', request['is_male_breadwinner_for_family']);
      prefs.setBool('is_female_breadwinner_for_family', request['is_female_breadwinner_for_family']);
      prefs.setBool('is_youth_without_family', request['is_youth_without_family']);
      prefs.setBool('is_girl_without_family', request['is_girl_without_family']);
      prefs.setBool('is_orphan', request['is_orphan']);
      prefs.setBool('is_injured', request['is_injured']);
      prefs.setBool('is_disabled', request['is_disabled']);
      prefs.setInt('total_number_of_children', request['total_number_of_children']);
      prefs.setInt('number_of_disabled_children', request['number_of_disabled_children']);
      prefs.setString('needs_en', request['needs_en']);
      prefs.setString('needs_ar', request['needs_ar']);
      prefs.setInt('id', request['id']);
    }
    else {
    print(response.reasonPhrase);
    }

  }
  void toggle() {
    final newValue = !state.isObscure;
    emit(toogle(isObscure: newValue));
  }

}
