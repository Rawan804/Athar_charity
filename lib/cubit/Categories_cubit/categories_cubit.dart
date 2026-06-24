//
// import 'dart:convert';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import '../../api/api.dart';
// import '../../model/partsItem.dart';
//
//
// part 'categories_state.dart';
//
// class CategoriesCubit extends Cubit<CategoriesState> {
//   CategoriesCubit() : super(CategoriesLoading());
//
//   void loadCategories() async {
//     emit(CategoriesLoading());
//
//     try {
//
//       var headers = {
//         'Accept': 'application/json',
//         'Accept-Language': 'ar',
//         'Cookie': 'laravel_session=uUo46YlEk7L1RmZ6SJCxBHbQsETjOVJnIzdqcl8B'
//       };
//       final response = await http.get(
//         Uri.parse("${ApiConstants.baseUrl}/projects"),
//         headers: headers
//
//
//     );
//
//
//       print("🔵 Status: ${response.statusCode}");
//       print("🔵 Body: ${response.body}");
//
//       if (response.statusCode == 200) {
//
//         response.headers.addAll(headers);
//         final data = jsonDecode(response.body);
//         final List projectsJson = data['projects'];
//
//         List<Project> projects = projectsJson
//             .map((projectJson) => Project.fromJson(projectJson))
//             .toList();
//
//         emit(CategoriesSuccess(projects));
//       } else {
//         emit(CategoriesFailure("خطأ في السيرفر: ${response.statusCode}"));
//       }
//     } catch (e) {
//       emit(CategoriesFailure("فشل في الاتصال بالسيرفر"));
//     }
//   }
//
//   void selectProject(Project project) {
//     emit(CategoriesSelected(project));
//   }
// }
//


import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../api/api.dart';
import '../../model/partsItem.dart';



part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesLoading());
  // final String baseUrl = "http://10.237.226.29:8000/api";

  void loadCategories(String LangCode) async {
    emit(CategoriesLoading());

    try {

      var headers = {
        'Accept': 'application/json',
        'Accept-Language': LangCode,
        'Cookie': 'laravel_session=uUo46YlEk7L1RmZ6SJCxBHbQsETjOVJnIzdqcl8B'
      };
      final response = await http.get(
          Uri.parse("${ApiConstants.baseUrl}/projects"),
          headers: headers


      );


      print("🔵 Status: ${response.statusCode}");
      print("🔵 Body: ${response.body}");

      if (response.statusCode == 200) {

        response.headers.addAll(headers);
        final data = jsonDecode(response.body);
        final List projectsJson = data['projects'];

        List<Project> projects = projectsJson
            .map((projectJson) => Project.fromJson(projectJson))
            .toList();

        emit(CategoriesSuccess(projects));
      } else {
        emit(CategoriesFailure("خطأ في السيرفر: ${response.statusCode}"));
      }
    } catch (e) {
      emit(CategoriesFailure("فشل في الاتصال بالسيرفر"));
    }
  }

  void searchProjects(String name,String LangCode) async {
    emit(CategoriesLoading());
    try {
      var headers = {
        'Accept': 'application/json',
        'Accept-Language': LangCode,
        'Cookie': 'laravel_session=uUo46YlEk7L1RmZ6SJCxBHbQsETjOVJnIzdqcl8B'
      };
      final response = await http.post(Uri.parse("${ApiConstants.baseUrl}/search"),
          headers: headers,
          body: {
            "name": name,
          });

      if (response.statusCode == 200) {
        print("تم البحث   %%%%^^^^^^^^^^^^*********");
        final data = jsonDecode(response.body);
        final List projectsJson = data['projects'];

        List<Project> projects =
        projectsJson.map((e) => Project.fromJson(e)).toList();

        emit(CategoriesSuccess(projects));
      } else {
        final data = jsonDecode(response.body);
        emit(CategoriesFailure(data["message"] ?? "لا يوجد نتائج"));
      }
    } catch (e) {
      emit(CategoriesFailure("فشل في الاتصال بالسيرفر"));
    }
  }


  void selectProject(Project project) {
    emit(CategoriesSelected(project));
  }
}


