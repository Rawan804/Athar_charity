import 'package:Athar_Charity/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/Beneficary/beneficary_cubit.dart';
import 'cubit/BottomBar Cubit/bottomba_cubit.dart';


class SupportRequest extends StatelessWidget {
  TextEditingController health_status = TextEditingController();
  TextEditingController job_status = TextEditingController();
  TextEditingController monthly_income = TextEditingController();
  TextEditingController support_type = TextEditingController();
  TextEditingController total_number_of_children = TextEditingController();
  TextEditingController number_of_disabled_children = TextEditingController();
  TextEditingController needs = TextEditingController();

  final ValueNotifier<bool?> is_male = ValueNotifier(null);
  final ValueNotifier<bool?> is_single = ValueNotifier(null);
  final ValueNotifier<bool?> is_urgent = ValueNotifier(null);
  final ValueNotifier<bool?> has_family = ValueNotifier(null);
  final ValueNotifier<bool?> is_male_breadwinner_for_family = ValueNotifier(null);
  final ValueNotifier<bool?> is_female_breadwinner_for_family = ValueNotifier(null);
  final ValueNotifier<bool?> is_youth_without_family = ValueNotifier(null);
  final ValueNotifier<bool?> is_girl_without_family = ValueNotifier(null);
  final ValueNotifier<bool?> is_orphan = ValueNotifier(null);
  final ValueNotifier<bool?> is_injured = ValueNotifier(null);
  final ValueNotifier<bool?> is_disabled = ValueNotifier(null);

  final _formKey = GlobalKey<FormState>();

  SupportRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/img_33.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BlocConsumer<BeneficaryCubit, BeneficaryState>(
            listener: (context, state) {
              if (state is BeneficarySuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("تم تسجيل الدخول بنجاح".tr())),
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<BeneficaryCubit>();

              return Padding(
                padding: const EdgeInsets.only(top: 120, bottom: 10, left: 30, right: 30),
                child: Center(
                  child: SingleChildScrollView(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Center(child: Text("مرحباً".tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center)),
                                Center(child: Text("سجل معلوماتك لطلب المساعدة".tr(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey), textAlign: TextAlign.center)),
                                SizedBox(height: 20),
                                Text("الجنس".tr()),
                                ValueListenableBuilder<bool?>(
                                  valueListenable: is_male,
                                  builder: (_, selected, __) => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: RadioListTile<bool>(
                                          title: Text("ذكر".tr()),
                                          value: true,
                                          groupValue: selected,
                                          onChanged: (val) => is_male.value = val,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      ),
                                      Expanded(
                                        child: RadioListTile<bool>(
                                          title: Text("أنثى".tr()),
                                          value: false,
                                          groupValue: selected,
                                          onChanged: (val) => is_male.value = val,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Text("هل الحالة طارئة".tr()),
                                ValueListenableBuilder<bool?>(
                                  valueListenable: is_urgent,
                                  builder: (_, selected, __) => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: RadioListTile<bool>(
                                          title: Text("لا".tr()),
                                          value: false,
                                          groupValue: selected,
                                          onChanged: (val) => is_urgent.value = val,
                                        ),
                                      ),
                                      Expanded(
                                        child: RadioListTile<bool>(
                                          title: Text("نعم".tr()),
                                          value: true,
                                          groupValue: selected,
                                          onChanged: (val) => is_urgent.value = val,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),

                                SizedBox(height: 20),
                                ValueListenableBuilder<bool?>(
                                  valueListenable: is_male,
                                  builder: (context, isMaleSelected, _) {
                                    if (isMaleSelected == null) {
                                      return Text("يرجى اختيار الجنس أولاً".tr());
                                    }
                                    if (isMaleSelected) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("الحالة الاجتماعية".tr()),
                                          ValueListenableBuilder<bool?>(
                                            valueListenable: is_single,
                                            builder: (_, selected, __) => Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("متزوج".tr()),
                                                    value: false,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_single.value = val,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("أعزب".tr()),
                                                    value: true,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_single.value = val,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                       SizedBox(height: 12),
                                          Text("هل لديك عائلة".tr()),
                                          ValueListenableBuilder<bool?>(
                                            valueListenable: has_family,
                                            builder: (_, selected, __) => Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("لا".tr()),
                                                    value: false,
                                                    groupValue: selected,
                                                    onChanged: (val) => has_family.value = val,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("نعم".tr()),
                                                    value: true,
                                                    groupValue: selected,
                                                    onChanged: (val) => has_family.value = val,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 20),
                                          Text("هل أنت معيل عائلة".tr()),
                                          ValueListenableBuilder<bool?>(
                                            valueListenable: is_male_breadwinner_for_family,
                                            builder: (_, selected, __) => Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("لا".tr()),
                                                    value: false,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_male_breadwinner_for_family.value = val,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("نعم".tr()),
                                                    value: true,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_male_breadwinner_for_family.value = val,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 20),

                                          Text("هل أنت شاب بدون عائلة".tr()),
                                          ValueListenableBuilder<bool?>(
                                            valueListenable: is_youth_without_family,
                                            builder: (_, selected, __) => Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("لا".tr()),
                                                    value: false,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_youth_without_family.value = val,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("نعم".tr()),
                                                    value: true,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_youth_without_family.value = val,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          Text("هل أنت يتيم ؟".tr()),
                                          ValueListenableBuilder<bool?>(
                                            valueListenable: is_orphan,
                                            builder: (_, selected, __) => Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("لا".tr()),
                                                    value: false,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_orphan.value = val,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("نعم".tr()),
                                                    value: true,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_orphan.value = val,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),


                                          Text("هل أنت مصاب ؟".tr()),
                                          ValueListenableBuilder<bool?>(
                                            valueListenable: is_injured,
                                            builder: (_, selected, __) => Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("لا".tr()),
                                                    value: false,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_injured.value = val,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("نعم".tr()),
                                                    value: true,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_injured.value = val,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),


                                          Text("الاحتياجات الخاصة".tr()),
                                          ValueListenableBuilder<bool?>(
                                            valueListenable: is_disabled,
                                            builder: (_, selected, __) => Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("لا".tr()),
                                                    value: false,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_disabled.value = val,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("نعم".tr()),
                                                    value: true,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_disabled.value = val,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("الحالة الاجتماعية".tr()),
                                          ValueListenableBuilder<bool?>(
                                            valueListenable: is_single,
                                            builder: (_, selected, __) =>
                                                Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                      child: RadioListTile<bool>(
                                                        title: Text("متزوجة".tr(),style: TextStyle(fontSize: 14)),
                                                        value: true,
                                                        groupValue: selected,
                                                        onChanged: (val) => is_single.value = val,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: RadioListTile<bool>(
                                                        title: Text("عزباء".tr(),style: TextStyle(fontSize: 14),),
                                                        value: false,
                                                        groupValue: selected,
                                                        onChanged: (val)=>is_single.value = val,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          ),        SizedBox(height: 12),
                                          Text("هل لديك عائلة".tr()),
                                          ValueListenableBuilder<bool?>(
                                            valueListenable: has_family,
                                            builder: (_, selected, __) => Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("لا".tr()),
                                                    value: false,
                                                    groupValue: selected,
                                                    onChanged: (val) => has_family.value = val,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("نعم".tr()),
                                                    value: true,
                                                    groupValue: selected,
                                                    onChanged: (val) => has_family.value = val,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text("هل أنتِ معيلة عائلة ".tr()),
                                          ValueListenableBuilder<bool?>(
                                            valueListenable: is_female_breadwinner_for_family,
                                            builder: (_, selected, __) => Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("لا".tr()),
                                                    value: false,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_female_breadwinner_for_family.value = val,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("نعم".tr()),
                                                    value: true,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_female_breadwinner_for_family.value = val,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 12),
                                          Text("هل أنتِ فتاة بدون عائلة".tr()),
                                          ValueListenableBuilder<bool?>(
                                            valueListenable: is_girl_without_family,
                                            builder: (_, selected, __) => Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("لا".tr()),
                                                    value: false,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_girl_without_family.value = val,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("نعم".tr()),
                                                    value: true,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_girl_without_family.value = val,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text("هل أنتِ يتيمة ؟".tr()),
                                          ValueListenableBuilder<bool?>(
                                            valueListenable: is_orphan,
                                            builder: (_, selected, __) => Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("لا".tr()),
                                                    value: false,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_orphan.value = val,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("نعم".tr()),
                                                    value: true,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_orphan.value = val,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text("هل أنتِ مصابة ؟".tr()),
                                          ValueListenableBuilder<bool?>(
                                            valueListenable: is_injured,
                                            builder: (_, selected, __) => Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("لا".tr()),
                                                    value: false,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_injured.value = val,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("نعم".tr()),
                                                    value: true,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_injured.value = val,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text("الاحتياجات الخاصة".tr()),
                                          ValueListenableBuilder<bool?>(
                                            valueListenable: is_disabled,
                                            builder: (_, selected, __) => Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("لا".tr()),
                                                    value: false,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_disabled.value = val,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<bool>(
                                                    title: Text("نعم".tr()),
                                                    value: true,
                                                    groupValue: selected,
                                                    onChanged: (val) => is_disabled.value = val,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                                TextFormField(
                                  controller: health_status,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "يرجى إدخال الحالة الصحية".tr();
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: Align(alignment: Alignment.centerRight, child: Text("الحالة الصحية".tr())),
                                    suffixIcon: Icon(Icons.health_and_safety_rounded, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 12),
                                TextFormField(
                                  controller: job_status,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "يرجى إدخال العمل الحالي".tr();
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: Align(alignment: Alignment.centerRight, child: Text("العمل الحالي ".tr())),
                                    suffixIcon: Icon(Icons.work, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 12),
                                TextFormField(
                                  controller: monthly_income,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "يرجى إدخال المدخول الشهري".tr();
                                    }
                                    if (double.tryParse(value) == null) {
                                      return "الرجاء إدخال رقم صحيح".tr();
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: Align(alignment: Alignment.centerRight, child: Text("المدخول الشهري".tr())),
                                    suffixIcon: Icon(Icons.attach_money_rounded, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: support_type,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "يرجى إدخال نوع الدعم المراد".tr();
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: Align(alignment: Alignment.centerRight, child: Text("نوع الدعم المراد".tr())),
                                    suffixIcon: Icon(Icons.support, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 12),
                                TextFormField(
                                  controller: total_number_of_children,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "يرجى إدخال عدد الأطفال".tr();
                                    }
                                    if (int.tryParse(value) == null) {
                                      return "الرجاء إدخال رقم صحيح".tr();
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: Align(alignment: Alignment.centerRight, child: Text("عدد الأطفال".tr())),
                                    suffixIcon: Icon(Icons.people_alt_sharp, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 12),
                                TextFormField(
                                  controller: number_of_disabled_children,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "يرجى إدخال عدد الأطفال ذوي الاحتياجات الخاصة".tr();
                                    }
                                    if (int.tryParse(value) == null) {
                                      return "الرجاء إدخال رقم صحيح".tr();
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: Align(alignment: Alignment.topRight, child: Text("عدد الأطفال ذوي الاحتياجات ".tr())),
                                    suffixIcon: Icon(Icons.accessible, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 12),
                                TextFormField(
                                  controller: needs,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "يرجى إدخال الاحتياجات".tr();
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    label: Align(alignment: Alignment.centerRight, child: Text("الاحتياجات".tr())),
                                    suffixIcon: Icon(Icons.list, color: Color(0xff53A7D8)),
                                  ),
                                ),
                                SizedBox(height: 30),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      cubit.support_request(
                                        health_status.text,
                                        health_status.text,
                                        double.tryParse(monthly_income.text) ?? 0,
                                        job_status.text,
                                        job_status.text,
                                        is_single.value ?? false,
                                        is_urgent.value ?? false,
                                        support_type.text,
                                        support_type.text,
                                        is_male.value ?? false,
                                        has_family.value ?? false,
                                        is_male_breadwinner_for_family.value ?? false,
                                        is_female_breadwinner_for_family.value ?? false,
                                        is_youth_without_family.value ?? false,
                                        is_girl_without_family.value ?? false,
                                        is_orphan.value ?? false,
                                        is_injured.value ?? false,
                                        is_disabled.value ?? false,
                                        int.tryParse(total_number_of_children.text) ?? 0,
                                        int.tryParse(number_of_disabled_children.text) ?? 0,
                                        needs.text,
                                        needs.text,

                                      );
                                     ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("تم تسجيل طلبك يرجى مراجعة الاشعارات لتفقده".tr()))) ;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()),
                                      );context.read<BottomNavigationCubit>().changeIndex(2);

                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("يرجى ملء جميع الحقول بشكل صحيح".tr())),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color(0xff53A7D8),
                                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  ),
                                  child: Text("تسجيل الطلب".tr()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
