// // import 'package:Athar_Charity/cubit/voulnteerCubit/voulnteer_State.dart';
// //
// // import 'package:flutter_bloc/flutter_bloc.dart';
// //
// //
// // import '../../model/voulnteerModel.dart';
// // import '../../voulnteer.dart';
// //
// // class VoulnteerCubit extends Cubit<Voulnteer_State> {
// //   VoulnteerCubit() : super(Voulnteer_Loading());
// //
// //   Future<void> loadVoulnteer() async {
// //     try {
// //       emit(Voulnteer_Loading());
// //
// //       await Future.delayed(Duration(seconds: 1));
// //       final List<Campaign> campaigns = [
// //         Campaign(
// //           title: 'إفطار صائم',
// //           image: 'images/img_24.png',
// //           location: 'دمشق',
// //           description: 'كن من المتطوعين في حملة إفطار صائم . ستكون الحملة يوميا قبل الافطار تتكون الحملة من عدة مهام مثل المساهمة في طبخ الطعام وتعليب الطعام وتغليفه ثم التوزيع . لا تضيع أجرك قم وساهم',
// //           days: 'من 21 حزيران وحتى 30 حزيران',
// //           hours: " من 4 عصراً حتى 7 مساءً"
// //         ),
// //         Campaign(
// //           title: 'أنشطة ترفيهية للأيتام',
// //           image: 'images/img_22.png',
// //           location: 'حمص',
// //           description: 'كن سبباً في ابتسامة يتيم وشارك معنا في حملة الانشطة الترفيهية .تتضمن الحملة عدة نشاطات مثل الرسم ولعب الرياضة والفطور الجماعي وغيرها العديد',
// //           days: 'كل يوم جمعة من حزيران',
// //           hours: " من 9 صباحاً حتى 1 ظهراً"
// //         ),
// //         Campaign(
// //           title: 'حملة تشجير',
// //           image: 'images/img_23.png',
// //           location: 'حلب',
// //           description: 'غرس الأشجار اليوم هو استثمار في مستقبل أكثر خضرة، أنقى هواءً، وأجمل بيئة. كن جزءًا من التغيير، فكل شجرة تزرعها هي حياة تنمو',
// //           days: 'من 5 تموز حتى 15 تموز',
// //           hours: "من 2 ظهراً حتى 4 عصراً"
// //         ),
// //       ];
// //
// //       emit(Voulnteer_Succsess(campaigns));
// //     } catch (e) {
// //       emit(Voulnteer_Failure());
// //     }
// //   }
// //
// //   void selectCampaign(Campaign campaign) {
// //     emit(Voulnteer_SelectSuccess(campaign));
// //   }
// // }
// import 'dart:convert';
//
// import 'package:Athar_Charity/cubit/voulnteerCubit/voulnteer_State.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:http/http.dart'as http;
//
// import '../../api/api.dart';
// import '../../model/ModVolunteer.dart';
//
//
// class VolunteerCubit extends Cubit<VolunteerState> {
//
//
//   VolunteerCubit() : super (VolunteerLoaded());
//
//
//   Future<void> loadVolunteer() async {
//     emit(VolunteerLoaded());
//     try {
//       var headers = {
//         'Accept': 'application/json',
//         'Accept_Language': 'ar',
//       };
//
//       final response = await http.get(
//         Uri.parse('${ApiConstants.baseUrl}/roles'),
//         headers: headers,
//       );
//
//       print("response status: ${response.statusCode}");
//       print("response body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         final roles = data.map((json) => VolunteerRole.fromjson(json)).toList();
//         emit(VolunteerSucsess(roles));
//       }
//       else {
//         emit(VolunteerFaliure("فشل في جلب الحملات التطوعية: ${response.statusCode}"));
//       }
//     }
//     catch (e) {
//       print('Error: $e');
//       emit(VolunteerFaliure("خطأ: ${e.toString()}"));
//     }
//
//   }
//   void selectVoulnteer( VolunteerRole voulnteerRole) {
//     emit(VolunteerSelectSuccess(voulnteerRole));
//   }
// }

import 'dart:convert';

import 'package:Athar_Charity/cubit/voulnteerCubit/voulnteer_State.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart'as http;

import '../../api/api.dart';
import '../../model/ModVolunteer.dart';



class VolunteerCubit extends Cubit<VolunteerState> {


  VolunteerCubit() : super (VolunteerLoaded());


  Future<void> loadVolunteer(String LangCode) async {
    emit(VolunteerLoaded());
    try {
      var headers = {
        'Accept': 'application/json',
        'Accept_Language': LangCode,
      };

      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/roles'),
        headers: headers,
      );

      print("response status: ${response.statusCode}");
      print("response body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final roles = data.map((json) => VolunteerRole.fromjson(json)).toList();
        emit(VolunteerSucsess(roles));
      }
      else {
        emit(VolunteerFaliure("فشل في جلب الحملات التطوعية: ${response.statusCode}"));
      }
    }
    catch (e) {
      print('Error: $e');
      emit(VolunteerFaliure("خطأ: ${e.toString()}"));
    }

  }
  void selectVoulnteer( VolunteerRole voulnteerRole) {
    emit(VolunteerSelectSuccess(voulnteerRole));
  }
}