import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final String LangCode;
  WalletCubit(this.LangCode) : super(WalletLoading());

  Future<void> getWallet() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('donor_token');

    var headers = {

      'Accept-Language':LangCode,
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.Request(
      'GET',
      Uri.parse('${ApiConstants.baseUrl}/wallet/balance'),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final resString = await response.stream.bytesToString();
      final data = jsonDecode(resString);
      final balance =
          data['wallet_balance'] ?? "0.00";
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('wallet_balance', data['wallet_balance']);
      emit(WalletSucsess(balance));
      print("wallet get");
    } else {
      print(response.reasonPhrase);
    }
  }

  void recharge(double amount) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('donor_token');
    var headers = {
      'Accept-Language': 'ar',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var request = http.Request(
      'POST',
      Uri.parse('${ApiConstants.baseUrl}/wallet/recharge'),
    );
    request.body = json.encode({"amount": amount});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
  void doate({
    int? subProjectId,
    int? campaignId,
    required double amount,
    required BuildContext context,
  }) async {
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("المبلغ يجب أن يكون أكبر من صفر ❌"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (subProjectId == null && campaignId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("يجب تحديد مشروع أو حملة ❌"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    Map<String, dynamic> body = {"amount": amount};
    if (subProjectId != null) body["sub_project_id"] = subProjectId;
    if (campaignId != null) body["campaign_id"] = campaignId;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('donor_token');

    var headers = {
      'Accept-Language': 'ar',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var request = http.Request(
      'POST',
      Uri.parse('${ApiConstants.baseUrl}/donate'),
    );
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("تم التبرع بنجاح ✅"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    }

    print("Status: ${response.statusCode}");
    print(await response.stream.bytesToString());
  }

}
