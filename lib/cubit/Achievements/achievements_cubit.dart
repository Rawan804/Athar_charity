// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// import '../../api/api.dart';
// import '../../model/achievements.dart';
//
// part 'achievements_state.dart';
//
// class AchievementsCubit extends Cubit<AchievementsState> {
//   AchievementsCubit() : super(AchievementsLoading());
//
//   void loadAchievements() async {
//     emit(AchievementsLoading());
//     try {
//       var headers = {
//         'Accept': 'application/json',
//         'Accept-Language': 'ar',
//         'Cookie': 'laravel_session=x32bCrcM67O3pObD06oWWkiAD3jNNLqsd0ScWUcF',
//       };
//       final response = await http.get(
//         Uri.parse("${ApiConstants.baseUrl}/achievements"),
//         headers: headers,
//       );
//       if (response.statusCode == 200) {
//         response.headers.addAll(headers);
//         final data = jsonDecode(response.body);
//         final List AchievJson = data['achievements'];
//
//         List<Achievements> achievements =
//             AchievJson.map(
//               (AchievementsJson) => Achievements.fromJson(AchievementsJson),
//             ).toList();
//
//         emit(AchievementsSuccess(achievements));
//       } else {
//         emit(AchievementsFailure(("خطأ في السيرفر: ${response.statusCode}")));
//       }
//     } catch (e) {
//       print("Error loading achievements: $e");
//       emit(AchievementsFailure("fail"));
//     }
//   }
//   void SelectedAchiev(Achievements achievements){
//     emit(AchievementSelected(achievements));
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

import '../../api/api.dart';
import '../../model/achievements.dart';

part 'achievements_state.dart';

class AchievementsCubit extends Cubit<AchievementsState> {
  AchievementsCubit() : super(AchievementsLoading());

  void loadAchievements(String LangCode) async {
    emit(AchievementsLoading());
    try {
      var headers = {
        'Accept': 'application/json',
        'Accept-Language': LangCode ,
        'Cookie': 'laravel_session=x32bCrcM67O3pObD06oWWkiAD3jNNLqsd0ScWUcF',
      };
      final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}/achievements"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        response.headers.addAll(headers);
        final data = jsonDecode(response.body);
        final List AchievJson = data['achievements'];

        List<Achievements> achievements =
        AchievJson.map(
              (AchievementsJson) => Achievements.fromJson(AchievementsJson),
        ).toList();

        emit(AchievementsSuccess(achievements));
      } else {
        emit(AchievementsFailure(("خطأ في السيرفر: ${response.statusCode}")));
      }
    } catch (e) {
      print("Error loading achievements: $e");
      emit(AchievementsFailure("fail"));
    }
  }
  void SelectedAchiev(Achievements achievements){
    emit(AchievementSelected(achievements));
  }
}
