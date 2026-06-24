import 'package:Athar_Charity/cubit/Wallet/wallet_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class WalletPage extends StatelessWidget {
  final int? subProjectId;
  WalletPage({super.key, this.subProjectId});
  final TextEditingController amountController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<WalletCubit>().getWallet();

    return Scaffold(
      appBar: AppBar(
        title: Text("المحفظة".tr()),
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          if (state is WalletLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WalletSucsess) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // بطاقة المحفظة
                    Container(
                      width: double.infinity,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.lightBlueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 210),
                            child: Text(
                              "رصيد المحفظة".tr(),
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add_circle, size: 36, color: Colors.white),
                                onPressed: () {
                                  showTopUpDialog(context, (amount) {
                                    print("شحن المحفظة بمبلغ: "+"$amount");

                                  });
                                },
                              ),
                              Text(
                                "${state.balance} \$",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40),

                    // إدخال مبلغ التبرع
              //       Text(
              //         ": ادخل المبلغ المراد التبرع به",
              //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(height: 20),
              //
              //       Form(
              //         child: TextFormField(
              //           controller: amountController2,
              //           keyboardType: TextInputType.number,
              //           textAlign: TextAlign.right,
              //           decoration: InputDecoration(
              //             suffixText: '\$',
              //             hintText: "0",
              //             hintStyle: TextStyle(color: Colors.grey.shade700),
              //             filled: true,
              //             fillColor: Colors.grey.shade200,
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(34),
              //               borderSide: BorderSide.none,
              //             ),
              //           ),
              //         ),
              //       ),
              //
              //       SizedBox(height: 30),
              //
              //       // زر التبرع
              //       SizedBox(
              //     width: 200,
              //         child: ElevatedButton(
              //           onPressed: () {
              //             final amount = double.tryParse(amountController2.text);
              //             if (amount != null && amount > 0) {
              //               context.read<WalletCubit>().doate(subProjectId: subProjectId,amount: amount,context: context);
              //               context.read<WalletCubit>().getWallet();
              //             } else {
              //               ScaffoldMessenger.of(context).showSnackBar(
              //                 SnackBar(content: Text('الرجاء إدخال رقم صحيح')),
              //               );
              //             }
              //           },
              //           child: Text("تبرع"),
              //           style: ElevatedButton.styleFrom(
              //             padding: EdgeInsets.symmetric(vertical: 16),
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(30),
              //             ),
              //             backgroundColor: Colors.blueAccent,
              //             textStyle: TextStyle(fontSize: 18),
              //           ),
              //         ),
              //       ),
                   ],
              ),
              ),
            );
          } else if (state is WalletFailure) {
            return Center(child: Text("حدث خطأ في جلب البيانات"));
          }
          return Container();
        },
      ),
    );
  }
}

Future<void> showTopUpDialog(BuildContext context, Function(double) onTopUp) async {
  TextEditingController amountController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("شحن المحفظة".tr()),
      content: TextField(
        controller: amountController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: "أدخل مبلغ الشحن".tr()),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("إلغاء"),
        ),
        ElevatedButton(
          onPressed: () {
            final amount = double.tryParse(amountController.text);
            if (amount != null && amount > 0) {
              onTopUp(amount);
              Navigator.of(context).pop();
              context.read<WalletCubit>().recharge(amount);
              context.read<WalletCubit>().getWallet();
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

