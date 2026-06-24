// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:restart_app/restart_app.dart';
//
// class Language extends StatelessWidget {
//   const Language({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.only(top: 300,left: 30,right: 30),
//         child: Center(
//           child: Column(
//             children: [
//               Text("اختار اللغة "),
//               Card(
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: Text("ع", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                       onPressed: () {
//                         context.setLocale(Locale("ar"));
//                         Restart.restartApp();
//                       },
//                     ),
//
//                     Text("العربية",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold
//                       ),
//                     )
//                   ],
//                 ),
//
//               ),
//               Card(
//
//                   child: Row(
//                     children: [
//                       IconButton(
//                         icon: Text("E", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                         onPressed: () {
//                           context.setLocale(Locale("en"));
//                           Restart.restartApp();
//                         },
//                       ),
//
//                       Text("الإنكليزية",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold
//                         ),
//                       )
//                     ],
//                   ))
//
//
//
//               // ListTile(
//               //   leading: Image.asset('assets/Flag_of_Syria_(2025-).svg.png',),
//               //
//               // )
//             ],
//
//           ),
//         ),
//       ),
//
//
//
//     );
//   }
// }
