// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../api/api.dart';
// import '../../model/cartModel.dart';
// import 'cart_state.dart';
// class CartCubit extends Cubit<CartState> {
//   int? currentCartId;
//
//   CartCubit() : super(CartLoading()) {
//     _loadCartId();
//   }
//
//   void _loadCartId() async {
//     final prefs = await SharedPreferences.getInstance();
//     currentCartId = prefs.getInt('cart_id');
//     if (currentCartId != null) {
//       print(" تم جلب cart_id من التخزين: $currentCartId");
//       showCart(currentCartId!);
//     } else {
//       print(" لا يوجد cart_id محفوظ بعد");
//     }
//   }
//
//   void _saveCartId(int id) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('cart_id', id);
//     print("💾 تم حفظ cart_id في التخزين: $id");
//   }
//
//   void addToCart(int subProjectId, int amount) async {
//     var headers = {
//       'Accept-Language': 'ar',
//       'Accept': 'application/json',
//       'Cookie': 'laravel_session=YOUR_SESSION_HERE'
//     };
//
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse('${ApiConstants.baseUrl}/cart'),
//     );
//
//     request.fields.addAll({
//       'sub_project_id': subProjectId.toString(),
//       'amount': amount.toString(),
//       if (currentCartId != null)
//         'cart_id': currentCartId.toString()
//     });
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//     final responseBody = await response.stream.bytesToString();
//
//     print(" استجابة الإضافة إلى السلة: $responseBody");
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(responseBody);
//
//       if (data['cart_id'] != null) {
//         currentCartId = data['cart_id'];
//         _saveCartId(currentCartId!);
//         showCart(currentCartId!);
//       } else {
//         print(" لم يتم إرجاع cart_id من السيرفر");
//         emit(CartFailure());
//       }
//     } else {
//       print(" فشل الإضافة إلى السلة: ${response.reasonPhrase}");
//       emit(CartFailure());
//     }
//   }
//
//
//
//
//   void showCart(currentCartId) async {
//     emit(CartLoading());
//
//     var headers = {
//       'Accept': 'application/json',
//       'Accept-Language': 'ar',
//       'Cookie': 'laravel_session=YOUR_SESSION_HERE'
//     };
//
//     print(" Fetching cart with ID: $currentCartId");
//
//     final response = await http.get(
//       Uri.parse("${ApiConstants.baseUrl}/cart/$currentCartId"),
//       headers: headers,
//     );
//
//     print("Show cart status: ${response.statusCode}");
//     print("Show cart body: ${response.body}");
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       if (data.containsKey('cart')) {
//         final cartJson = data['cart'];
//         CartModel cart = CartModel.fromJson(cartJson);
//         emit(CartSuccsess(cart));
//       } else {
//         print("Response does not contain 'cart'");
//         emit(CartFailure());
//       }
//     } else {
//       emit(CartFailure());
//     }
//   }
//
//   void delet(currentCartId,int sub_project_id)async{
//     var headers = {
//       'Accept-Language': 'ar',
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'Cookie': 'laravel_session=Tji71koebrLUS33GtXDtA2r4SRSh7BODmNCVS0e8'
//     };
//     var request = http.Request('DELETE', Uri.parse('${ApiConstants.baseUrl}/remove'));
//     request.body = json.encode({
//       "cart_id": currentCartId,
//       "sub_project_id": sub_project_id
//     });
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//       print("تم حذف المشروع من السلة");
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//
//
//   }
//   void updat(currentCartId,int subproject_id,double amount)async{
//     var headers = {
//       'Accept-Language': 'ar',
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'Cookie': 'laravel_session=Tji71koebrLUS33GtXDtA2r4SRSh7BODmNCVS0e8'
//     };
//     var request = http.Request('POST', Uri.parse('${ApiConstants.baseUrl}/updat'));
//     request.body = json.encode({
//       "cart_id": currentCartId,
//       "sub_project_id": subproject_id,
//       "amount": amount
//     });
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//       print("تم تعديل السعر");
//     }
//     else {
//     print(response.reasonPhrase);
//     }
//
//
//   }
//   Future<void> dontCar(int cart_id) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('donor_token');
//     var headers = {
//       'Accept-Language': 'ar',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     };
//     var request = http.Request(
//         'POST', Uri.parse('${ApiConstants.baseUrl}/dontCar/$cart_id'));
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     } else {
//       print("${response.statusCode} : ${response.reasonPhrase}");
//       print(await response.stream.bytesToString());
//     }
//   }
//
// }

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import '../../model/cartModel.dart';

import 'cart_state.dart';
class CartCubit extends Cubit<CartState> {
  final String LangCode; // نخزن اللغة هنا

  int? currentCartId;

  CartCubit(this.LangCode) : super(CartLoading()) {
    _loadCartId();
  }

  void _loadCartId() async {
    final prefs = await SharedPreferences.getInstance();
    currentCartId = prefs.getInt('cart_id');
    if (currentCartId != null) {
      print(" تم جلب cart_id من التخزين: $currentCartId");
      showCart(currentCartId!,);
    } else {
      print(" لا يوجد cart_id محفوظ بعد");
    }
  }

  void _saveCartId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cart_id', id);
    print("💾 تم حفظ cart_id في التخزين: $id");
  }

  void addToCart(int subProjectId, int amount, String LangCode) async {
    var headers = {
      'Accept-Language': LangCode,
      'Accept': 'application/json',
      'Cookie': 'laravel_session=YOUR_SESSION_HERE'
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiConstants.baseUrl}/cart'),
    );

    request.fields.addAll({
      'sub_project_id': subProjectId.toString(),
      'amount': amount.toString(),
      if (currentCartId != null)
        'cart_id': currentCartId.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final responseBody = await response.stream.bytesToString();

    print(" استجابة الإضافة إلى السلة: $responseBody");

    if (response.statusCode == 200) {
      final data = jsonDecode(responseBody);

      if (data['cart_id'] != null) {
        currentCartId = data['cart_id'];
        _saveCartId(currentCartId!);
        showCart(currentCartId!);
      } else {
        print(" لم يتم إرجاع cart_id من السيرفر");
        emit(CartFailure());
      }
    } else {
      print(" فشل الإضافة إلى السلة: ${response.reasonPhrase}");
      emit(CartFailure());
    }
  }




  void showCart(currentCartId) async {
    emit(CartLoading());

    var headers = {
      'Accept': 'application/json',
      'Accept-Language': LangCode,
      'Cookie': 'laravel_session=YOUR_SESSION_HERE'
    };

    print(" Fetching cart with ID: $currentCartId");

    final response = await http.get(
      Uri.parse("${ApiConstants.baseUrl}/cart/$currentCartId"),
      headers: headers,
    );

    print("Show cart status: ${response.statusCode}");
    print("Show cart body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.containsKey('cart')) {
        final cartJson = data['cart'];
        CartModel cart = CartModel.fromJson(cartJson);
        emit(CartSuccsess(cart));
      } else {
        print("Response does not contain 'cart'");
        emit(CartFailure());
      }
    } else {
      emit(CartFailure());
    }
  }

  void delet(currentCartId,int subProjectId)async{
    var headers = {
      'Accept-Language': LangCode,
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Cookie': 'laravel_session=Tji71koebrLUS33GtXDtA2r4SRSh7BODmNCVS0e8'
    };
    var request = http.Request('DELETE', Uri.parse('${ApiConstants.baseUrl}/remove'));
    request.body = json.encode({
      "cart_id": currentCartId,
      "sub_project_id": subProjectId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("تم حذف المشروع من السلة");
    }
    else {
      print(response.reasonPhrase);
    }


  }
  void updat(currentCartId,int subprojectId,double amount)async{
    var headers = {
      'Accept-Language': LangCode,
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Cookie': 'laravel_session=Tji71koebrLUS33GtXDtA2r4SRSh7BODmNCVS0e8'
    };
    var request = http.Request('POST', Uri.parse('${ApiConstants.baseUrl}/updat'));
    request.body = json.encode({
      "cart_id": currentCartId,
      "sub_project_id": subprojectId,
      "amount": amount
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("تم تعديل السعر");
    }
    else {
      print(response.reasonPhrase);
    }


  }
  Future<void> dontCar(int cartId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('donor_token');
    var headers = {
      'Accept-Language': LangCode,
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST', Uri.parse('${ApiConstants.baseUrl}/dontCar/$cartId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print("${response.statusCode} : ${response.reasonPhrase}");
      print(await response.stream.bytesToString());
    }
  }

}

