import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'SupportRequest.dart';
import 'cubit/Beneficary/beneficary_cubit.dart';
import 'home.dart';
import 'login.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterNeeder extends StatelessWidget {
  TextEditingController first_name_contoller = TextEditingController();
  TextEditingController father_name_contoller = TextEditingController();
  TextEditingController mother_name_contoller = TextEditingController();
  TextEditingController address_contoller = TextEditingController();
  TextEditingController email_contoller = TextEditingController();
  TextEditingController phone_contoller = TextEditingController();
  TextEditingController password_contoller = TextEditingController();
  TextEditingController password_confirmation_contoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegisterNeeder({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BeneficaryCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // الخلفية العلوية
          Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/img_33.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // محتوى التسجيل
          BlocConsumer<BeneficaryCubit, BeneficaryState>(
            listener: (context, state) {
              if (state is BeneficarySuccess) {

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("تم التسجيل بنجاح".tr())),
                ); showHelpDialog(context);
              } else if (state is BeneficaryFail) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {


                return Padding(
                  padding: const EdgeInsets.only(
                      top: 120, bottom: 10, left: 30, right: 30),
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
                                  Text("مرحباً".tr(), style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20)),
                                  Text("سجل دخول كمستفيد".tr(), style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                                  SizedBox(height: 14),


                                     TextFormField(
                                      controller: first_name_contoller,
                                      validator: (value) {
                                        if (value == null || value
                                            .trim()
                                            .isEmpty) {
                                          return "يرجى إدخال  الاسم والكنية".tr();
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        label: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text("الاسم والكنية".tr())),
                                        suffixIcon: Icon(Icons.person,
                                            color: Color(0xff53A7D8)),
                                      ),
                                    ),

                                  SizedBox(height: 10),

                                  // اسم الأب

                                    TextFormField(
                                      controller: father_name_contoller,
                                      validator: (value) {
                                        if (value == null || value
                                            .trim()
                                            .isEmpty) {
                                          return "يرجى إدخال اسم الأب".tr();
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        label: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text("اسم الأب".tr())),
                                        suffixIcon: Icon(Icons.person,
                                            color: Color(0xff53A7D8)),
                                      ),
                                    ),

                                  SizedBox(height: 12),

                                  // اسم الأم


                                     TextFormField(
                                      controller: mother_name_contoller,
                                      validator: (value) {
                                        if (value == null || value
                                            .trim()
                                            .isEmpty) {
                                          return "يرجى إدخال اسم الأم".tr() ;
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        label: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text("اسم الأم".tr())),
                                        suffixIcon: Icon(Icons.person,
                                            color: Color(0xff53A7D8)),
                                      ),
                                    ),

                                  SizedBox(height: 12),

                                  // العنوان
                                  TextFormField(
                                      validator: (value) {
                                        if (value == null || value
                                            .trim()
                                            .isEmpty) {
                                          return "يرجى إدخال العنوان".tr();
                                        }
                                        return null;
                                      },
                                      controller: address_contoller,
                                      decoration: InputDecoration(
                                        label: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text("العنوان".tr())),
                                        suffixIcon: Icon(Icons.location_on,
                                            color: Color(0xff53A7D8)),
                                      ),
                                    ),

                                  SizedBox(height: 12),
                                 TextFormField(
                                      validator: (value) {
                                        if (value == null || value
                                            .trim()
                                            .isEmpty) {
                                          return "يرجى إدخال البريد الالكتروني".tr();
                                        }
                                        return null;
                                      },
                                      controller: email_contoller,
                                      decoration: InputDecoration(
                                        label: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text("البريد الإلكتروني".tr())),
                                        suffixIcon: Icon(Icons.email,
                                            color: Color(0xff53A7D8)),
                                      ),
                                    ),

                                  SizedBox(height: 12),
                                  // رقم الهاتف
                                 TextFormField(
                                      controller: phone_contoller,
                                      validator: (value) {
                                        if (value == null || value
                                            .trim()
                                            .isEmpty) {
                                          return "يرجى إدخال رقم الهاتف".tr();
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        label: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text("رقم الهاتف".tr())),
                                        suffixIcon: Icon(Icons.phone,
                                            color: Color(0xff53A7D8)),
                                      ),
                                    ),

                                  SizedBox(height: 12),

                                  // كلمة المرور
                                TextFormField(
                                      controller: password_contoller,
                                      validator: (value) {
                                        if (value == null || value
                                            .trim()
                                            .isEmpty) {
                                          return "يرجى إدخال  كلمة المرور";
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
                                            context.read<BeneficaryCubit>().toggle();

                                          },
                                        ),
                                      ),
                                    ),

                                  SizedBox(height: 15),

                                    TextFormField(
                                      controller: password_confirmation_contoller,
                                      validator: (value) {
                                        if (value == null || value
                                            .trim()
                                            .isEmpty) {
                                          return "يرجى إدخال تأكيد كلمة المرور".tr();
                                        }
                                        return null;
                                      },
                                      obscureText:state.isObscure,
                                      decoration: InputDecoration(
                                        label: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text("تأكيد كلمة المرور".tr())),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            state.isObscure
                                                ? Icons.visibility_off
                                                : Icons.remove_red_eye_outlined,
                                            color: Color(0xff53A7D8),
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            context.read<BeneficaryCubit>().toggle();

                                          },
                                        ),
                                      ),
                                    ),
                                   SizedBox(height: 30),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if(password_contoller.text!=password_confirmation_contoller.text){
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("كلمة المرور غير متطابقة".tr())));
                                          return;
                                        }
                                        if (_formKey.currentState!.validate()) {
                                          // جميع الحقول صحيحة، تابع التسجيل
                                          context.read<BeneficaryCubit>().RegisterBeneficary(
                                            first_name_contoller.text,
                                            father_name_contoller.text,
                                            mother_name_contoller.text,
                                            address_contoller.text,
                                            phone_contoller.text,
                                            email_contoller.text.trim(),
                                            password_contoller.text,
                                            password_confirmation_contoller.text,
                                          );


                                        } else {
                                          // يوجد خطأ في أحد الحقول
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("يرجى ملء جميع الحقول بشكل صحيح".tr())),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color(0xff53A7D8),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 80, vertical: 12),
                                        textStyle: TextStyle(fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),

                                      child: Text("سجل دخول".tr()),
                                    ),
                                  ),
                                  SizedBox(height: 0),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 12,),
                                      Container(child: Text("هل لديك حساب؟".tr(),style: TextStyle(fontSize: 16),),),
                                      GestureDetector(onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (_) => Login()),
                                        );
                                      },child: Text("سجل دخول".tr(),style: TextStyle(fontWeight: FontWeight.bold),)),

                                    ],
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

//   // نافذة المساعدة
//   void showHelpDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Text("هل تحتاج إلى مساعدة؟".tr()),
//             content: Text("يمكنك طلب مساعدة الآن أو لاحقًا من خلال القائمة".tr()),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   showHelpDialog(context);
//                   // الانتقال لواجهة المساعدة إن وجدت
//                   // Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
//                 },
//                 child: Text("طلب مساعدة".tr()),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text("لاحقاً".tr()),
//               ),
//             ],
//           ),
//     );
//   }
// }
void showHelpDialog(BuildContext context) {

  showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          title: Text("هل تحتاج إلى مساعدة؟".tr()),
          content: Text("يمكنك طلب مساعدة الآن أو لاحقًا من خلال القائمة".tr()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SupportRequest()),
                );
              },
              child: Text("طلب مساعدة".tr()),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home()),
                );

              },
              child: Text("لاحقاً".tr()),
            ),
          ],
        ),
  );
}}