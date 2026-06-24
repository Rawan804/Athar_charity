//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../cubit/Emergency/Emergency_state.dart';
// import 'BottomBar/bottombar.dart';
// import 'Details/EmergencyDetails.dart';
// import 'cubit/BottomBar Cubit/bottomba_cubit.dart';
// import 'cubit/EmDetails/EmDetails_Cubite.dart';
// import 'cubit/Emergency/Emergency_cubite.dart';
//
// class Emergency extends StatelessWidget{
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Scaffold(
//       extendBody: true,
//       bottomNavigationBar: Bottombar(),
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black), // سهم العودة
//           onPressed: () {
//             context.read<BottomNavigationCubit>().changeIndex(2);
//             Navigator.pushNamed(context, "home");
//           },
//         ),
//         title: Text(
//           'الحملات الطارئة',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//
//         centerTitle: true,
//         elevation: 0,
//       ),
//
//       body: BlocConsumer<EmergencyCubite, EmergencyState>(
//         listener: (context, state) {
//           if(state is EmergencySelectSuccess){
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => Emergencydetails(urgent:state.Ur),
//               ),
//             ).then((_) {
//               context.read<EmergencyCubite>().loadEmergency();
//             });
//           }
//         },
//         builder: (context, state) {
//           if (state is EmergencyLoaded) {
//             return Center(child: CircularProgressIndicator());
//           }
//           else if (state is EmergencySuccsess) {
//             return ListView.builder(
//               itemCount: state.Urgents.length,
//               itemBuilder: (context, index) {
//                 final comh1 = state.Urgents[index];
//
//                 return GestureDetector(
//                   onTap: () {
//                     context.read<EmdetailsCubite>().loadEmergencyDetails(comh1.id);
//                     context.read<EmergencyCubite>().selectcom(comh1);
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                     child: AnimatedContainer(
//
//                       duration: Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                       decoration: BoxDecoration(
//                         color: isDark ? Colors.white10 : Colors.white,
//                        // color: isDark ? Colors.black : null,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                             child: Image.network(
//                               comh1.image.isNotEmpty ? comh1.image : 'images/img_4.png',
//                               height: 200,
//                               width: double.infinity,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 12),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   comh1.name,
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xff1976D2),
//                                   ),
//                                   textAlign: TextAlign.right,
//                                 ),
//                                 SizedBox(height: 8),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Icon(Icons.access_time, color: Colors.red, size: 18),
//                                     SizedBox(width: 6),
//                                     Text(
//                                       "بقي القليل على انتهاء الحملة",
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey[600],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//           else if (state is EmergencyFailure) {
//             return Center(child: Text("فشل في تحميل الحملات"));
//           }
//           else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/Emergency/Emergency_state.dart';
import 'BottomBar/bottombar.dart';
import 'Details/EmergencyDetails.dart';
import 'cubit/BottomBar Cubit/bottomba_cubit.dart';
import 'cubit/EmDetails/EmDetails_Cubite.dart';
import 'cubit/Emergency/Emergency_cubite.dart';

class Emergency extends StatelessWidget{
  const Emergency({super.key});


  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = context.locale.languageCode;
    context.read<EmergencyCubite>().loadEmergency(lang);

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Bottombar(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // سهم العودة
          onPressed: () {
            context.read<BottomNavigationCubit>().changeIndex(2);
            Navigator.pushNamed(context, "home");
          },
        ),
        title: Text(
          "emergeny" .tr(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        centerTitle: true,
        elevation: 0,
      ),

      body: BlocConsumer<EmergencyCubite, EmergencyState>(
        listener: (context, state) {
          if(state is EmergencySelectSuccess){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Emergencydetails(urgent:state.Ur),
              ),
            ).then((_) {
              context.read<EmergencyCubite>().loadEmergency(lang);
            });
          }
        },
        builder: (context, state) {
          if (state is EmergencyLoaded) {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is EmergencySuccsess) {
            return ListView.builder(
              itemCount: state.Urgents.length,
              itemBuilder: (context, index) {
                final comh1 = state.Urgents[index];

                return GestureDetector(
                  onTap: () {
                    final lang = context.locale.languageCode;
                    context.read<EmdetailsCubite>().loadEmergencyDetails(comh1.id,lang);
                    context.read<EmergencyCubite>().selectcom(comh1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: AnimatedContainer(

                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white10 : Colors.white,
                        // color: isDark ? Colors.black : null,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            child: Image.network(
                              comh1.image.isNotEmpty ? comh1.image : 'images/img_4.png',
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  comh1.name,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff1976D2),
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.access_time, color: Colors.red, size: 18),
                                    SizedBox(width: 6),
                                    Text(
                                      "emergency1".tr(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          else if (state is EmergencyFailure) {
            return Center(child: Text("fiald campaign ".tr()));
          }
          else {
            return Container();
          }
        },
      ),
    );
  }
}
