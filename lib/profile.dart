import 'package:Athar_Charity/cubit/updateProfile/update_profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/BottomBar Cubit/bottomba_cubit.dart';
import 'home.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: context.read<UpdateProfileCubit>().loadUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              // الخلفية العلوية
              Container(
                height: 420,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/img_33.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // محتوى التسجيل
              Padding(
                padding: const EdgeInsets.only(top: 120, bottom: 0, left: 30, right: 30),
                child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 15,
                                offset: Offset(10, 0),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 15,
                                offset: Offset(-10, 0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                            child: Column(
                              children: [
                                Text("تعديل الملف الشخصي".tr(),
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                SizedBox(height: 20),

                                /// الاسم الأول
                                TextFormField(
                                  controller: context.read<UpdateProfileCubit>().first_nameController,
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight, child: Text("الاسم الأول".tr())),
                                    suffixIcon: Icon(Icons.person, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 22),

                                /// الاسم الأب
                                TextFormField(
                                  controller: context.read<UpdateProfileCubit>().father_nameController,
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight, child: Text("اسم الأب".tr())),
                                    suffixIcon: Icon(Icons.person, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 12),

                                /// الاسم الأم
                                TextFormField(
                                  controller: context.read<UpdateProfileCubit>().mother_nameController,
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight, child: Text("الاسم الأم".tr())),
                                    suffixIcon: Icon(Icons.person, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 22),
                                TextFormField(
                                  controller: context.read<UpdateProfileCubit>().addressController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight, child: Text("العنوان".tr())),
                                    suffixIcon: Icon(Icons.email, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 22),

                                /// الايميل
                                TextFormField(
                                  controller: context.read<UpdateProfileCubit>().emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight, child: Text("البريد الإلكتروني".tr())),
                                    suffixIcon: Icon(Icons.email, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 22),

                                /// رقم الهاتف
                                TextFormField(
                                  controller: context.read<UpdateProfileCubit>().phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight, child: Text("رقم الهاتف".tr())),
                                    suffixIcon: Icon(Icons.phone, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 30),

                                /// زر تأكيد التعديل
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<UpdateProfileCubit>().updateInfo();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Home()),
                                    );
                                    context.read<BottomNavigationCubit>().changeIndex(2);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color(0xff53A7D8),
                                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                                    textStyle:
                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text("تأكيد التعديل".tr()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Profile extends StatelessWidget {
//   final Future<Map<String, String>> _userData = _loadUserData();
//
//   static Future<Map<String, String>> _loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     return {
//       'name': prefs.getString('name') ?? '',
//       'email': prefs.getString('email') ?? '',
//       'phone': prefs.getString('phone') ?? '',
//       'address': prefs.getString('address') ?? '',
//     };
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("الملف الشخصي")),
//       body: FutureBuilder<Map<String, String>>(
//         future: _userData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text("لا توجد بيانات محفوظة"));
//           }
//
//           final user = snapshot.data!;
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("الاسم: ${user['name']}"),
//                 SizedBox(height: 10),
//                 Text("الإيميل: ${user['email']}"),
//                 SizedBox(height: 10),
//                 Text("الموبايل: ${user['phone']}"),
//                 SizedBox(height: 10),
//                 Text("العنوان: ${user['address']}"),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
