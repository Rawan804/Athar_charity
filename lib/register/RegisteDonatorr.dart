import 'package:Athar_Charity/Details/DetailsPage.dart';
import 'package:Athar_Charity/home.dart';
import 'package:Athar_Charity/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/RegisterDonator/RegisterDonator_cubit.dart';
import '../cubit/RegisterDonator/RegisterDonator_state.dart';

class Registedonatorr extends StatelessWidget{

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Registedonatorr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
            padding: const EdgeInsets.only(top: 120, left: 40, right: 30),
            child: Center(
              child: SingleChildScrollView(
                child: BlocConsumer<RegisterDonatorCubit,RegisterDonatorState>(
                  listener: (context, state) {
                    if (state is RegisterDonatorSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("تم التسجيل بنجاح".tr())),

                    );
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
                    } else if (state is RegisterDonatorError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                    );
                    }
                    },
                  builder:(context,state) {
                     final cubit = context.read<RegisterDonatorCubit>();
                    if (state is RegisterDonatorLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Container(
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
                            offset: Offset(-10, 0), // ظل على اليسار
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 30),
                        child: Column(
                          children: [
                            Text("سجل دخول كمتبرع".tr(), style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                            // Text("Create Account", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: firstNameController,
                              // onChanged: cubit.updateFirstName,
                              decoration: InputDecoration(
                                label: Align(alignment: Alignment.centerRight,
                                    child: Text("الاسم الأول".tr())),
                                suffixIcon: Icon(
                                    Icons.person, color: Color(0xff53A7D8)),
                              ),
                            ),
                            SizedBox(height: 22),


                            TextFormField(
                              // onChanged: cubit.updateLastName,
                              controller: lastNameController,
                              decoration: InputDecoration(
                                label: Align(alignment: Alignment.centerRight,
                                    child: Text("الاسم الأخير".tr())),
                                suffixIcon: Icon(
                                    Icons.person, color: Color(0xff53A7D8)),
                              ),
                            ),
                            SizedBox(height: 12),


                            //إيميل
                            TextFormField(
                              controller: emailController,
                              // onChanged: cubit.updateEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                label: Align(alignment: Alignment.centerRight,
                                    child: Text("البريد الإلكتروني".tr())),
                                suffixIcon: Icon(
                                    Icons.email, color: Color(0xff53A7D8)),
                              ),
                            ),
                            SizedBox(height: 22),

                            // كلمة المرور
                            TextFormField(
                              controller: passwordController,
                              // onChanged: cubit.updatePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                label: Align(alignment: Alignment.centerRight,
                                    child: Text("كلمة المرور".tr())),
                                suffixIcon: Icon(
                                    Icons.lock, color: Color(0xff53A7D8)),
                              ),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              controller: confirmPasswordController,
                              // onChanged: cubit.updatePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                label: Align(alignment: Alignment.centerRight,
                                    child: Text("تأكيد كلمة المرور".tr())),
                                suffixIcon: Icon(
                                    Icons.lock, color: Color(0xff53A7D8)),
                              ),
                            ),
                            SizedBox(height: 30),

                            Container(
                              padding: EdgeInsets.only(bottom: 1),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (firstNameController.text.isEmpty || lastNameController.text.isEmpty ||
                                          emailController.text.isEmpty || passwordController.text.isEmpty ||
                                          confirmPasswordController.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("يرجى ملء جميع الحقول")));
                                        return;
                                      }

                                      if(passwordController.text!=confirmPasswordController.text){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("كلمة المرور غير متطابقة ")));
                                        return;
                                      }



                                      cubit.registerDonor
                                        (firstName:firstNameController.text ,
                                          lastName: lastNameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          passwordConfirmation: confirmPasswordController.text,
                                      );
                                       
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Color(0xff53A7D8),
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),   
                                    child: state is RegisterDonatorLoading
                                        ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth:2,
                                      ),
                                    )
                                        : Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "إنشاء حساب".tr(),
                                        //maxLines: 1,
                                       // textDirection: TextDirection.rtl,
                                       // textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),



                                  if (state is RegisterDonatorLoading)
                                    Positioned(
                                      top: -30, // يظهر المؤشر فوق الزر قليلاً
                                      child: CircularProgressIndicator(color: Color(0xff53A7D8)),
                                    ),
                                ],
                              ),
                            ),SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Container(child: Text("هل لديك حساب؟".tr( ),style: TextStyle(fontSize: 14),),),
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
                    );
                  }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
