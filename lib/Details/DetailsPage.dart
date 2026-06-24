// import 'package:Athar_Charity/model/partsItem.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../cubit/BottomBar Cubit/bottomba_cubit.dart';
// import '../cubit/CartCubit/cart_cubit.dart';
// import '../cubit/DetailsCubit/DetailsCubit.dart';
// import '../cubit/DetailsCubit/DetailsState.dart';
// import '../cubit/Wallet/wallet_cubit.dart';
// import '../firebase/firebaseApi.dart';
// import '../register/RegisteDonatorr.dart';
// import '../wallet.dart';
//
// class Detailspage extends StatelessWidget {
//
//   final TextEditingController amountController = TextEditingController();
//
//    Detailspage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//
//         body: BlocConsumer<Detailscubit, DetailsState>(
//           listener: (context, state) {
//
//           },
//
//
//
//           builder: (context, state) {
//
//
//
//             if (state is DetailsLoading) {
//               return CircularProgressIndicator();
//             }
//             if (state is DetailsSuccsess) {
//               final ageEntry = state.projectd.details.firstWhere(
//                     (details) => details['key'] == 'العمر',
//                 orElse: () => {'key': 'العمر', 'value': ''},
//               );
//               final ageValue = ageEntry['value'] ?? '';
//
//               final genderEntry = state.projectd.details.firstWhere(
//                     (details) => details['key'] == 'الجنس',
//                 orElse: () => {'key': 'الجنس', 'value': ''},
//               );
//               final genderValue =genderEntry ['value'] ?? '';
//               return Column(
//                 children: [
//                   Column(
//                     children: [
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.37,
//                         width: MediaQuery.of(context).size.width * 1,
//                         decoration: BoxDecoration(
//                           // borderRadius: BorderRadius.only(
//                           //   bottomRight: Radius.circular(40),
//                           //   bottomLeft: Radius.circular(40),
//                           // ),
//                           image: DecorationImage(
//                             image: NetworkImage(state.projectd.image),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//
//                       SizedBox(height: 30),
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(Icons.location_on,  color:  isDark ? Colors.white :Colors.black,),
//                                 SizedBox(width: 10),
//                                 Text(
//                                  state. projectd.location,
//                                   style: TextStyle(
//                                     color:  isDark ? Colors.white :Colors.black,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//
//                             Text(
//                               state.projectd.name,
//                               style: TextStyle(
//                                 color:  isDark ? Colors.white :Colors.black,
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       if (ageValue.isNotEmpty) ...[
//                         SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Align(
//
//                               child: Padding(padding: const EdgeInsets.symmetric(horizontal:30),
//                                 child: Row(
//                                   children: [
//
//                                     Text(
//                                       "$genderValue",
//                                       style: TextStyle(
//                                         color: isDark ? Colors.white : Colors.black,
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w600,
//                                       ),    textAlign: TextAlign.center,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 13),
//                                 child: Text(
//                                    "العمر: $ageValue",
//                                   style: TextStyle(
//                                     color: isDark ? Colors.white : Colors.black,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ),
//
//                           ],
//                         ),
//                       ],
//
//
//                       SizedBox(height: 30),
//                     ],
//                   ),
//
//                   // التاب بار
//                   TabBar(
//                     labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                     labelColor:  isDark ? Colors.white :Colors.blue,
//                     indicatorColor: isDark ? Colors.white :Colors.blue,
//                     unselectedLabelColor:         isDark ? Colors.white :Colors.black87,
//                     tabs: [
//                       Tab(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.attach_money_rounded),
//                             SizedBox(width: 8),
//                             Text("المبالغ",),
//                           ],
//                         ),
//                       ),
//                       Tab(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.list_alt),
//                             SizedBox(width: 8),
//                             Text("الاحتياجات",),
//                           ],
//                         ),
//                       ),
//                       Tab(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.volunteer_activism_outlined),
//                             SizedBox(width: 8),
//                             Text("التبرعات",),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   // محتوى كل تبويب
//                   Expanded(
//                     child: TabBarView(
//                       children: [
//                         // تبويب المبالغ
//                         SingleChildScrollView(
//                           child: Padding(
//                             padding: const EdgeInsets.all(20),
//                             child: Padding(
//                               padding: const EdgeInsets.all(25),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   // المبلغ الكلي
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//
//                                           Text(
//                                             "${state.projectd.requiredAmount}",
//                                             style: TextStyle(
//                                               color:  isDark ? Colors.white :Colors.black,
//                                               fontSize: 17,
//                                               fontWeight: FontWeight.bold,
//                                               // decoration: TextDecoration.underline,
//                                               decorationColor: Colors.green,
//                                               decorationThickness: 2,
//                                             ),
//                                           ),
//                                           Row(children: [
//                                             Icon(
//                                               Icons.attach_money,
//                                               color: Colors.blue,
//                                             ),
//                                             SizedBox(width: 8),
//                                             Text(
//                                               "المبلغ الكلي",
//                                               style: TextStyle(
//                                                 color:  isDark ? Colors.white :Colors.black,
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],)
//
//
//                                     ],
//                                   ),
//                                    SizedBox(height: 25),
//
//                                   // المبلغ المحصل
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//
//                                           Text(
//                                             "${state.projectd.collectedAmount}",
//                                             style: TextStyle(
//                                               color:  isDark ? Colors.white :Colors.black,
//                                               fontSize: 17,
//                                               fontWeight: FontWeight.bold,
//                                               //decoration: TextDecoration.underline,
//                                               decorationColor: Colors.green,
//                                               decorationThickness: 2,
//                                             ),
//                                           ),
//
//                                           Row(
//
//                                             children: [
//                                             Icon(
//                                               Icons.check_circle_outline,
//                                               color: Colors.green,
//                                             ),
//                                             SizedBox(width: 8),
//                                             Text(
//                                               "المبلغ المحصل",
//                                               style: TextStyle(
//                                                 color:  isDark ? Colors.white :Colors.black,
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],)
//
//
//                                     ],
//                                   ),
//                                   const SizedBox(height: 20),
//
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//
//                                           Text(
//                                             "${state.projectd.remainingAmount}",
//                                             style: TextStyle(
//                                               color:  isDark ? Colors.white :Colors.black,
//                                               fontSize: 17,
//                                               fontWeight: FontWeight.bold,
//                                               //decoration: TextDecoration.underline,
//                                               decorationColor: Colors.red,
//                                               decorationThickness: 2,
//                                             ),
//                                           ),
//                                         Row(children: [
//                                           Icon(
//                                             Icons.pending,
//                                             color: Colors.red,
//                                           ),
//                                           SizedBox(width: 8),
//                                           Text(
//                                             "المبلغ المتبقي",
//                                             style: TextStyle(
//                                               color:  isDark ? Colors.white :Colors.black,
//                                               fontSize: 17,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],)
//
//
//                                     ],
//                                   ),
//                                   const SizedBox(height: 40),
//                                   // شريط التقدم
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(10),
//                                     child: LinearProgressIndicator(
//                                       value: state.projectd.collectedAmount / state.projectd.requiredAmount,
//                                       backgroundColor: Colors.grey[300],
//                                       minHeight: 14,
//                                       valueColor:
//                                           const AlwaysStoppedAnimation<Color>(
//                                             Color(0xff53A7D8),
//                                           ),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 10),
//
//
//                                    Text(
//                                      " %نسبة التبرع المحصلة:   ${(state.projectd.collectedAmount / state.projectd.requiredAmount * 100).toStringAsFixed(0)}",
//                                     style: TextStyle(
//
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: isDark ? Colors.white : Color(0xff53A7D8),
//                                     ),
//                                                                     textAlign: TextAlign.center, ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         state.projectd.needs?.isNotEmpty ?? false
//                             ? Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 20,
//                                 vertical: 10,
//                               ),
//                               child: ListView(
//                                 children: [
//                                   Card(
//                                     color:  isDark ? Colors.white10 :Colors.white,
//                                     elevation: 10,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(20),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           for (var need in state.projectd.needs)
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                     vertical: 10,
//                                                   ),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.end,
//                                                 children: [
//                                                   Expanded(
//                                                     child: Text(
//                                                       need,
//                                                       style: TextStyle(
//                                                         fontSize: 18,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color:  isDark ? Colors.white :Colors.black,
//                                                       ),
//                                                       textAlign:
//                                                           TextAlign.right,
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 8),
//                                                   Icon(
//                                                     size: 10,
//                                                     Icons.circle,
//                                                     // رمز يدل على الحاجة
//                                                     color:   isDark ? Colors.white :Colors.blue,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                             : Center(
//                               child: Text(
//                                 "لا توجد احتياجات محددة لهذا التبرع",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ),
//                         SingleChildScrollView(
//                           child: Padding(
//                             padding: const EdgeInsets.all(31),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.only(left: 110),
//                                   child: Text(
//
//                                     ": ادخل المبلغ المراد التبرع به",
//                                     style: TextStyle(
//                                       color:  isDark ? Colors.white :Colors.black,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//
//                                 Form(
//                                   child: TextFormField(
//                                     controller: amountController,
//                                     keyboardType: TextInputType.number,
//
//                                     textAlign: TextAlign.right,
//                                     decoration: InputDecoration(
//                                       suffixText: '\$ ',
//                                       hintText: "0",
//                                       hintStyle: TextStyle(
//                                         color: Colors.grey.shade700,
//                                       ),
//                                       filled: true,
//                                       fillColor: Colors.white,
//
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(34),
//                                         borderSide: BorderSide(
//                                           color:  isDark ? Colors.white :Colors.black,
//                                         ),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(34),
//                                         borderSide: BorderSide(
//                                           color: Colors.blue.shade100,
//                                         ),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(34),
//                                         borderSide: BorderSide(
//                                           color:  isDark ? Colors.white :Colors.blue,
//                                           width: 1,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 50),
//
//                                 // الأزرار
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: OutlinedButton(
//                                         onPressed: () {
//                                           final enteredAmount = double.tryParse(amountController.text)??0.0;
//
//                                           if (enteredAmount <= 0) {
//                                             ScaffoldMessenger.of(context).showSnackBar(
//                                               SnackBar(content: Text("الرجاء إدخال مبلغ صحيح")),
//                                             );
//                                             return;
//                                           }
//
//                                           final subProjectId = state.projectd.id;
//                                           context.read<CartCubit>().addToCart(subProjectId, enteredAmount.toInt());
//
//                                           // الانتقال مباشرة للسلة
//                                           context.read<BottomNavigationCubit>().changeIndex(3);
//                                           Navigator.pushReplacementNamed(context, "cart");
//                                         },
//                                         style: OutlinedButton.styleFrom(
//                                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//                                           padding: const EdgeInsets.symmetric(vertical: 16),
//                                         ),
//                                         child: Text(
//                                           "أضف للسلة",
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             color: isDark ? Colors.white : Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//
//
//                                     const SizedBox(width: 20),
//                                     Expanded(
//                                       child: ElevatedButton(
//                                         onPressed: () async {
//
//                                           final amount = double.tryParse(amountController.text) ?? 0;
//
//                                           if (amount <= 0) {
//                                             ScaffoldMessenger.of(context).showSnackBar(
//                                               SnackBar(content: Text("الرجاء إدخال مبلغ صحيح")),
//                                             );
//                                             return;
//                                           }
//
//
//                                           final prefs = await SharedPreferences.getInstance();
//                                           final token = prefs.getString('donor_token');
//                                           final userType = prefs.getString('user_type');
//                                           final walletBalanceStr = prefs.getString('wallet_balance') ?? "0";
//                                           final walletBalance = double.tryParse(walletBalanceStr) ?? 0;
//
//                                           if (token != null && token.isNotEmpty) {
//                                             if (state.projectd.remainingAmount <= 0) {
//                                               ScaffoldMessenger.of(context).showSnackBar(
//                                                 SnackBar(content: Text("عذراً، هذا المشروع اكتمل")),
//                                               );
//                                               return;
//                                             }
//
//                                             if (amount > state.projectd.remainingAmount) {
//                                               ScaffoldMessenger.of(context).showSnackBar(
//                                                 SnackBar(content: Text("تبرعك يتجاوز حد المبلغ المتبقي للمشروع")),
//                                               );
//                                               return;
//                                             }
//
//
//                                             if (walletBalance >= amount) {
//
//                                               context.read<WalletCubit>().doate(
//                                                 subProjectId: state.projectd.id,
//                                                 amount: amount,
//                                                 context: context,
//                                               );
//                                               context.read<WalletCubit>().getWallet();
//                                              // int id=context.read<Project>().id;
//                                               //context.read<Detailscubit>().loadDetails(id, state.projectd.id);
//                                             } else {
//                                               ScaffoldMessenger.of(context).showSnackBar(
//                                                 SnackBar(content: Text("عذراً، لا يوجد رصيد كافي. يرجى شحن المحفظة")),
//                                               );
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(builder: (_) => WalletPage()),
//                                               );
//                                             }
//                                           } else {
//
//                                             ScaffoldMessenger.of(context).showSnackBar(
//                                               const SnackBar(content: Text("يرجى تسجيل الدخول أولاً")),
//                                             );
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(builder: (_) => Registedonatorr()),
//                                             );
//                                           }
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           iconColor: isDark ? Colors.white : Colors.blue,
//                                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//                                           padding: const EdgeInsets.symmetric(vertical: 16),
//                                         ),
//                                         child: const Text(
//                                           "تبرع",
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//
//
//
//
//                                   ],
//                                 ),SizedBox(height: 20,),
//                                 // Container(
//                                 //   padding: EdgeInsets.only(left: 90),
//                                 //   child: ElevatedButton(onPressed:(){
//                                 //     Navigator.push(
//                                 //       context,
//                                 //       MaterialPageRoute(builder: (_) => WalletPage()),
//                                 //     );
//                                 //   }, child: Text("تفقد المحفظة")),
//                                 // )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }
//             if (state is DetailsFailure) {
//               return Text("failed");
//             } else {
//               return Container();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
// Future<void> showAddToCartDialog(
//     BuildContext context, {
//       required Function(int amount) onAdd,
//     }) async {
//   TextEditingController amountController = TextEditingController();
//
//   await showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text('أدخل مبلغ التبرع'),
//       content: TextField(
//         controller: amountController,
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(labelText: 'المبلغ'),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text('إلغاء'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             final amount = int.tryParse(amountController.text);
//             if (amount != null && amount > 0) {
//               onAdd(amount); // تنفيذ الإضافة
//               Navigator.of(context).pop();
//             } else {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('الرجاء إدخال رقم صالح')),
//               );
//             }
//           },
//           child: Text('موافق'),
//         ),
//       ],
//     ),
//   );
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/BottomBar Cubit/bottomba_cubit.dart';
import '../cubit/CartCubit/cart_cubit.dart';
import '../cubit/DetailsCubit/DetailsCubit.dart';
import '../cubit/DetailsCubit/DetailsState.dart';
import '../cubit/Wallet/wallet_cubit.dart';
import '../register/RegisteDonatorr.dart';
import '../wallet.dart';

class Detailspage extends StatelessWidget {

  final TextEditingController amountController = TextEditingController();

  Detailspage({super.key});

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = context.locale.languageCode;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        body: BlocConsumer<Detailscubit, DetailsState>(
          listener: (context, state) {

          },



          builder: (context, state) {



            if (state is DetailsLoading) {
              return CircularProgressIndicator();
            }
            if (state is DetailsSuccsess) {
              //               final ageEntry = state.projectd.details.firstWhere(
              //       (details) => details['key'] == 'العمر',
              //   orElse: () => {'key': 'العمر', 'value': ''},
              // );
              // final ageValue = ageEntry['value'] ?? '';
              //
              // final genderEntry = state.projectd.details.firstWhere(
              //       (details) => details['key'] == 'الجنس',
              //   orElse: () => {'key': 'الجنس', 'value': ''},
              // );
              // final genderValue =genderEntry ['value'] ?? '';
              // final ageEntry = state.projectd.details.firstWhere(
              //       (details) => details['key'] == "العمر".tr(),
              //   orElse: () => {'key': "العمر".tr(), 'value': ''},
              // );
              // final ageValue = ageEntry['value'] ?? '';
              //
              // final genderEntry = state.projectd.details.firstWhere(
              //       (details) => details['key'] == "الجنس".tr(),
              //   orElse: () => {'key': "الجنس".tr(), 'value': ''},
              // );
              // final genderValue =genderEntry ['value'] ?? '';
              return Column(
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.37,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.only(
                          //   bottomRight: Radius.circular(40),
                          //   bottomLeft: Radius.circular(40),
                          // ),
                          image: DecorationImage(
                            image: NetworkImage(state.projectd.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(

                              child: Text(
                                state.projectd.name,
                                style: TextStyle(
                                  color:  isDark ? Colors.white :Colors.black,
                                  fontSize:20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),SizedBox(height: 12,),
                            Row(
                              children: [

                                Icon(Icons.location_on,  color:  isDark ? Colors.white :Colors.black,),
                                SizedBox(width: 10),
                                Container(

                                  child: Text(
                                    state. projectd.location,
                                    style: TextStyle(
                                      color:  isDark ? Colors.white :Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),



                          ],
                        ),
                      ),

            //                 if (ageValue.isNotEmpty || genderValue.isNotEmpty) ...[
            // SizedBox(height: 20),
            // Padding(
            // padding: const EdgeInsets.symmetric(horizontal: 16.0),
            // // child: Row(
            // // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // // children: [
            // // // الجنس
            // //
            // // // العمر
            // // Text(
            // // ageValue.isNotEmpty ? "العمر: $ageValue".tr() : "",
            // // style: TextStyle(
            // // color: isDark ? Colors.white : Colors.black,
            // // fontSize: 18,
            // // fontWeight: FontWeight.w600,
            // // ),
            // // ),
            // //   Text(
            // //     genderValue.isNotEmpty ? genderValue.tr() : "",
            // //     style: TextStyle(
            // //       color: isDark ? Colors.white : Colors.black,
            // //       fontSize: 18,
            // //       fontWeight: FontWeight.w600,
            // //     ),
            // //   ),
            // // ],
            // // ),
            // ),
            // ],

            SizedBox(height: 20),
                    ],
                  ),

                  // التاب بار
                  TabBar(
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    labelColor:  isDark ? Colors.white :Colors.blue,
                    indicatorColor: isDark ? Colors.white :Colors.blue,
                    unselectedLabelColor:         isDark ? Colors.white :Colors.black87,
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.attach_money_rounded),
                            SizedBox(width: 0),
                            Flexible(
                              child: Text(
                                "المبالغ".tr(),
                                overflow: TextOverflow.clip, // يخلي النص يختصر بدل ما يخرج
                              ),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.list_alt),
                            SizedBox(width: 0),
                            Text("الاحتياجات".tr(),),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.volunteer_activism_outlined),
                            SizedBox(width: 8),
                            Text("التبرعات".tr()),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // محتوى كل تبويب
                  Expanded(
                    child: TabBarView(
                      children: [
                        // تبويب المبالغ
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // المبلغ الكلي
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text(
                                        "${state.projectd.requiredAmount}",
                                        style: TextStyle(
                                          color:  isDark ? Colors.white :Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          // decoration: TextDecoration.underline,
                                          decorationColor: Colors.green,
                                          decorationThickness: 2,
                                        ),
                                      ),
                                      Row(children: [
                                        Icon(
                                          Icons.attach_money,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          ": المبلغ الكلي".tr(),
                                          style: TextStyle(
                                            color:  isDark ? Colors.white :Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],)


                                    ],
                                  ),
                                  SizedBox(height: 25),

                                  // المبلغ المحصل
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text(
                                        "${state.projectd.collectedAmount}",
                                        style: TextStyle(
                                          color:  isDark ? Colors.white :Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          //decoration: TextDecoration.underline,
                                          decorationColor: Colors.green,
                                          decorationThickness: 2,
                                        ),
                                      ),

                                      Row(

                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            ": المبلغ المحصل".tr(),
                                            style: TextStyle(
                                              color:  isDark ? Colors.white :Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],)


                                    ],
                                  ),
                                  const SizedBox(height: 20),

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text(
                                        "${state.projectd.remainingAmount}",
                                        style: TextStyle(
                                          color:  isDark ? Colors.white :Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          //decoration: TextDecoration.underline,
                                          decorationColor: Colors.red,
                                          decorationThickness: 2,
                                        ),
                                      ),
                                      Row(children: [
                                        Icon(
                                          Icons.pending,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          ": المبلغ المتبقي".tr()
                                          ,
                                          style: TextStyle(
                                            color:  isDark ? Colors.white :Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],)


                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  // شريط التقدم
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value: state.projectd.collectedAmount / state.projectd.requiredAmount,
                                      backgroundColor: Colors.grey[300],
                                      minHeight: 14,
                                      valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        Color(0xff53A7D8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),


                                  Text(
                                    "${"النسبة".tr()}${(state.projectd.collectedAmount / state.projectd.requiredAmount * 100).toStringAsFixed(0)}",
                                    style: TextStyle(

                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: isDark ? Colors.white : Color(0xff53A7D8),
                                    ),
                                    textAlign: TextAlign.center, ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        state.projectd.needs.isNotEmpty ?? false
                            ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: ListView(
                            children: [
                              Card(
                                color:  isDark ? Colors.white10 :Colors.white,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      for (var need in state.projectd.needs)
                                        Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  need,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color:  isDark ? Colors.white :Colors.black,
                                                  ),
                                                  textAlign:
                                                  TextAlign.right,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Icon(
                                                size: 10,
                                                Icons.circle,
                                                // رمز يدل على الحاجة
                                                color:   isDark ? Colors.white :Colors.blue,
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                            : Center(
                          child: Text(
                            "لا توجد احتياجات محددة لهذا التبرع".tr(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(31),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 1),
                                  child: Text(

                                    ": ادخل المبلغ المراد التبرع به".tr(),
                                    style: TextStyle(
                                      color:  isDark ? Colors.white :Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                Form(
                                  child: TextFormField(
                                    controller: amountController,
                                    keyboardType: TextInputType.number,

                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      suffixText: '\$ ',
                                      hintText: "0",
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade700,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(34),
                                        borderSide: BorderSide(
                                          color:  isDark ? Colors.white :Colors.black,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(34),
                                        borderSide: BorderSide(
                                          color: Colors.blue.shade100,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(34),
                                        borderSide: BorderSide(
                                          color:  isDark ? Colors.white :Colors.blue,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 50),

                                // الأزرار
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          final enteredAmount = double.tryParse(amountController.text)??0.0;

                                          if (enteredAmount <= 0) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text("الرجاء إدخال رقم صحيح".tr())),
                                            );
                                            return;
                                          }

                                          final subProjectId = state.projectd.id;
                                          context.read<CartCubit>().addToCart(subProjectId, enteredAmount.toInt(),lang);

                                          // الانتقال مباشرة للسلة
                                          context.read<BottomNavigationCubit>().changeIndex(3);
                                          Navigator.pushReplacementNamed(context, "cart");
                                        },
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                        ),
                                        child: Text(
                                          "أضف للسلة".tr(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: isDark ? Colors.white : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),


                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {

                                          final amount = double.tryParse(amountController.text) ?? 0;

                                          if (amount <= 0) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text("الرجاء إدخال رقم صحيح".tr())),
                                            );
                                            return;
                                          }


                                          final prefs = await SharedPreferences.getInstance();
                                          final token = prefs.getString('donor_token');
                                          final userType = prefs.getString('user_type');
                                          final walletBalanceStr = prefs.getString('wallet_balance') ?? "0";
                                          final walletBalance = double.tryParse(walletBalanceStr) ?? 0;

                                          if (token != null && token.isNotEmpty) {
                                            if (state.projectd.remainingAmount <= 0) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text("عذراً، هذا المشروع اكتمل".tr())),
                                              );
                                              return;
                                            }

                                            if (amount > state.projectd.remainingAmount) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text( "تبرعك يتجاوز حد المبلغ المتبقي للمشروع".tr())),
                                              );
                                              return;
                                            }

                                            if (walletBalance >= amount) {

                                              context.read<WalletCubit>().doate(
                                                subProjectId: state.projectd.id,
                                                amount: amount,
                                                context: context,
                                              );
                                              context.read<WalletCubit>().getWallet();
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
                                                SnackBar(content: Text("الرجاء تسجيل الدخول اولا".tr()),
                                                ));
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (_) => Registedonatorr()),
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          iconColor: isDark ? Colors.white : Colors.blue,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                        ),
                                        child: Text(
                                          "تبرع".tr(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),




                                  ],
                                ),SizedBox(height: 20,),
                                // Container(
                                //   padding: EdgeInsets.only(left: 90),
                                //   child: ElevatedButton(onPressed:(){
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(builder: (_) => WalletPage()),
                                //     );
                                //   }, child: Text("تفقد المحفظة")),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            if (state is DetailsFailure) {
              return Text("failed");
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
Future<void> showAddToCartDialog(
    BuildContext context, {
      required Function(int amount) onAdd,
    }) async {
  TextEditingController amountController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("أدخل مبلغ التبرع".tr()),
      content: TextField(
        controller: amountController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText:"المبلغ".tr()),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("إلغاء".tr()),
        ),
        ElevatedButton(
          onPressed: () {
            final amount = int.tryParse(amountController.text);
            if (amount != null && amount > 0) {
              onAdd(amount); // تنفيذ الإضافة
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("الرجاء إدخال رقم صحيح".tr())),
              );
            }
          },
          child: Text("موافق".tr()),
        ),
      ],
    ),
  );
}
