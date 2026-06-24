import 'package:Athar_Charity/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SupportRequest.dart';
import 'cubit/BottomBar Cubit/bottomba_cubit.dart';
import 'cubit/login/login_cubit.dart';

class Login extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/img_33.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) async {
              if (state is LoginSuccess) {

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("تم التسجيل بنجاح".tr())),
                );
                final prefs = await SharedPreferences.getInstance();
                final userType = prefs.getString('user_type');
                showHelpDialog(context, userType);

              } else if (state is LoginFail) {

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding:
                const EdgeInsets.only(top: 120, bottom: 10, left: 30, right: 30),
                child: Center(
                  child: SingleChildScrollView(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 40),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Text("مرحباً".tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20)),
                                Text("سجل دخول".tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, color: Colors.grey)),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: emailController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "يرجى إدخال البريد الالكتروني".tr();
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text("البريد الالكتروني".tr())),
                                    suffixIcon: Icon(Icons.email, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 12),
                                TextFormField(
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'يرجى إدخال كلمة المرور';
                                    }
                                    return null;
                                  },
                                  obscureText: state.isObscure,
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text("كلمة المرور".tr())),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        state.isObscure
                                            ? Icons.visibility_off
                                            : Icons.remove_red_eye_outlined,
                                        color: Color(0xff53A7D8),
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        context.read<LoginCubit>().toggle();
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<LoginCubit>().login(
                                        emailController.text.trim(),
                                        passwordController.text,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "يرجى ملء جميع الحقول بشكل صحيح".tr())),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color(0xff53A7D8),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 80, vertical: 12),
                                    textStyle: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text("سجل دخول".tr()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


  void showHelpDialog(BuildContext context, String? userType) {
    if (userType == 'beneficiary') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("هل تحتاج إلى مساعدة؟".tr()),
          content: Text("يمكنك طلب مساعدة الآن أو لاحقًا من خلال القائمة".tr()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SupportRequest()),
                );
              },
              child: Text("طلب مساعدة".tr()),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
                context.read<BottomNavigationCubit>().changeIndex(2);
              },
              child: Text("لاحقاً".tr()),
            ),
          ],
        ),
      );
    }
    else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      ); context.read<BottomNavigationCubit>().changeIndex(2);
    }
    //else {
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       title: Text('تنبيه'),
    //       content: Text('يرجى تسجيل الدخول بحساب مستفيد لطلب المساعدة.'),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           child: Text('حسناً'),
    //         ),
    //       ],
    //     ),
    //   );
    // }
  }
}
