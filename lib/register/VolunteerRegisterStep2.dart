import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/RegisterVoulnteer/RegisterVoulnteer_cubite.dart';
import '../../cubit/RegisterVoulnteer/RegisterVoulnteer_state.dart';
import 'package:easy_localization/easy_localization.dart';

import '../cubit/BottomBar Cubit/bottomba_cubit.dart';
class VolunteerRegisterStep2 extends StatefulWidget {
  final String fullname;
  final String phone;
  final String email;
  final String address;
  final String password;
  final String passwordConfirmation;

  const VolunteerRegisterStep2({super.key, 
    required this.fullname,
    required this.phone,
    required this.email,
    required this.address,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  State<VolunteerRegisterStep2> createState() => _VolunteerRegisterStep2State();
}

class _VolunteerRegisterStep2State extends State<VolunteerRegisterStep2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController AcademicController = TextEditingController();
  final TextEditingController ExperiencesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterVoulnteerCubit>();

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
          Padding(
            padding: const EdgeInsets.only(top: 210, bottom: 10, left: 25, right: 20),
            child: BlocConsumer<RegisterVoulnteerCubit, RegistervoulnteerState>(
              listener: (context, state) {
                if (state is RegisterVoulnteerSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("تم التسجيل بنجاح".tr())),
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                  context.read<BottomNavigationCubit>().changeIndex(2);

                } else if (state is RegisterVoulnteerError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return Card(
                  elevation: 22,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.transparent),
                  ),
                  child: Container(
                    height: 410,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(45),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 2, left: 10, right: 10),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Text(
                                  "مهاراتك وخبراتك التطوعية".tr(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              // حقل الخبرات
                              Padding(
                                padding: const EdgeInsets.only(top: 10,bottom: 15,left: 10,right: 10),
                                child: TextFormField(
                                  controller: AcademicController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'يرجى إدخال الخبرات';
                                    }
                                    if (RegExp(r'^\d+$').hasMatch(value.trim())) {
                                      return 'يرجى كتابة وصف وليس أرقام فقط';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("الخبرات".tr()),
                                    ),
                                    suffixIcon: Icon(Icons.school, color: Color(0xff53A7D8)),
                                  ),
                                ),
                              ),
                              // حقل المهارات
                              Padding(
                                padding: const EdgeInsets.only(top: 10,bottom: 15,left: 10,right: 10),
                                child: TextFormField(
                                  controller: ExperiencesController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'يرجى إدخال المهارات';
                                    }
                                    if (value.trim().length < 3) {
                                      return 'يرجى إدخال مهارات أكثر أو تفاصيل إضافية';
                                    }
                                    if (RegExp(r'^\d+$').hasMatch(value.trim())) {
                                      return 'يرجى كتابة مهارات صحيحة وليست أرقامًا فقط';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("المهارات".tr()),
                                    ),
                                    suffixIcon: Icon(Icons.work, color: Color(0xff53A7D8)),
                                  ),
                                ),
                              ),
                              // زر التسجيل
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child: SizedBox(
                                  height: 60,
                                  width: 190,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.RegisterVoulnteer(
                                          name: widget.fullname,
                                          phone: widget.phone,
                                          email: widget.email,
                                          address: widget.address,
                                          password: widget.password,
                                          passwordConfirmation: widget.passwordConfirmation,
                                          academic_certificate: AcademicController.text,
                                          experiences: ExperiencesController.text,
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Color(0xff53A7D8),
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text("سجل دخول".tr()),
                                  ),
                                ),
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










// return Scaffold(
    //   body: Padding(
    //     padding: const EdgeInsets.all(20),
    //     child: BlocConsumer<RegisterVoulnteerCubit, RegistervoulnteerState>(
    //       listener: (context, state) {
    //         if (state is RegisterVoulnteerSuccess) {
    //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم التسجيل بنجاح")));
    //           Navigator.popUntil(context, (route) => route.isFirst);
    //         } else if (state is RegisterVoulnteerError) {
    //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
    //         }
    //       },
    //       builder: (context, state) {
    //         return Form(
    //           key: _formKey,
    //           child: ListView(
    //             children: [
    //               TextFormField(
    //                 controller: AcademicController,
    //
    //                 validator: (value) {
    //                   if (value == null || value.trim().isEmpty) {
    //                     return 'يرجى إدخال الخبرات';
    //                   }
    //
    //                   if (RegExp(r'^\d+$').hasMatch(value.trim())) {
    //                     return 'يرجى كتابة وصف وليس أرقام فقط';
    //                   }
    //
    //                   return null;
    //                 },
    //
    //
    //
    //                 decoration: InputDecoration(
    //                   label: Align(
    //                       alignment: Alignment.centerRight,
    //                       child: Text("الخبرات")),
    //                   suffixIcon: Icon(Icons.school,
    //                       color: Color(0xff53A7D8)),
    //                 ),
    //               ),
    //
    //               SizedBox(height: 22),
    //               //المهارات
    //
    //               TextFormField(
    //                 controller: ExperiencesController,
    //
    //                 validator: (value) {
    //                   if (value == null || value.trim().isEmpty) {
    //                     return 'يرجى إدخال المهارات';
    //                   }
    //
    //                   if (value.trim().length < 3) {
    //                     return 'يرجى إدخال مهارات أكثر أو تفاصيل إضافية';
    //                   }
    //
    //                   if (RegExp(r'^\d+$').hasMatch(value.trim())) {
    //                     return 'يرجى كتابة مهارات صحيحة وليست أرقامًا فقط';
    //                   }
    //
    //                   return null;
    //                 },
    //
    //
    //
    //                 decoration: InputDecoration(
    //                   label: Align(
    //                       alignment: Alignment.centerRight,
    //                       child: Text("المهارات")),
    //                   suffixIcon:
    //                       Icon(Icons.work, color: Color(0xff53A7D8)),
    //                 ),
    //               ),
    //               SizedBox(height: 30),
    //
    //               ElevatedButton(
    //                 onPressed: () {
    //                   if (_formKey.currentState!.validate()) {
    //                     cubit.RegisterVoulnteer(
    //                       name: widget.fullname,
    //                       phone: widget.phone,
    //                       email: widget.email,
    //                       address: widget.address,
    //                       password: widget.password,
    //                       passwordConfirmation: widget.passwordConfirmation,
    //                       academic_certificate: AcademicController.text,
    //                       experiences: ExperiencesController.text,
    //                     );
    //                   }
    //                 },
    //                 child: state is RegisterVoulnteerLoading
    //                     ? CircularProgressIndicator(color: Colors.white)
    //                     : Text("تسجيل"),
    //                 style: ElevatedButton.styleFrom(
    //                   foregroundColor: Colors.white,
    //                   backgroundColor: Color(0xff53A7D8),
    //                   padding: EdgeInsets.symmetric(
    //                       horizontal: 80, vertical: 12),
    //                   textStyle: TextStyle(
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.bold),
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(20),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );