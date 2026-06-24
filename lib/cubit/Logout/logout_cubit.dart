import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../api/api.dart';
part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutLoading());
  void logout() async {
    final prefs = await SharedPreferences.getInstance();

    // تحقق من أي توكن موجود
    String? token = prefs.getString('donor_token') ?? prefs.getString('beneficiary_token')??prefs.getString('volunteer_token');

    var headers = {
      'Accept-Language': 'ar',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie': 'laravel_session=Vf8DWdLQL3C96C9EHyVdGkFvw9MvkiwKwcX4rK5q'
    };

    var request = http.Request('POST', Uri.parse('${ApiConstants.baseUrl}/logout'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // مسح كل التوكنات بعد تسجيل الخروج
      await prefs.remove('donor_token');
      await prefs.remove('beneficiary_token');
      await prefs.remove('volunteer_token');
      await prefs.remove('token');
      print(await response.stream.bytesToString());
      emit(LogoutSuccess());
    } else {
      print("Logout failed: ${response.reasonPhrase}");
      emit(LogoutFail());
    }
  }

}
