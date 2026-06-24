// import 'package:flutter/material.dart';
// enum AppTheme {
//   blueLight("Blue Light"),
//   blueDark("Blue Dark"),
//   redDark("Red Dark");
//   const AppTheme(this.name);
//   final String name;
// }
//
// final appThemeData = {
//   AppTheme.blueLight: ThemeData(
//       appBarTheme: AppBarTheme(backgroundColor: Colors.blue,),
//       brightness: Brightness.light,
//       primaryColor: Colors.blue
//   ),  AppTheme.blueDark: ThemeData(
//       appBarTheme: AppBarTheme(backgroundColor: Colors.blue[700],),
//       brightness: Brightness.dark,
//       primaryColor: Colors.blue[700]
//   ), AppTheme.redDark: ThemeData(
//       appBarTheme: AppBarTheme(backgroundColor: Colors.red[700],),
//       brightness: Brightness.dark,
//       primaryColor: Colors.red[700]
//   ),
//
//
// };
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/Theme/theme_cubit.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ما بنحتاج نعمل setInitialTheme هون
    return Scaffold(
      appBar: AppBar(title: Text("تغيير السمة")),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final isDarkMode = state.themeData.brightness == Brightness.dark;

          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme(!isDarkMode);
              },
              child: Text(
                isDarkMode ? 'Light Theme' : 'Dark Theme',
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}
