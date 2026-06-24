import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import '../../api/api.dart';
import '../../model/UrgentDetails.dart';
import 'EmDetails_state.dart';



class EmdetailsCubite extends Cubit<EmdetailsState> {
  EmdetailsCubite():super(EmdetailsStateLoading());

  Future<void> loadEmergencyDetails(int id,String LangCode)  async {
    emit(EmdetailsStateLoading());

    try {
      final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}/getCam/$id"),
        headers: {
          'Accept': 'application/json',
          'Accept-Language': LangCode,
        },
      );

      print("تفاصيل الحملة: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final  detailsJson = data['camDetails'];
        Urgentdetails URG = Urgentdetails.fromJson(detailsJson);

        emit(EmdetailsStateSuccses(URG));
      } else {
        emit(EmdetailsStateFailure());
      }
    } catch (e) {
      print("Error fetching details: $e");
      emit(EmdetailsStateFailure());
    }
  }

}