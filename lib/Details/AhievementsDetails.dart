import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/Achievements/achievements_details_cubit.dart';

class AchievementsDetails extends StatelessWidget {

  const AchievementsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(

      body: BlocBuilder<AchievementsDetailsCubit, AchievementsDetailsState>(
        builder: (context, state) {
          if(state is AchievementsDetailsLoading)
          {
            return CircularProgressIndicator();
          }
          if(state is AchievementsDetailsSuccess){
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  child: Image.network(
                    state.achievementsDetailsModel.image,
                    width: double.infinity,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.6,
                    fit: BoxFit.cover,
                  ),
                ),

                Expanded(
                  child: Container(


                    height: 10000,
                    width: double.infinity,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color:  isDark ? Colors.black :Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(state.achievementsDetailsModel.location,style: TextStyle(fontSize: 16,color:  isDark ? Colors.white :Colors.black,),

                                ),SizedBox(width: 1,),
                                Icon(Icons.location_pin, color:  isDark ? Colors.white :Colors.black,)
                              ],),
                            SizedBox(height: 25,),

                            Text(
                              state.achievementsDetailsModel.title,
                              style: TextStyle(
                                color:  isDark ? Colors.white :Colors.black,
                                fontFamily: " Tajawal-Bold",
                                fontSize:16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.end,
                              maxLines: 1,
                            ),



                          ],
                        ),

                        SizedBox(height: 60),
                        Text(

                          state.achievementsDetailsModel.description,
                          style: TextStyle(
                            fontSize: 16,
                            color:  isDark ? Colors.white :Colors.black,

                          ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );}
          if(state is AchievementsDetailsFail){
            return Text("Fail");
          }
          else{
            return Container();
          }
        },
      ),
    );
  }
}
