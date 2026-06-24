// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../cubit/DetailsCubit/DetailsCubit.dart';
// import '../cubit/Sub_project/Subproject_cubit.dart';
// import '../model/partsItem.dart';
// import 'DetailsPage.dart';
//
// class ProjectDetailsPage extends StatelessWidget {
//   final Project project;
//   ProjectDetailsPage({required this.project});
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Scaffold(
//       extendBody: true,
//       body: Stack(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               color: isDark ? Colors.black : null,
//               // خلفية ثابتة سوداء في الدارك
//               gradient:
//                   isDark
//                       ? null // لا Gradient في الدارك
//                       : LinearGradient(
//                         colors: [Color(0xff1976D2), Color(0xff53A7D8)],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//             ),
//           ),
//
//           // عنوان المشروع
//           Positioned(
//             top: 170,
//             right: 220,
//             child: Text(
//               "مشاريع ${project.name}",
//               style: const TextStyle(
//                 fontSize: 23,
//                 fontFamily: "ReemKufi",
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//
//           // المحتوى الأبيض الرئيسي مع البلوك
//           Positioned(
//             top: MediaQuery.of(context).size.height * 0.26,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: BlocConsumer<SubprojectCubit, SubprojectState>(
//               listener: (context, state) {
//                 if (state is Subproject_Selected) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Detailspage()),
//                   ).then((_) {
//                     context.read<SubprojectCubit>().loadSubProject(
//                       state.selectedProject.project_id,
//                     );
//                   });
//                 }
//               },
//               builder: (context, state) {
//                 if (state is SubprojectLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is SubprojectSuccess) {
//                   // عرض قائمة خيارات التبرع ضمن المشروع
//                   // if (project.donationOptions == null ||
//                   //     project.donationOptions!.isEmpty) {
//                   //   return const Center(
//                   //     child: Text("لا توجد بيانات متاحة لهذا المشروع."),
//                   //   );
//                   // }
//
//                   return Container(
//                     padding: const EdgeInsets.only(bottom: 10),
//                     decoration: BoxDecoration(
//                       color: isDark ? Colors.white10 : Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(50),
//                       ),
//                       boxShadow: [
//                         BoxShadow(color: Colors.black26, blurRadius: 10),
//                       ],
//                     ),
//                     child: ListView.builder(
//                       padding: const EdgeInsets.symmetric(vertical: 20),
//                       itemCount: state.project.length,
//                       itemBuilder: (context, index) {
//                         //  final donationOption = project.donationOptions![index];
//                         final project = state.project[index];
//                         return InkWell(
//                           onTap: () {
//                             final selectedProject = state.project[index];
//                             context.read<SubprojectCubit>().selectProject(
//                               selectedProject,
//                             );
//                             context.read<Detailscubit>().loadDetails(
//                               selectedProject.id,
//                               selectedProject.project_id,
//                             );
//                             //
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //     builder: (context) => BlocProvider.value(
//                             //       value: context.read<Detailscubit>(),
//                             //       child: Detailspage(),
//                             //     ),
//                             //   ),
//                             // );
//                           },
//
//                           child: Card(
//                             color: isDark ? Colors.white10 : Colors.white,
//                             margin: const EdgeInsets.all(20),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             elevation: 10,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: SizedBox(
//                                     height: 150,
//                                     width: 150,
//                                     child: Image.network(
//                                       project.image,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 30),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                       vertical: 20,
//                                     ),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           project.name,
//                                           style: TextStyle(
//                                             color:
//                                                 isDark
//                                                     ? Colors.white
//                                                     : Colors.black,
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Text(
//                                           "مبلغ التبرع الكلي : \$${project.required_amount}",
//                                           style: const TextStyle(
//                                             color: Colors.deepOrange,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 } else if (state is SubprojectFailed) {
//                   return const Center(child: Text("فشل تحميل بيانات المشروع"));
//                 } else {
//                   return const SizedBox.shrink();
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/DetailsCubit/DetailsCubit.dart';
import '../cubit/Sub_project/Subproject_cubit.dart';
import '../model/partsItem.dart';
import 'DetailsPage.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;
  const ProjectDetailsPage({super.key, required this.project});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = context.locale.languageCode;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: isDark ? Colors.black : null,
              // خلفية ثابتة سوداء في الدارك
              gradient:
              isDark
                  ? null // لا Gradient في الدارك
                  : LinearGradient(
                colors: [Color(0xff1976D2), Color(0xff53A7D8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // عنوان المشروع
          Positioned(
            top: 170,
            left: 70,
            child: Text(
              "${project.name}",
              style: const TextStyle(
                fontSize: 23,
                fontFamily: "ReemKufi",
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // المحتوى الأبيض الرئيسي مع البلوك
          Positioned(
            top: MediaQuery.of(context).size.height * 0.26,
            left: 0,
            right: 0,
            bottom: 0,
            child: BlocConsumer<SubprojectCubit, SubprojectState>(
              listener: (context, state) {
                if (state is Subproject_Selected) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Detailspage()),
                  ).then((_) {
                    context.read<SubprojectCubit>().loadSubProject(
                        state.selectedProject.project_id,lang
                    );
                  });
                }
              },
              builder: (context, state) {
                if (state is SubprojectLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SubprojectSuccess) {
                  // عرض قائمة خيارات التبرع ضمن المشروع
                  // if (project.donationOptions == null ||
                  //     project.donationOptions!.isEmpty) {
                  //   return const Center(
                  //     child: Text("لا توجد بيانات متاحة لهذا المشروع."),
                  //   );
                  // }

                  return Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white10 : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 10),
                      ],
                    ),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: state.project.length,
                      itemBuilder: (context, index) {
                        //  final donationOption = project.donationOptions![index];
                        final project = state.project[index];
                        return InkWell(
                          onTap: () {
                            final selectedProject = state.project[index];
                            context.read<SubprojectCubit>().selectProject(
                              selectedProject,
                            );
                            context.read<Detailscubit>().loadDetails(
                                selectedProject.id,
                                selectedProject.project_id,
                                lang
                            );
                            //
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => BlocProvider.value(
                            //       value: context.read<Detailscubit>(),
                            //       child: Detailspage(),
                            //     ),
                            //   ),
                            // );
                          },

                          child: Card(
                            color: isDark ? Colors.white10 : Colors.white,
                            margin: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Image.network(
                                      project.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 30),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          project.name,
                                          style: TextStyle(
                                            color:
                                            isDark
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "${": المبلغ الكلي".tr()}\$${project.required_amount}",
                                          style: const TextStyle(
                                            color: Colors.deepOrange,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is SubprojectFailed) {
                  return const Center(child: Text("فشل تحميل بيانات المشروع"));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
