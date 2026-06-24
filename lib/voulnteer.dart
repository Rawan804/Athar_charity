//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'BottomBar/bottombar.dart';
// import 'Details/voulnteerDetails.dart';
// import 'cubit/BottomBar Cubit/bottomba_cubit.dart';
// import 'cubit/voulnteerCubit/voulnteerDetails_cubit.dart';
// import 'cubit/voulnteerCubit/voulnteer_State.dart';
// import 'cubit/voulnteerCubit/voulnteer_cubit.dart';
// class Voulnteer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Bottombar(),
//       extendBody: true,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black), // سهم العودة
//           onPressed: () {
//             context.read<BottomNavigationCubit>().changeIndex(2);
//             Navigator.pushNamed(context, "home");
//           },
//         ),
//         automaticallyImplyLeading: false,
//         title: Align(
//           alignment: Alignment.topLeft,
//           child: Text(
//             'الحملات التطوعية',
//             style: GoogleFonts.notoNaskhArabic(fontWeight: FontWeight.bold,fontSize: 25),
//           ),
//         ),
//         centerTitle: true,
//
//         elevation: 0,
//       ),
//
//       body: BlocConsumer<VolunteerCubit,VolunteerState>(
//         listener: (context,state){
//           if (state is VolunteerSelectSuccess) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => VolunteerDetails(volunteerRole:state.MV),
//               ),
//             ).then((_) {
//               context.read<VolunteerCubit>().loadVolunteer();
//             });
//           }
//         },
//         builder: (context,state)
//         {
//
//           if( state is VolunteerLoaded){
//             return Center(child: CircularProgressIndicator());
//           }
//           else if (state is VolunteerSucsess) {
//             return ListView.builder(
//               padding: EdgeInsets.all(30),
//               itemCount: state.Roles.length,
//               itemBuilder: (context, index) {
//                 final role1= state.Roles[index];
//                 return GestureDetector(
//                   onTap: () {
//                     context.read<VolunteerdetailsCubite>().loadVolunteersDetails(role1.id);
//                     context.read<VolunteerCubit>().selectVoulnteer(role1);
//
//                   },
//                   child: Card(
//                     margin: EdgeInsets.symmetric(vertical: 20),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     elevation: 6,
//                     shadowColor: Colors.teal.withOpacity(0.2),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.vertical(
//                             top: Radius.circular(20),
//                           ),
//                           child: Image.network(
//                             role1.image.isNotEmpty ? role1.image : 'images/img_4.png',
//
//                             height: 200,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(16),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 role1.name,
//                                 style:TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.location_on,
//                                     size: 18,
//                                     color: Colors.grey[600],
//                                   ),
//                                   SizedBox(width: 6),
//                                   Text(
//                                     role1.location,
//                                     style: GoogleFonts.cairo(color: Colors.grey[700]),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//           else if (state is VolunteerFaliure){
//             return Center(child: Text("فشل في تحميل الحملات "));
//           }
//           else {
//             return Center(child: Text("حاول مرة أخرى"));
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'BottomBar/bottombar.dart';
import 'Details/voulnteerDetails.dart';
import 'cubit/BottomBar Cubit/bottomba_cubit.dart';
import 'cubit/voulnteerCubit/voulnteerDetails_cubit.dart';
import 'cubit/voulnteerCubit/voulnteer_State.dart';
import 'cubit/voulnteerCubit/voulnteer_cubit.dart';
class Voulnteer extends StatelessWidget {
  const Voulnteer({super.key});

  @override
  Widget build(BuildContext context) {
    final lang= context.locale.languageCode;
    return Scaffold(
      bottomNavigationBar: Bottombar(),
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // سهم العودة
          onPressed: () {
            context.read<BottomNavigationCubit>().changeIndex(2);
            Navigator.pushNamed(context, "home");
          },
        ),
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Volunteer".tr(),
            style: GoogleFonts.notoNaskhArabic(fontWeight: FontWeight.bold,fontSize: 25),
          ),
        ),
        centerTitle: true,

        elevation: 0,
      ),

      body: BlocConsumer<VolunteerCubit,VolunteerState>(
        listener: (context,state){
          if (state is VolunteerSelectSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VolunteerDetails(volunteerRole:state.MV),
              ),
            ).then((_) {
              context.read<VolunteerCubit>().loadVolunteer(lang);
            });
          }
        },
        builder: (context,state)
        {

          if( state is VolunteerLoaded){
            return Center(child: CircularProgressIndicator());
          }
          else if (state is VolunteerSucsess) {
            return ListView.builder(
              padding: EdgeInsets.all(30),
              itemCount: state.Roles.length,
              itemBuilder: (context, index) {
                final role1= state.Roles[index];
                return GestureDetector(
                  onTap: () {
                    context.read<VolunteerdetailsCubite>().loadVolunteersDetails(role1.id,lang);
                    context.read<VolunteerCubit>().selectVoulnteer(role1);

                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                    shadowColor: Colors.teal.withOpacity(0.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: Image.network(
                            role1.image.isNotEmpty ? role1.image : 'images/img_4.png',

                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                role1.name,
                                style:TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 18,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    role1.location,
                                    style: GoogleFonts.cairo(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          else if (state is VolunteerFaliure){
            return Center(child: Text("فشل في تحميل الحملات "));
          }
          else {
            return Center(child: Text("حاول مرة أخرى"));
          }
        },
      ),
    );
  }
}
