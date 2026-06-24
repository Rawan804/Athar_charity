// import 'package:Athar_Charity/register/RegisteDonatorr.dart';
// import 'package:Athar_Charity/wallet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'BottomBar/bottombar.dart';
// import 'cubit/BottomBar Cubit/bottomba_cubit.dart';
// import 'cubit/CartCubit/cart_cubit.dart';
// import 'cubit/CartCubit/cart_state.dart';
// import 'cubit/Wallet/wallet_cubit.dart';
// import 'model/cartModel.dart';
//
// class Cart extends StatelessWidget {
//   Cart({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             context.read<BottomNavigationCubit>().changeIndex(2);
//             Navigator.pushNamed(context, "home");
//           },
//         ),
//         title: Text(
//           "سلة التبرعات",
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       bottomNavigationBar: Bottombar(),
//       body: BlocBuilder<CartCubit, CartState>(
//         builder: (context, state) {
//           if (state is CartLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is CartSuccsess) {
//             final subProjects = state.cart.subProjects;
//
//             // إذا السلة فارغة
//             if (subProjects.isEmpty) {
//               return Center(
//                 child: Text(
//                   "السلة فارغة",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               );
//             }
//
//             // السلة تحتوي عناصر
//             return ListView.builder(
//               padding: EdgeInsets.all(16),
//               itemCount: subProjects.length + 1,
//               itemBuilder: (context, index) {
//                 if (index < subProjects.length) {
//                   final item = subProjects[index];
//                   return Card(
//                     elevation: 7,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     margin: EdgeInsets.only(bottom: 16),
//                     child: Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Image.network(
//                               item.image,
//                               width: 80,
//                               height: 100,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item.name,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   "${item.amount.toStringAsFixed(2)} \$",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.orange,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.delete, color: Colors.red),
//                             onPressed: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: Text("تأكيد الحذف"),
//                                     content: Text(
//                                       "هل أنت متأكد أنك تريد حذف ${item.name}؟",
//                                     ),
//                                     actions: <Widget>[
//                                       TextButton(
//                                         child: Text("لا"),
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                         },
//                                       ),
//                                       TextButton(
//                                         child: Text("نعم"),
//                                         onPressed: () {
//                                           context.read<CartCubit>().delet(
//                                             state.cart.cart_id,
//                                             item.id,
//                                           );
//                                           Navigator.of(context).pop();
//                                           context.read<CartCubit>().showCart(
//                                             state.cart.cart_id,
//                                           );
//                                         },
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.edit, color: Colors.black),
//                             onPressed: () {
//                               showEditPriceDialog(context, item, (newPrice) {
//                                 context.read<CartCubit>().updat(
//                                   state.cart.cart_id,
//                                   item.id,
//                                   newPrice,
//                                 );
//                                 context.read<CartCubit>().showCart(
//                                   state.cart.cart_id,
//                                 );
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 } else {
//                   // زر التبرع + الإجمالي
//                   final amount = state.cart.totalAmount;
//
//                   return Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 2, vertical: 40),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                     onPressed: () async {
//                   final prefs = await SharedPreferences.getInstance();
//                   final token = prefs.getString('donor_token');
//                   final userType = prefs.getString('user_type');
//
//                   if ((token != null && token.isNotEmpty) ) {
//                   final walletBalanceStr = prefs.getString('wallet_balance') ?? "0";
//                   final walletBalance = double.tryParse(walletBalanceStr) ?? 0;
//
//                   if (walletBalance >= amount) {
//                   // استدعاء dontCar وانتظار اكتمال العملية
//                   await context.read<CartCubit>().dontCar(state.cart.cart_id);
//
//                   // بعد ما تفريغ السلة يتم تحديثها
//                   context.read<CartCubit>().showCart(state.cart.cart_id);
//
//                   ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("تم التبرع بمبلغ $amount \$")),
//                   );
//
//                   context.read<WalletCubit>().getWallet();
//                   } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                   content: Text("عذراً، لا يوجد رصيد كافي. يرجى شحن المحفظة")),
//                   );
//                   Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => WalletPage()),
//                   );
//                   }
//                   } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("يرجى تسجيل الدخول أولاً")),
//                   );
//                   Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => Registedonatorr()),
//                   );
//                   }
//                   },
//
//
//                             style: OutlinedButton.styleFrom(
//                                 foregroundColor:Colors.blueAccent,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                               padding: const EdgeInsets.symmetric(vertical: 10),
//                             ),
//                             child: const Text(
//                               "تأكيد التبرع",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),SizedBox(width: 30,),
//                         Row(
//                           children: [
//                             Text(
//                               "${state.cart.totalAmount.toStringAsFixed(2)} \$",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.orange,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                             Text(
//                               ":الإجمالي",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               },
//             );
//           } else if (state is CartFailure) {
//             return Center(child: Text("فشل تحميل السلة"));
//           } else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }
// }
//
// Future<void> showEditPriceDialog(
//     BuildContext context,
//     SubProjectInCart subproject,
//     Function(double newPrice) onPriceChanged,
//     ) async {
//   TextEditingController amountController = TextEditingController(
//     text: subproject.amount.toString(),
//   );
//
//   await showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text('تعديل مبلغ التبرع لـ ${subproject.name}'),
//       content: TextField(
//         controller: amountController,
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(labelText: 'أدخل مبلغ التبرع الجديد'),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text('إلغاء'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             final newPrice = double.tryParse(amountController.text) ?? 0.0;
//             if (newPrice > 0) {
//               onPriceChanged(newPrice);
//               Navigator.of(context).pop();
//             } else {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('الرجاء إدخال رقم صحيح')),
//               );
//             }
//           },
//           child: Text('موافق'),
//         ),
//       ],
//     ),
//   );
// }
import 'package:Athar_Charity/register/RegisteDonatorr.dart';
import 'package:Athar_Charity/wallet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BottomBar/bottombar.dart';
import 'cubit/BottomBar Cubit/bottomba_cubit.dart';
import 'cubit/CartCubit/cart_cubit.dart';
import 'cubit/CartCubit/cart_state.dart';
import 'cubit/Wallet/wallet_cubit.dart';
import 'model/cartModel.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final lang =context.locale.languageCode;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.read<BottomNavigationCubit>().changeIndex(2);
            Navigator.pushNamed(context, "home");
          },
        ),
        title: Text(
          "cart".tr(),
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: Bottombar(),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartSuccsess) {
            final subProjects = state.cart.subProjects;

            // إذا السلة فارغة
            if (subProjects.isEmpty) {
              return Center(
                child: Text(
                  "السلة فارغة".tr(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,   color: isDark ? Colors.white : Colors.black,),
                ),
              );
            }

            // السلة تحتوي عناصر
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: subProjects.length + 1,
              itemBuilder: (context, index) {
                if (index < subProjects.length) {
                  final item = subProjects[index];
                  return Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.network(
                              item.image,
                              width: 80,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "${item.amount.toStringAsFixed(2)} \$",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "تأكيد الحذف".tr(),
                                      style: TextStyle(
                                        color: Colors.red, // 👈 اللون الأحمر
                                        fontWeight: FontWeight.bold, // (اختياري) يخليها أوضح
                                      ),
                                    ),


                                    content: Text(
                                        "${" حذف".tr()}${item.name}"
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("لا".tr()),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text("نعم".tr()),
                                        onPressed: () {
                                          context.read<CartCubit>().delet(
                                            state.cart.cart_id,
                                            item.id,

                                          );
                                          Navigator.of(context).pop();
                                          context.read<CartCubit>().showCart(
                                            state.cart.cart_id,

                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.black),
                            onPressed: () {
                              showEditPriceDialog(context, item, (newPrice) {
                                context.read<CartCubit>().updat(
                                  state.cart.cart_id,
                                  item.id,
                                  newPrice,

                                );
                                context.read<CartCubit>().showCart(
                                  state.cart.cart_id,

                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // زر التبرع + الإجمالي
                  final amount = state.cart.totalAmount;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              " الإجمالي:".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),SizedBox(width: 5,),
                            Text(
                              "${state.cart.totalAmount.toStringAsFixed(2)} \$",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),


                          ],
                        ),   SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.only(right: 50),
                          child: OutlinedButton(
                            onPressed: () async {
                              final prefs = await SharedPreferences.getInstance();
                              final token = prefs.getString('donor_token');
                              final userType = prefs.getString('user_type');

                              if ((token != null && token.isNotEmpty)) {
                                final walletBalanceStr = prefs.getString('wallet_balance') ?? "0";
                                final walletBalance = double.tryParse(walletBalanceStr) ?? 0;

                                if (walletBalance >= amount) {
                                  await context.read<CartCubit>().dontCar(state.cart.cart_id);
                                  context.read<CartCubit>().showCart(state.cart.cart_id);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("مبلغ" + "$amount \$".tr())),
                                  );

                                  context.read<WalletCubit>().getWallet();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("عذراً، لا يوجد رصيد كافي. يرجى شحن المحفظة".tr()),
                                    ),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => WalletPage()),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("يرجى تسجيل الدخول أولاً".tr())),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => Registedonatorr()),
                                );
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Color(0xff53A7D8)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                              backgroundColor: Colors.white, // لون خلفية الزر
                              shadowColor: Colors.grey.withOpacity(0.5), // لون ظل الزر
                              elevation: 5, // ارتفاع الظل
                            ),
                            child: Text(
                              "تأكيد التبرع".tr(),
                              style: TextStyle(
                                fontSize: 15,// زيادة حجم الخط
                                color: Color(0xff53A7D8), // تغيير لون النص
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30),


                      ],
                    ),
                  );
                }
              },
            );
          } else if (state is CartFailure) {
            return Center(child: Text("فشل تحميل السلة".tr()));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

Future<void> showEditPriceDialog(
    BuildContext context,
    SubProjectInCart subproject,
    Function(double newPrice) onPriceChanged,
    ) async {
  TextEditingController amountController = TextEditingController(
    text: subproject.amount.toString(),
  );

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: RichText(
        text: TextSpan(
          text: "تعديل مبلغ التبرع لـ".tr(), // الجزء الأول
          style: DefaultTextStyle.of(context).style.copyWith(
            fontSize: 16,
            color: Colors.black, // لون النص الأول
          ),
          children: [
            TextSpan(
              text: " ${subproject.name}", // الجزء الثاني
              style: TextStyle(
                color: Colors.red, // 👈 هنا غير اللون
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      content: TextField(
        controller: amountController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: "أدخل مبلغ التبرع الجديد".tr()),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("إلغاء".tr()),
        ),
        ElevatedButton(
          onPressed: () {
            final newPrice = double.tryParse(amountController.text) ?? 0.0;
            if (newPrice > 0) {
              onPriceChanged(newPrice);
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
