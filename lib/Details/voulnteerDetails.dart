import 'package:Athar_Charity/voulnteer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/voulnteerCubit/voulnteerDetails_cubit.dart';
import '../cubit/voulnteerCubit/voulnteerDetails_state.dart';
import '../model/ModVolunteer.dart';
import '../register/VoulnteerRegister.dart';

class VolunteerDetails extends StatelessWidget {
  final VolunteerRole volunteerRole;

  const VolunteerDetails({super.key, required this.volunteerRole});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocConsumer<VolunteerdetailsCubite, VolunterDetailsState>(
        listener: (context, state) {

        },


        builder: (context, state) {
          if (state is VolunterDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is VolunterDetailsSuccses) {
            final role2 = state.Role2;
            return Stack(
              children: [
                Image.network(
                  role2.image,
                  height: 600,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Stack(
                  children: [
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.45,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 10),
                          ],
                        ),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(width: 8),
                                  Text(
                                    role2.location,
                                    style: TextStyle(fontSize: 16,    color: isDark ? Colors.white : Colors.black,),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    // هذا يجعل العنوان يأخذ ما تبقى من المساحة
                                    child: Text(
                                      role2.name,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: isDark ? Colors.white : Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      // يمنع الانفجار عند النص الطويل
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Text(
                                textAlign: TextAlign.center,
                                role2.description,
                                style: TextStyle(

                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),

                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Text(
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.ellipsis,
                                      // يمنع الانفجار عند النص الطويل
                                      maxLines: 1,
                                      role2.startEndDate,
                                      style: TextStyle(
                                        color: isDark ? Colors.white : Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.date_range,
                                    color: Color(0xff53A7D8),
                                  ),
                                ],
                              ),

                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                // لتوجيه العناصر إلى اليمين
                                children: [
                                  Expanded(
                                    child: Text(
                                      role2.startEndTime,
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: isDark ? Colors.white : Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  // مسافة بين النص والأيقونة
                                  Icon(
                                    Icons.watch_later_outlined,
                                    color: Color(0xff53A7D8),
                                  ),
                                ],
                              ),

                              SizedBox(height: 45),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  width: 300,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      final token = prefs.getString(
                                        'volunteer_token',
                                      );
                                      showHelpDialog(
                                        context,
                                        token,
                                        volunteerRole,
                                      );
                                    },

                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff53A7D8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        // side: BorderSide(color: Color(0xff1976B1)),
                                      ),
                                      elevation: 4,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 40,
                                        vertical: 15,
                                      ),
                                    ),
                                    child: Text(
                                      "تطوع الآن".tr(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "",
                                        fontWeight: FontWeight.bold,
                                        // color: Color(0xff1976D2),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else if (state is VolunterDetailsFailure) {
            return Center(child: Text(" Failed to load data"));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}


void showHelpDialog(
  BuildContext context,
  String? token,
  VolunteerRole role,
) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('volunteer_token');
  if (token != null) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("هل أنت متأكد من الانضمام للحملة؟".tr()),
            content: Text("يمكنك الانضمام للحملة الان او لاحقاً.".tr()),
            actions: [
              TextButton(
                onPressed: () async {
                  final cubit = context.read<VolunteerdetailsCubite>();
                  final token = await SharedPreferences.getInstance()
                      .then((prefs) => prefs.getString('volunteer_token'));
                  if (token != null) {
                    final result = await cubit.join(role.id);
                    if (result == 400) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("أنت مسجل مسبقًا".tr())),
                      );
                      Navigator.pop(context);
                    }
                    else if (result == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("تم انضمامك بنجاح".tr())),
                      );
                      Navigator.pop(context);
                    }


                  }
                  else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VolunteerRegisterOnePage()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("يرجى تسجيل الدخول كمتطوع أولاً".tr())),
                    );
                  }
                },
                child: Text("انضمام للحملة".tr()),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => VolunteerDetails(volunteerRole: role),
                    ),
                  );
                },
                child: Text("لاحقاً".tr()),
              ),
            ],
          ),
    );

  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VolunteerRegisterOnePage()),
    );ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("يرجى تسجيل الدخول كمتطوع اولاً".tr())),
    );
  }

}
