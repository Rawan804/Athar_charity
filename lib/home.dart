import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'BottomBar/bottombar.dart';
import 'Details/AhievementsDetails.dart';
import 'Details/Subproject.dart';
import 'cubit/Achievements/achievements_cubit.dart';
import 'cubit/Achievements/achievements_details_cubit.dart';
import 'cubit/Categories_cubit/categories_cubit.dart';
import 'cubit/Sub_project/Subproject_cubit.dart';

class Home extends StatelessWidget {
  Home({super.key});


  final TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = context.locale.languageCode;

    // final lang = context.locale.languageCode;

    context.read<CategoriesCubit>().loadCategories(lang);
    context.read<AchievementsCubit>().loadAchievements(lang);
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Bottombar(),

      body: Stack(
        children: [
          Positioned.fill(
            child: Container(

              decoration: BoxDecoration(
                color: isDark ? Colors.black : null,
                gradient: isDark
                    ? null // لا Gradient في الدارك
                    : LinearGradient(
                  colors: [Color(0xff1976D2), Color(0xff53A7D8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),

              child: Stack(
                children: [

                  Positioned(
                    top: 40,
                    left: 120,
                    child: Text(
                      "جمعية أثر".tr(),
                      style: TextStyle(
                        fontFamily: "ReemKufi-Bold",
                        fontSize: 47,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 140,left: 30,right: 30),
                    child: TextFormField(
                      controller: searchController,
                      textAlign: TextAlign.right,
                      // textDirection: TextDirection.rtl, // مهم للـ hintText
                      decoration: InputDecoration(

                        hintText: "serach".tr(),
                        filled: true, // لجعل الخلفية ملونة
                        fillColor: Colors.white, // اللون الأبيض للخلفية
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30), // التدوير
                          borderSide: BorderSide.none, // لإزالة الخط الخارجي
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      ),
                      onChanged: (value){
                        if (value.isEmpty) {
                          context.read<CategoriesCubit>().loadCategories(lang);
                        } else {
                          context.read<CategoriesCubit>().searchProjects(value,lang);
                        }
                      },
                    ),
                  ),



                  // Positioned(
                  //   top: 160,
                  //   left: 140,
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       SizedBox(width: 8),
                  //       Icon(
                  //         Icons.favorite_border,
                  //         size: 30,
                  //         color: Colors.white,
                  //       ),
                  //       Text(
                  //         "ما نقص مالٌ من صدقة",
                  //         style: TextStyle(
                  //           fontSize: 23,
                  //
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 0,
            right: 0,
            child: Container(

              height:
              MediaQuery.of(context).size.height *
                  1,
              decoration: BoxDecoration(
                color:  isDark ? Colors.white10 :Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),

                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 210),
                      child: Text(
                        "projects".tr(),
                        style: TextStyle(
                          color:  isDark ? Colors.white :Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),

                    // قائمة المشاريع
                    SizedBox(
                      height: 120,
                      child:  BlocConsumer<CategoriesCubit, CategoriesState>(
                        listener: (context, state) {
                          if (state is CategoriesSelected) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectDetailsPage(project: state.project),
                              ),
                            )
                                .then((_) {
                              context.read<CategoriesCubit>().loadCategories(lang);
                            });
                          }
                        },
                        builder: (context, state) {
                          if (state is CategoriesLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          else if (state is CategoriesSuccess) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.projects.length,
                              itemBuilder: (context, i) {
                                final project = state.projects[i];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context.read<SubprojectCubit>().loadSubProject(project.id,lang);
                                          context.read<CategoriesCubit>().selectProject(project);
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 2,
                                              color: isDark ? Colors.grey : Colors.blueGrey,
                                            ),
                                          ),
                                          child: ClipOval(
                                            child: Image.network(
                                              project.image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        project.name,
                                        style: TextStyle(
                                          color: isDark ? Colors.white : Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else if (state is CategoriesFailure) {
                            return Center(child: Text("sorry dont project".tr()));
                          } else {
                            return SizedBox(height: 20);
                          }
                        },
                      ),

                    ),

                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.only(left: 190),
                      child: Text(
                        "achievements".tr(),

                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:  isDark ? Colors.white :Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),

                        child: BlocConsumer<AchievementsCubit, AchievementsState>(
                          listener: (context, state) {
                            if (state is AchievementSelected) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AchievementsDetails(),
                                ),
                              )
                                  .then((_) {
                                context.read<AchievementsCubit>().loadAchievements(lang);
                              });
                            }
                          },
                          builder: (context, state) {
                            if(state is AchievementsLoading){
                              return CircularProgressIndicator();
                            }
                            else if(state is AchievementsSuccess){
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.achievements.length,
                                itemBuilder: (context, i) {
                                  final achievement=state.achievements[i];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    child: GestureDetector(
                                      onTap: (){
                                        context.read<AchievementsCubit>().SelectedAchiev(achievement);
                                        context.read<AchievementsDetailsCubit>().loadAchieveDetails(achievement.id,lang);
                                      },
                                      child: Card(
                                        elevation: 9,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(36),
                                        ),
                                        child: Container(
                                          width: 185,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(30),
                                            border: Border.all(
                                              width: 1.5,
                                              color:  isDark ? Colors.black :Colors.blueGrey,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: Image.network(
                                                  achievement.image,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: 120,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                achievement.title,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.blueGrey[900],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );}
                            else if(state is AchievementsFailure){
                              return Center(child: Text(" sorrrry dont achievements".tr()));

                            }
                            else{
                              return Container();
                            }
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
