import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/BottomBar Cubit/bottomba_cubit.dart';
import 'cubit/updateProfile/update_profile_donor_cubit.dart';
import 'cubit/updateProfile/update_profile_donor_state.dart';
import 'home.dart';

class ProfileDonor extends StatelessWidget {
  const ProfileDonor({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: context.read<UpdateProfileDonorCubit>().loadUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              // الخلفية العلوية
              Container(
                height: 520,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/img_33.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // محتوى التسجيل
              Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 0, left: 30, right: 30),
                child: BlocConsumer<UpdateProfileDonorCubit, UpdateProfileDonorState>(
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
                                  controller: context.read<UpdateProfileDonorCubit>().first_nameController,
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight, child: Text("الاسم الأول".tr())),
                                    suffixIcon: Icon(Icons.person, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 22),

                                /// الاسم الأب
                                TextFormField(
                                  controller: context.read<UpdateProfileDonorCubit>().last_nameController,
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight, child: Text("الاسم الأخير".tr())),
                                    suffixIcon: Icon(Icons.person, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 12),


                                /// الايميل
                                TextFormField(
                                  controller: context.read<UpdateProfileDonorCubit>().emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    label: Align(
                                        alignment: Alignment.centerRight, child: Text("البريد الإلكتروني".tr())),
                                    suffixIcon: Icon(Icons.email, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 22),


                                /// زر تأكيد التعديل
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<UpdateProfileDonorCubit>().updateInfo();
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