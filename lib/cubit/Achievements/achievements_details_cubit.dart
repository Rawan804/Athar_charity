// import 'dart:convert';
//
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:http/http.dart' as http;
//
// import '../../api/api.dart';
// import '../../model/AchievementDetailsModel.dart';
//
//
// part 'achievements_details_state.dart';
//
// class AchievementsDetailsCubit extends Cubit<AchievementsDetailsState> {
//   AchievementsDetailsCubit() : super(AchievementsDetailsLoading());
//
//   void loadAchieveDetails(int id)async {
//     try {
//       var headers = {
//         'Accept': 'application/json',
//         'Accept-Language': 'ar',
//         'Cookie': 'laravel_session=x32bCrcM67O3pObD06oWWkiAD3jNNLqsd0ScWUcF',
//       };
//       final response  = await http.get (
//         Uri.parse('${ApiConstants.baseUrl}/achievements/$id'),
//         headers: headers,
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final achieveJson = data['AchievDetails'];
//         final AchievementsDetailsModel achievementsDetailsModel=AchievementsDetailsModel.fromjson(achieveJson);
//         emit(AchievementsDetailsSuccess(achievementsDetailsModel));
//       }
//     } catch (e) {
//       emit(AchievementsDetailsFail());
//     }
//   }
// }
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import '../../api/api.dart';
import '../../model/AchievementDetailsModel.dart';



part 'achievements_details_state.dart';

class AchievementsDetailsCubit extends Cubit<AchievementsDetailsState> {
  AchievementsDetailsCubit() : super(AchievementsDetailsLoading());

  void loadAchieveDetails(int id,String LangCode)async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Accept-Language': LangCode,
        'Cookie': 'laravel_session=x32bCrcM67O3pObD06oWWkiAD3jNNLqsd0ScWUcF',
      };
      final response  = await http.get (
        Uri.parse('${ApiConstants.baseUrl}/achievements/$id'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final achieveJson = data['AchievDetails'];
        final AchievementsDetailsModel achievementsDetailsModel=AchievementsDetailsModel.fromjson(achieveJson);
        emit(AchievementsDetailsSuccess(achievementsDetailsModel));
      }
    } catch (e) {
      emit(AchievementsDetailsFail());
    }
  }
}
