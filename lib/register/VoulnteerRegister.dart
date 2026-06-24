import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../cubit/RegisterVoulnteer/RegisterVoulnteer_cubite.dart';
import '../../cubit/RegisterVoulnteer/RegisterVoulnteer_state.dart';
import '../login.dart';
import 'VolunteerRegisterStep2.dart';
import 'package:easy_localization/easy_localization.dart';
class VolunteerRegisterOnePage extends StatelessWidget {


  final TextEditingController FullnameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PhoneController = TextEditingController();
  final TextEditingController AddressController = TextEditingController();
  // final TextEditingController AcademicController = TextEditingController();
  // final TextEditingController ExperiencesController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController ConfirmPasswordController = TextEditingController();

  final _formKey= GlobalKey<FormState>();

  VolunteerRegisterOnePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // الخلفية العلوية
          Container(
            height: 500,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/img_33.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //
          // Padding(
          //   padding: const EdgeInsets.only(top: 40,bottom: 200,left: 100,right: 240),
          //   child: Text('سجل',
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontSize: 25,
          //     fontFamily:"JockeyOne",
          //     fontWeight:FontWeight.bold
          //   ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 73,bottom: 200,left: 15,right: 300),
          //   child: Text('كمتطوع',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize:23,
          //       fontFamily:"JockeyOne",
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),

