// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// import '../../model/partsItem.dart';
// part 'Subproject_state.dart';
// class SubprojectCubit extends Cubit<SubprojectState> {
//   SubprojectCubit() : super(SubprojectLoading());
//   void loadProject() async {
//     try {
//       emit(SubprojectLoading());
//
//       List<Project> projects = [
//         Project(
//           title: "غزة",
//           image: "images/img_17.png",
//           donationOptions: [
//             DonationOption(
//               location: "رفح",
//               name: "تبرع بكرفانة",
//
//               image: "images/img_26.png",
//               required_amount: 250,
//               needs: ["بطانيات", "فرش", "ماء شرب"],
//             ),
//             DonationOption(
//               location: "غزة",
//               name: "تبرع بخيمة",
//               image: "images/img_25.png",
//               required_amount: 120,
//               needs: ["عوازل", "سجاد", "مصابيح"],
//             ),
//             DonationOption(
//               location: "غزة",
//               name: "تبرع بسلات غذائية",
//               image: "images/img_18.png",
//               required_amount: 200,
//               needs: [
//                 "أرز",
//                 "سكر",
//                 "زيت نباتي ",
//                 "شاي ",
//                 "معكرونة",
//
//                 "تمر",
//               ],
//             ),
//
//           ],
//         ),
//         Project(
//           title: "بناء مسجد",
//           image: "images/img_3.png",
//           donationOptions: [
//             DonationOption(
//                 location: "دمشق",
//                 name: "تبرع لمسجد النور",
//                 image: "images/img_19.png",
//                 required_amount: 250,
//                 needs: ["نظام صوتي جديد","كاميرات مراقبة (لحماية المكان)","سخانات ماء للوضوء"]
//             ),
//             DonationOption(
//                 location: "حمص",
//                 name: "تبرع لمسجد الفتح",
//                 image: "images/img_10.png",
//                 required_amount: 150.000,
//                 needs: ["تنظيف شامل وتعطير","إنارة موفرة للطاقة","تجهيز قاعة لتحفيظ القرآن"]
//             ),
//             DonationOption(
//                 location: "حلب",
//                 name: "تبرع لمسجد الرحمن",
//                 image: "images/img_32.png",
//                 required_amount: 200.000,
//                 needs: [
//                   "أماكن مخصصة لكبار السن","تجهيز مكتبة صغيرة","مكيفات هواء أو مراوح"
//                 ]
//
//             ),// DonationOption(
//             //   name: "تبرع لمسجد قباء",
//             //   image: "images/img_32.png",
//             //   required_amount: 200.000,
//             //   needs: [
//             //     "ترميم الموضئ","سجاد للمصلى","مصاحف"
//             //   ]
//             //
//             // ),
//           ],
//         ),
//         Project(
//
//           title: "كفالة يتيم",
//           image: "images/img_1.png",
//           donationOptions: [
//             DonationOption(
//                 location: "دمشق",
//                 name: "تبرع لمحمد",
//                 image: "images/orph1.jpg",
//                 required_amount: 250,
//                 age: 5,
//                 needs: ["رسوم مدرسية","ملابس شتوية وصيفية","رحلات ترفيهية"]
//             ),
//             DonationOption(
//                 location: "دمشق",
//                 name: "تبرع لسارة",
//                 image: "images/orph.jpg",
//                 required_amount: 150.000,
//                 age: 8,
//                 needs: ["احتياجات مدرسية","ملابس ","تكاليف الرعاية الصحية"]// ✅
//             ),   DonationOption(
//                 location: "دمشق",
//                 name: "تبرع لعبدالله ",
//                 image: "images/orph2.jpg",
//                 required_amount: 150.000,
//                 age: 4,
//                 needs: ["مكان امن للسكن","ملابس "," رعاية الصحية"]// ✅
//             ),
//           ],
//
//
//         ),
//         Project(
//           title: "صحة",
//           image: "images/img_16.png",
//           donationOptions: [
//             DonationOption(location: "دمشق",
//               name: "تبرع لجهاز طبي",
//               image: "images/img_15.png",
//               required_amount: 250.000,
//
//             ),
//             DonationOption(location: "دمشق",
//                 name: "تبرع لأطفال مرضى السرطان",
//                 image: "images/img_27.png",    required_amount: 250.000,
//                 needs: ["تكاليف جلسات العلاج","فحوصات وتحاليل دورية","جلسات دعم نفسي فردي أو جماعي"]
//
//             ),   DonationOption(location: "دمشق",
//                 name: "تبرع لمشفى الشفاء",
//                 image: "images/img_28.png",    required_amount: 250.000,
//                 needs: [
//                   "ترميم قسم الاسعاف","أجهزة غسيل كلى","زيادة عدد الأسرة بالعناية المشددة"
//                 ]
//             ),
//           ],
//         ),
//
//         Project(
//           title: "تعليم",
//           image: "images/img_5.png",
//           donationOptions: [
//             DonationOption(location: "دمشق",
//                 name: "تبرع  لحقيبة مدرسية",
//                 image: "images/img_7.png",   required_amount: 500.000,
//                 needs: ["حقيبة","قرطاسية كاملة"]
//
//             ),
//             DonationOption(location: "دمشق",
//                 name: "تبرع لثانوية التفوق",
//                 image: "images/img_21.png",   required_amount: 750.000,
//                 needs: ["مقاعد للدراسة","تجهيز صفوف أكبر","ترميم مخبر العلوم"]
//
//             ),   DonationOption(location: "دمشق",
//                 name: "تبرع لمدرسة التألق ",
//                 image: "images/img_29.png",   required_amount: 360.000,
//                 needs: ["مقاعد للدراسة","تجهيز صفوف أكبر","ترميم مخبر العلوم"]
//
//             ),
//           ],
//         ),
//
//
//       ];
//       emit(SubprojectSuccess(projects));
//     }
//     catch (error) {
//       emit(SubprojectFailed());
//     }
//   }
//   void selectProject(DonationOption donationOption) {
//     emit(Subproject_Selected(donationOption));
//   }
// }

