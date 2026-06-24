//
//
// import 'dart:convert';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
//
// import '../../api/api.dart';
// import '../../model/detailsModel.dart';
// import 'DetailsState.dart';
//
//
// class Detailscubit extends Cubit<DetailsState> {
//   Detailscubit() : super(DetailsLoading());
//
//   void loadDetails(int id ,int projectId) async {
//     emit(DetailsLoading());
//
//     try {
//
//       var headers = {
//         'Accept': 'application/json',
//         'Accept-Language': 'ar',
//         'Cookie': 'laravel_session=uUo46YlEk7L1RmZ6SJCxBHbQsETjOVJnIzdqcl8B'
//       };
//       final response = await http.get(
//           Uri.parse("${ApiConstants.baseUrl}/show/$id/$projectId"),
//           headers: headers
//
//
//       );
//
//
//       print("Status: ${response.statusCode}");
//       print("Body: ${response.body}");
//
//       if (response.statusCode == 200) {
//
//         response.headers.addAll(headers);
//         final data = jsonDecode(response.body);
//
//
//         final projectJson = data['subProject'];
//         DetailsModel projectd = DetailsModel.fromJson(projectJson);
//         emit(DetailsSuccsess(projectd));
//       } else {
//         emit(DetailsFailure("خطأ في السيرفر: ${response.statusCode}"));
//       }
//     }  catch (e, stacktrace) {
//   print("Exception: $e");
//
//   emit(DetailsFailure("فشل في الاتصال بالسيرفر"));
// }
//
//
// }}
//


import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../api/api.dart';
import '../../model/detailsModel.dart';

import 'DetailsState.dart';


class Detailscubit extends Cubit<DetailsState> {
  Detailscubit() : super(DetailsLoading());

  void loadDetails(int id ,int projectId,String LangCode) async {
    emit(DetailsLoading());

    try {

      var headers = {
        'Accept': 'application/json',
        'Accept-Language': LangCode,
        'Cookie': 'laravel_session=uUo46YlEk7L1RmZ6SJCxBHbQsETjOVJnIzdqcl8B'
      };
      final response = await http.get(
          Uri.parse("${ApiConstants.baseUrl}/show/$id/$projectId"),
          headers: headers


      );


      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {

        response.headers.addAll(headers);
        final data = jsonDecode(response.body);


        final projectJson = data['subProject'];
        DetailsModel projectd = DetailsModel.fromJson(projectJson);
        emit(DetailsSuccsess(projectd));
      } else {
        emit(DetailsFailure("خطأ في السيرفر: ${response.statusCode}"));
      }
    }  catch (e) {
      print("Exception: $e");

      emit(DetailsFailure("فشل في الاتصال بالسيرفر"));
    }


  }}