          // محتوى التسجيل
          Padding(
            padding: const EdgeInsets.only(
                top: 170, bottom: 10, left: 25, right: 30),
            child: BlocConsumer<RegisterVoulnteerCubit,
                RegistervoulnteerState>(
              listener: (context, state) {
                if (state is RegisterVoulnteerSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("تم التسجيل بنجاح".tr())));
                } else if (state is RegisterVoulnteerError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                final cubit = context.read<RegisterVoulnteerCubit>();
                return Card(
                  elevation: 22, // نلغي الظل الخفيف التلقائي
                  color: Colors.transparent, // نخليه شفاف إذا بدك تشيل الخلفية
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50), // الزوايا الدائرية
                    side: BorderSide(color: Colors.transparent), // نلغي أي حدود
                  ),
                  child: Container(
                    height: 800,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(45), // نفس الزاوية
                      boxShadow: [ // إذا بدك تضيف ظل خفيف
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30,bottom: 8,left: 50,right: 30),
                      child: Form(
                          key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text("معلوماتك الشخصية".tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20)),
                              ),
                              // Text("Create Account", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                          
                              //fullName
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: FullnameController,
                                  validator: (value){
                                    if (value==null||value.isEmpty) {
                                      return "يرجى إدخال الاسم الكامل".tr();
                                    }
                                    if (RegExp(r'[0-9]').hasMatch(value)) {
                                      return "الاسم لا يجب أن يحتوي على أرقام";
                                    }
                          
                                     if (RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=/\\]').hasMatch(value)) {
                                     return "الاسم لا يجب أن يحتوي على رموز خاصة";
                                     }
                                    String nameWithoutSpaces = value.replaceAll(' ', '');
                          
                                    if (nameWithoutSpaces.length < 3) {
                                      return "الاسم يجب أن يحتوي على 3 أحرف على الأقل";
                                    }
                          
                          
                                    return null;
                          
                                  },
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text("الاسم الثلاثي".tr())),
                                    suffixIcon: Icon(Icons.person,
                                        color: Color(0xff53A7D8)),
                                  ),
                                ),
                              ),
                              // Phone
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: PhoneController,
                                  validator: (value){
                                    if(value==null||value.isEmpty) {
                                      return 'يجب إدخال رقم الهاتف';
                                    }
                                    String phone = value.trim();
                          
                                    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
                                      return 'رقم الهاتف يجب أن يحتوي على أرقام فقط';
                                    }
                          
                                    if (phone.length != 10) {
                                      return 'رقم الهاتف يجب أن يتكون من 10 أرقام';
                                    }
                          
                                    if (!phone.startsWith('09')) {
                                      return 'رقم الهاتف يجب أن يبدأ بـ 09';
                                    }
                          
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text("رقم الهاتف".tr())),
                                    suffixIcon:
                                        Icon(Icons.phone, color: Color(0xff53A7D8)),
                                  ),
                                ),
                              ),
                          
                          
                              // email
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: EmailController,
                                  validator: (value){
                                    if (value==null||value.isEmpty) {
                                      return'يرجى إدخال بريد إلكتروني ';
                                    }
                                    if (!value.contains('@')) {
                                      return 'بريد غير صالح';
                                    }
                                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          
                                    if (!emailRegex.hasMatch(value.trim())) {
                                      return 'البريد الإلكتروني غير صالح';
                                    }
                          
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text("البريد الإلكتروني".tr())),
                                    suffixIcon:
                                        Icon(Icons.email, color: Color(0xff53A7D8)),
                                  ),
                                ),
                              ),
                          
                                          //عنوان
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: AddressController,
                          
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'يرجى إدخال العنوان';
                                    }
                                    return null;
                                  },
                          
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text("العنوان".tr())),
                                    suffixIcon: Icon(Icons.location_on,
                                        color: Color(0xff53A7D8)),
                                  ),
                                ),
                              ),
                          
                              // خبرات
                              // TextFormField(
                              //   controller: AcademicController,
                              //
                              //   validator: (value) {
                              //     if (value == null || value.trim().isEmpty) {
                              //       return 'يرجى إدخال الخبرات';
                              //     }
                              //
                              //     if (RegExp(r'^\d+$').hasMatch(value.trim())) {
                              //       return 'يرجى كتابة وصف وليس أرقام فقط';
                              //     }
                              //
                              //     return null;
                              //   },
                              //
                              //
                              //
                              //   decoration: InputDecoration(
                              //     label: Align(
                              //         alignment: Alignment.centerRight,
                              //         child: Text("الخبرات")),
                              //     suffixIcon: Icon(Icons.school,
                              //         color: Color(0xff53A7D8)),
                              //   ),
                              // ),
                              //
                              // SizedBox(height: 22),
                              //
                              // //المهارات
                              //
                              // TextFormField(
                              //   controller: ExperiencesController,
                              //
                              //   validator: (value) {
                              //     if (value == null || value.trim().isEmpty) {
                              //       return 'يرجى إدخال المهارات';
                              //     }
                              //
                              //     if (value.trim().length < 3) {
                              //       return 'يرجى إدخال مهارات أكثر أو تفاصيل إضافية';
                              //     }
                              //
                              //     if (RegExp(r'^\d+$').hasMatch(value.trim())) {
                              //       return 'يرجى كتابة مهارات صحيحة وليست أرقامًا فقط';
                              //     }
                              //
                              //     return null;
                              //   },
                              //
                              //
                              //
                              //   decoration: InputDecoration(
                              //     label: Align(
                              //         alignment: Alignment.centerRight,
                              //         child: Text("المهارات")),
                              //     suffixIcon:
                              //         Icon(Icons.work, color: Color(0xff53A7D8)),
                              //   ),
                              // ),
                              // SizedBox(height: 30),
                          
                              //كلمة سر
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: PasswordController,
                          
                          
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'يرجى إدخال كلمة المرور';
                                    }
                                    if (value.length < 5) {
                                      return 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
                                    }
                                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                      return 'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل';
                                    }
                                    if (!RegExp(r'[a-z]').hasMatch(value)) {
                                      return 'يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل';
                                    }
                                    if (!RegExp(r'[0-9]').hasMatch(value)) {
                                      return 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';
                                    }
                          
                                    return null;
                                  },
                          
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text("كلمة المرور".tr())),
                                    suffixIcon:
                                        Icon(Icons.lock, color: Color(0xff53A7D8)),
                                  ),
                                ),
                              ),
                          
                              // تأكيد كلمة سر
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: ConfirmPasswordController,
                                            validator: (value){
                                            if (value == null || value.isEmpty) {
                                            return 'يرجى تأكيد كلمة المرور';
                                            }
                                            if (value != PasswordController.text) {
                                            return 'كلمة المرور غير متطابقة';
                                            }
                                            return null;
                                        },
                          
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text("تأكيد كلمة المرور".tr())),
                                    suffixIcon:
                                        Icon(Icons.lock, color: Color(0xff53A7D8)),
                                  ),
                                ),
                              ),
                          
                          
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 50,
                                  width: 140,
                                  // padding: EdgeInsets.only(bottom: 25,left: 60),
                                  child: ElevatedButton(
                                    onPressed: () {
                                     if(_formKey.currentState!.validate()){
                                      // if(PasswordController.text!=ConfirmPasswordController){
                                      //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("كلمة المرور غير متطابقة")));
                                      // }
                          
                                      // cubit.RegisterVoulnteer(
                                      //   name: FullnameController.text,
                                      //   phone: PhoneController.text,
                                      //   email: EmailController.text,
                                      //   address: AddressController.text,
                                      //   // academic_certificate:
                                      //   //     AcademicController.text,
                                      //   // experiences: ExperiencesController.text,
                                      //   password: PasswordController.text,
                                      //   passwordConfirmation:
                                      //       ConfirmPasswordController.text,
                                      // );
                                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم التسجيل بنجاح ")));
                                      //
                          
                          
                          
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                           builder: (_) => VolunteerRegisterStep2(
                                             fullname: FullnameController.text,
                                             phone: PhoneController.text,
                                             email: EmailController.text,
                                             address: AddressController.text,
                                             password: PasswordController.text,
                                             passwordConfirmation: ConfirmPasswordController.text,
                                           ),
                                         ),
                                       );
                          
                                    }
                          
                          
                          
                                     },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Color(0xff53A7D8),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text("التالي".tr()),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Container(child: Text("هل لديك حساب؟".tr( ),style: TextStyle(fontSize: 14),),),
                                  GestureDetector(onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => Login()),
                                    );
                                  },child: Text("سجل دخول".tr())),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
