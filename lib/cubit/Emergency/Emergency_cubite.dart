// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../../api/api.dart';
// import '../../model/Urgent.dart';
// import 'Emergency_state.dart';
//
// class EmergencyCubite extends Cubit<EmergencyState> {
//
//   EmergencyCubite(): super (EmergencyLoaded());
//
//   Future<void> loadEmergency() async {
//     emit(EmergencyLoaded());
//     try {
//       var headers = {
//        'Accept': 'application/json',
//        'Accept_Language': 'ar',
//        // تأكد إنك ما تحتاج الـ Cookie فعلاً، احذفها لو غير ضرورية
//       };
//
//       final response = await http.get(
//         Uri.parse('${ApiConstants.baseUrl}/getC'),
//         headers: headers,
//       );
//
//       print("response status: ${response.statusCode}");
//       print("response body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//
//         // تحقق هل الاستجابة List أم Map
//         List<dynamic> campaignsJson;
//
//         if (data is List) {
//           campaignsJson = data;
//         } else if (data is Map && data.containsKey('campaigns')) {
//           campaignsJson = data['campaigns'];
//         } else {
//           emit(EmergencyFailure("بيانات غير متوقعة من السيرفر"));
//           return;
//         }
//
//         final List<Urgent> urgents =
//         campaignsJson.map((json) => Urgent.fromJson(json)).toList();
//
//         emit(EmergencySuccsess(urgents));
//       } else {
//         emit(EmergencyFailure("خطأ في السيرفر: ${response.statusCode}"));
//       }
//     } catch (e) {
//       print('Error: $e');
//       emit(EmergencyFailure("خطأ: ${e.toString()}"));
//     }
//   }
//
//   void selectcom(Urgent Ur) {
//     emit(EmergencySelectSuccess(Ur));
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../api/api.dart';
import '../../model/Urgent.dart';

import 'Emergency_state.dart';

class EmergencyCubite extends Cubit<EmergencyState> {

  EmergencyCubite(): super (EmergencyLoaded());

  Future<void> loadEmergency(String LangCode) async {
    emit(EmergencyLoaded());
    try {
      var headers = {
        'Accept': 'application/json',
        'Accept_Language': LangCode,
        // تأكد إنك ما تحتاج الـ Cookie فعلاً، احذفها لو غير ضرورية
      };

      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/getC'),
        headers: headers,
      );

      print("response status: ${response.statusCode}");
      print("response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // تحقق هل الاستجابة List أم Map
        List<dynamic> campaignsJson;

        if (data is List) {
          campaignsJson = data;
        } else if (data is Map && data.containsKey('campaigns')) {
          campaignsJson = data['campaigns'];
        } else {
          emit(EmergencyFailure("بيانات غير متوقعة من السيرفر"));
          return;
        }

        final List<Urgent> urgents =
        campaignsJson.map((json) => Urgent.fromJson(json)).toList();

        emit(EmergencySuccsess(urgents));
      } else {
        emit(EmergencyFailure("خطأ في السيرفر: ${response.statusCode}"));
      }
    } catch (e) {
      print('Error: $e');
      emit(EmergencyFailure("خطأ: ${e.toString()}"));
    }
  }

  void selectcom(Urgent Ur) {
    emit(EmergencySelectSuccess(Ur));
  }
}