//
// import 'dart:convert';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
//
//
// import '../../api/api.dart';
// import '../../model/partsItem.dart';
// import '../../model/subProjectModel.dart';
// part 'Subproject_state.dart';
// class SubprojectCubit extends Cubit<SubprojectState> {
//   SubprojectCubit() : super(SubprojectLoading());
//
//   void loadSubProject(int projectId) async {
//
//     emit(SubprojectLoading());
//
//     try {
//
//       var headers = {
//         'Accept': 'application/json',
//         'Accept-Language': 'ar',
//         'Cookie': 'laravel_session=xxx'
//       };
//
//       final response = await http.get(
//         Uri.parse("${ApiConstants.baseUrl}/getP/$projectId"),
//         headers: headers,
//       ); print(" Request");
//
//       print("Status: ${response.statusCode}");
//       print("Body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final List projectsJson = data['subProjects'] ?? [];
//
//         List<Subprojectmodel> projects = projectsJson
//             .map((projectJson) => Subprojectmodel.fromJson(projectJson))
//             .toList();
//
//         emit(SubprojectSuccess(projects));
//       } else {
//         emit(SubprojectFailed("خطأ في السيرفر: ${response.statusCode}"));
//       }
//     } catch (e) {
//       emit(SubprojectFailed("فشل في الاتصال بالسيرفر"));
//     }
//   }
//   void selectProject(Subprojectmodel selectedProject) {
//     emit(Subproject_Selected(selectedProject));
//   }
//
// }


import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


import '../../api/api.dart';
import '../../model/subProjectModel.dart';

part 'Subproject_state.dart';
class SubprojectCubit extends Cubit<SubprojectState> {
  SubprojectCubit() : super(SubprojectLoading());

  void loadSubProject(int projectId, String LangCode) async {

    emit(SubprojectLoading());

    try {

      var headers = {
        'Accept': 'application/json',
        'Accept-Language': LangCode,
        'Cookie': 'laravel_session=xxx'
      };

      final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}/getP/$projectId"),
        headers: headers,
      ); print(" Request");

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List projectsJson = data['subProjects'] ?? [];

        List<Subprojectmodel> projects = projectsJson
            .map((projectJson) => Subprojectmodel.fromJson(projectJson))
            .toList();

        emit(SubprojectSuccess(projects));
      } else {
        emit(SubprojectFailed("خطأ في السيرفر: ${response.statusCode}"));
      }
    } catch (e) {
      emit(SubprojectFailed("فشل في الاتصال بالسيرفر"));
    }
  }
  void selectProject(Subprojectmodel selectedProject) {
    emit(Subproject_Selected(selectedProject));
  }

}
