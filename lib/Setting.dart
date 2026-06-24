import 'package:Athar_Charity/profile.dart';
import 'package:Athar_Charity/profileDonor.dart';
import 'package:Athar_Charity/profileVolunteer.dart';
import 'package:Athar_Charity/registerNeeders.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BottomBar/bottombar.dart';
import 'NotificationScreen.dart';
import 'SupportRequest.dart';
import 'cubit/Logout/logout_cubit.dart';
import 'cubit/Theme/theme_cubit.dart';
import 'cubit/BottomBar Cubit/bottomba_cubit.dart';
import 'cubit/notifications/notification_cubit.dart';
import 'model/modelsSetting.dart';
import 'model/settinglist.dart';

class Setting extends StatelessWidget {
  Setting({super.key});

  final List<settingModels> sm = [
    settingModels(iconn: Icon(Icons.account_circle), title: "profile".tr(), explane: "تعديل الملف الشخصي".tr()),
    settingModels(iconn: Icon(Icons.language), title: "language".tr(), explane: "تغيير اللغة".tr()),
    settingModels(iconn: Icon(Icons.colorize), title: "Themes".tr(), explane: "تغيير السمة".tr()),
    settingModels(iconn: Icon(Icons.clean_hands_sharp), title: "Request for help".tr(), explane: "تسجيل دخول كمحتاج".tr()),
    settingModels(iconn: Icon(Icons.notifications), title: "Notifications".tr(), explane: "استلام إِشعارات التطبيق".tr()),
    settingModels(iconn: Icon(Icons.logout), title: "Log out".tr(), explane: "الخروج من التطبيق".tr()),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Bottombar(),
      appBar: AppBar(
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "setting".tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.read<BottomNavigationCubit>().changeIndex(2);
            Navigator.pushNamed(context, "home");
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              context.read<NotificationCubit>().fetchNotifications();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationsScreen()),
              );
            },
          ),
        ],
      ),

      body: GridView.builder(
        padding: EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.95, // يضبط تناسق الكروت
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: sm.length,
        itemBuilder: (context, index) {
          // كارد السمات فيه switch خاص
          if (sm[index].title == "Themes".tr()) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                final isDarkMode = state.themeData.brightness == Brightness.dark;
                return buildCard(
                  context,
                  sm[index].iconn,
                  sm[index].title,
                  sm[index].explane,
                  isDark,
                  extra: Switch(
                    value: isDarkMode,
                    onChanged: (val) {
                      context.read<ThemeCubit>().toggleTheme(val);
                    },
                    activeThumbImage: AssetImage("images/moon.png"),
                    inactiveThumbImage: AssetImage("images/cloud.png"),
                    activeColor: Colors.blue,
                    inactiveTrackColor: Colors.blueAccent,
                  ),
                );
              },
            );
          }

          // كارد اللغة
          if (sm[index].title == "language".tr()) {
            return GestureDetector(
              onTap: () => showLanguageDialog(context),
              child: buildCard(context, sm[index].iconn, sm[index].title, sm[index].explane, isDark),
            );
          }

          // كارد الملف الشخصي
          if (sm[index].title == "profile".tr()) {
            return GestureDetector(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                final beneficiaryToken = prefs.getString("beneficiary_token");
                final donorToken = prefs.getString("donor_token");
                final volunteerToken = prefs.getString("volunteer_token");

                if (beneficiaryToken != null && beneficiaryToken.isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Profile()));
                } else if (donorToken != null && donorToken.isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileDonor()));
                } else if (volunteerToken != null && volunteerToken.isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileVolunteer()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("الرجاء تسجيل الدخول أولا".tr())));
                }
              },
              child: buildCard(context, sm[index].iconn, sm[index].title, sm[index].explane, isDark),
            );
          }

          // كارد طلب مساعدة
          if (sm[index].title == "Request for help".tr()) {
            return GestureDetector(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                final beneficiaryToken = prefs.getString("beneficiary_token");
                if (beneficiaryToken != null && beneficiaryToken.isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SupportRequest()));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterNeeder()));
                }
              },
              child: buildCard(context, sm[index].iconn, sm[index].title, sm[index].explane, isDark),
            );
          }

          // كارد تسجيل الخروج
          if (sm[index].title == "Log out".tr()) {
            return GestureDetector(
              onTap: () => showLogOutDioalog(context),
              child: buildCard(context, sm[index].iconn, sm[index].title, sm[index].explane, isDark),
            );
          }

          // كارد الإشعارات
          return GestureDetector(
            onTap: () {
              if (sm[index].title == "Notifications".tr()) {
                context.read<NotificationCubit>().fetchNotifications();
                Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationsScreen()));
              }
            },
            child: buildCard(context, sm[index].iconn, sm[index].title, sm[index].explane, isDark),
          );
        },
      ),
    );
  }
  Widget buildCard(
      BuildContext context,
      Icon icon,
      String title,
      String subtitle,
      bool isDark, {
        Widget? extra,
      }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // النصوص تبدأ من اليسار (غير لو RTL يصير يمين)
          children: [
           SizedBox(height: 50,),
            Row(
              children: [
                icon,
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// الوصف (العنوان الفرعي)
            Text(
              subtitle,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            /// أي عنصر إضافي (زي السويتش للثيم)
            if (extra != null) ...[
              const SizedBox(height: 12),
              extra,
            ]
          ],
        ),
      ),
    );
  }

}

Future<void> showLogOutDioalog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("تأكيد تسجيل الخروج".tr()),
      content: Text("هل أنت متأكد من تسجيل الخروج من التطبيق؟".tr()),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("لا".tr()),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<LogoutCubit>().logout();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم تسجيل الخروج بنجاح")));
          },
          child: Text("نعم".tr()),
        )
      ],
    ),
  );
}

Future<void> showLanguageDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("اختر اللغة".tr()),
      content: Text("الرجاء اختيار لغة التطبيق".tr()),
      actions: [
        TextButton(
          onPressed: () {
            context.setLocale(Locale('ar'));
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم تغيير اللغة إلى العربية")));
          },
          child: Text("العربية"),
        ),
        TextButton(
          onPressed: () {
            context.setLocale(Locale('en'));
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Language changed to English")));
          },
          child: Text("English"),
        ),
      ],
    ),
  );
}
