
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cubit/EmDetails/EmDetails_state.dart';
import '../cubit/BottomBar Cubit/bottomba_cubit.dart';
import '../cubit/CartCubit/cart_cubit.dart';
import '../cubit/EmDetails/EmDetails_Cubite.dart';
import '../cubit/Wallet/wallet_cubit.dart';
import '../model/Urgent.dart';
import '../model/UrgentDetails.dart';
import '../register/RegisteDonatorr.dart';
import '../wallet.dart';
class Emergencydetails extends StatelessWidget{
  final Urgent urgent;

   Emergencydetails({super.key, required this.urgent});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = context.locale.languageCode;
    context.read<EmdetailsCubite>().loadEmergencyDetails(urgent.id,lang);
    return Scaffold(

        body: BlocConsumer<EmdetailsCubite, EmdetailsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is EmdetailsStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmdetailsStateSuccses) {
              final comh2 = state.URG;
              // (باقي تصميم الشاشة كما هو تماماً)


              return SingleChildScrollView(
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 20),
                          child: Icon(Icons.arrow_back),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60, left: 50),
                          child: Text(
                            comh2.name,
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 25, bottom: 10),
                      child: Container(
                        height: 230,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(55),
                            // إضافة زوايا دائرية إذا أردت

                            child: Image.network(comh2.imageUrl)
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 30, right: 30, top: 10, bottom: 10),
                    //   child: Align(
                    //     alignment: Alignment.centerRight,
                    //     // محاذاة النص إلى اليمين
                    //     child: Text(
                    //       ":وصف الحالة",
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 10, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        // محاذاة النص إلى اليمين
                        child: Text(
                          "Description of the case".tr(),
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 13, right: 13, bottom: 2, top: 2),
                      child: Align(
                        alignment: Alignment.centerRight,
                        // محاذاة النص إلى اليمين
                        child: Text(
                          "the Description".tr() ,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 10, right: 30, top: 8, bottom: 8),
                      child: Align(
                        alignment: Alignment.centerRight,
                        // محاذاة النص إلى اليمين
                        child: Text(
                          ":الوقت المتبقي".tr(),
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 17, top: 10, bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),

                        child: LinearProgressIndicator(
                          value: comh2.timeProgress,
                          backgroundColor: Colors.grey[300],
                          minHeight: 14,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xff53A7D8),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 9, right: 4, top: 2, bottom: 4),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Card(
                                elevation: 20,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 3, right: 3, top: 3, bottom: 9),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        ": المبلغ الكلي".tr(),
                                        style: TextStyle(
                                          color: Color(0xff1976D2),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          comh2.required_amount.toString(),
                                          style: TextStyle(
                                            color: isDark ? Colors.white : Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 9, right: 1.2, top: 4, bottom: 4),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Card(
                                elevation: 20,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 0, top: 8, bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        ": المبلغ المحصل".tr(),
                                        style: TextStyle(
                                          color: Color(0xff1976D2),
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1),
                                        child: Text(
                                          comh2.collected_amount.toString(),
                                          style: TextStyle(
                                            color: isDark ? Colors.white : Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 9, right: 10, top: 4, bottom: 4),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Card(
                                elevation: 20,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 1.2, top: 8, bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        ": المبلغ المتبقي".tr(),
                                        style: TextStyle(
                                          color: Color(0xff1976D2),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,

                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1),
                                        child: Text(
                                          comh2.remaining_amount.toString(),
                                          style: TextStyle(
                                            color: isDark ? Colors.white : Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: 300,
                              child: ElevatedButton(
                                onPressed: () {
                                  showAddToCartDialog(context,comh2);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff53A7D8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    // side: BorderSide(color: Color(0xff1976B1)),
                                  ),
                                  elevation: 4,
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                ),
                                child: Text(
                                  "تبرع الآن".tr(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      // color: Color(0xff1976D2),
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10),
                        //   child: Expanded(
                        //     child: OutlinedButton(
                        //       onPressed: () {
                        //
                        //
                        //         final subProjectId = state.URG.id;
                        //         showAddToCartDialog2(context,comh2);
                        //
                        //         // الانتقال مباشرة للسلة
                        //         // context.read<BottomNavigationCubit>().changeIndex(3);
                        //         // Navigator.pushReplacementNamed(context, "cart");
                        //       },
                        //       style: OutlinedButton.styleFrom(
                        //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        //         padding: const EdgeInsets.symmetric(vertical: 16),
                        //       ),
                        //       child: Text(
                        //         "أضف للسلة".tr(),
                        //         style: TextStyle(
                        //           fontSize: 18,
                        //           color: isDark ? Colors.white : Colors.black,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),



                  ],
                ),
              );
            }
            else if(state is EmdetailsStateFailure){
              return Text(" Failed to load data");
            }
            else{
              return Container();
            }
          },
        ));
  }
}
Future<void> showAddToCartDialog(
    BuildContext context,
    Urgentdetails project, // تمرير المشروع الحالي
    ) async {

  TextEditingController amountController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("أدخل مبلغ التبرع".tr()),
      content: TextField(
        controller: amountController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: "المبلغ".tr()),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("إلغاء".tr()),
        ),
        ElevatedButton(
          onPressed: () async {
            final amount = double.tryParse(amountController.text) ?? 0;
            if (amount <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("الرجاء إدخال مبلغ صحيح".tr())),
              );
              return;
            }

            final prefs = await SharedPreferences.getInstance();
            final token = prefs.getString('donor_token');
            final userType = prefs.getString('user_type');
            final walletBalanceStr = prefs.getString('wallet_balance') ?? "0";
            final walletBalance = double.tryParse(walletBalanceStr) ?? 0;

            if (token != null && token.isNotEmpty) {

              if (project.remaining_amount <= 0) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("عذراً، هذا المشروع اكتمل".tr())),
                );
                return;
              }

              if (amount > project.remaining_amount) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("تبرعك يتجاوز حد المبلغ المتبقي للمشروع".tr())),
                );
                return;
              }

              if (walletBalance >= amount) {
                 context.read<WalletCubit>().doate(
                  campaignId: project.id,
                  amount: amount,
                  context: context,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${"تم التبرع بمبلغ".tr()}$amount \$${" للمشروع".tr()}${project.name}")),
                );

                context.read<WalletCubit>().getWallet();
                 final lang = context.locale.languageCode;
                 context.read<EmdetailsCubite>().loadEmergencyDetails(project.id,lang);
                Navigator.of(context).pop(); // إغلاق الديالوج بعد التبرع
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("عذراً، لا يوجد رصيد كافي. يرجى شحن المحفظة".tr())),
                );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => WalletPage()),
                  );

              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(

                    "الرجاء تسجيل الدخول اولا".tr()
                )),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Registedonatorr()),
              );
            }
          },
          child: Text("موافق".tr()),
        ),
      ],
    ),
  );
}
// Future<void> showAddToCartDialog2(
//     BuildContext context,
//     Urgentdetails project1, // تمرير المشروع الحالي
//     ) async {
//
//   TextEditingController amountController = TextEditingController();
//
//   await showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text("أدخل مبلغ التبرع".tr()),
//       content: TextField(
//         controller: amountController,
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(labelText: "المبلغ".tr()),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text("إلغاء".tr()),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             final amount = double.tryParse(amountController.text) ?? 0;
//             if (amount <= 0) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("الرجاء إدخال مبلغ صحيح".tr())),
//               );
//               return;
//             }
//             final lang = context.locale.languageCode;
//             final prefs = await SharedPreferences.getInstance();
//             final token = prefs.getString('donor_token');
//             final userType = prefs.getString('user_type');
//             final walletBalanceStr = prefs.getString('wallet_balance') ?? "0";
//             final walletBalance = double.tryParse(walletBalanceStr) ?? 0;
//             context.read<CartCubit>().addToCart(project1.id, amount.toInt(),lang);
//             context.read<BottomNavigationCubit>().changeIndex(3);
//             Navigator.pushReplacementNamed(context, "cart");
//
//           },
//           child: Text("موافق".tr()),
//         ),
//       ],
//     ),
//   );
// }
