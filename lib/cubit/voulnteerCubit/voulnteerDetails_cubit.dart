
import 'dart:convert';


import 'package:Athar_Charity/cubit/voulnteerCubit/voulnteerDetails_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import '../../model/VolunteerDetails.dart';
class VolunteerdetailsCubite extends Cubit<VolunterDetailsState> {
  VolunteerdetailsCubite():super(VolunterDetailsLoading());



  Future<void> loadVolunteersDetails(int id,String LangCode) async {
    emit(VolunterDetailsLoading());

    try {
      final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}/roles/$id"),
        headers: {
          'Accept': 'application/json',
          'Accept-Language': LangCode,
        },
      );

      print("تفاصيل الحملة: ${response.body}");


      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final detjson= data['role'];
        VolunteerDetail vol = VolunteerDetail.fromJson(detjson);
        emit(VolunterDetailsSuccses(vol));
      }

      else {
        emit(VolunterDetailsFailure("Error"));
      }
    } catch (e) {
      print("Error fetching details: $e");
      emit(VolunterDetailsFailure("Error"));
    }
  }
  Future<int> join(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('volunteer_token');

    var headers = {
      'Accept-Language': 'ar',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.Request(
      'POST',
      Uri.parse('${ApiConstants.baseUrl}/reqes/$id'),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response);
return 200;
    } else if (response.statusCode == 400) {
      return 400;

    } else {
      print(response);
      return 500;

    }
  }
}
