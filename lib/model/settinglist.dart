import 'package:flutter/material.dart';
import 'modelsSetting.dart';
class ListSetting extends StatelessWidget {
  final settingModels setttingMod;
  const ListSetting({super.key, required this.setttingMod});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8),
      child: SizedBox(
        width: 350,
        height: 670,
        child: Card(
          // color: Colors.blue[(index + 1) * 100],

          elevation: 20,

          child:Padding(
            padding: const EdgeInsets.only(bottom: 4,top: 10,left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    setttingMod.iconn.icon,  // الحصول على رمز الأيقونة
                    color: Color(0xff1976D2), // تعيين اللون هنا
                    size: 28, // يمكنك تغيير حجم الأيقونة إذا رغبت
                  ), // إذا لم تكن الأيقونة موجودة، لا تعرض شيئًا
                ),

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(setttingMod.title,
                    style: TextStyle(
                    color:   isDark ? Colors.white :Colors.black,
                      fontSize: 15,

                    ),
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(setttingMod.explane,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,

                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );



  }
}
