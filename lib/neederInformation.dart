import 'package:flutter/material.dart';


class Neederinformation extends StatelessWidget {
  const Neederinformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // الخلفية العلوية
          Container(
            height: 460,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/img_33.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // محتوى التسجيل
          Padding(
            padding: const EdgeInsets.only(
              top: 160,
              bottom: 10,
              left: 30,
              right: 30,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  color: Colors.white,
                  elevation: 35,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black.withOpacity(0.8),

                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        Text(
                          "طلب المساعدة",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),

                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Align(
                              alignment: Alignment.centerRight,
                              child: Text("الجنس"),
                            ),
                            suffixIcon: Icon(
                              Icons.wc,
                              color: Color(0xff53A7D8),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),

                        // اسم الأب
                        TextFormField(
                          decoration: InputDecoration(
                            label: Align(
                              alignment: Alignment.centerRight,
                              child: Text("الدخل المادي"),
                            ),
                            suffixIcon: Icon(
                              Icons.attach_money_sharp,
                              color: Color(0xff53A7D8),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Align(
                              alignment: Alignment.centerRight,
                              child: Text("العمل"),
                            ),
                            suffixIcon: Icon(
                              Icons.work,
                              color: Color(0xff53A7D8),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),

                        // اسم الأم
                        TextFormField(
                          decoration: InputDecoration(
                            label: Align(
                              alignment: Alignment.centerRight,
                              child: Text("الحالة الاجتماعية"),
                            ),
                            suffixIcon: Icon(
                              Icons.person,
                              color: Color(0xff53A7D8),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),

                        // العنوان
                        TextFormField(
                          decoration: InputDecoration(
                            label: Align(
                              alignment: Alignment.centerRight,
                              child: Text("الحالة الصحية"),
                            ),
                            suffixIcon: Icon(
                              Icons.monitor_heart,
                              color: Color(0xff53A7D8),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),

                        // رقم الهاتف
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            label: Align(
                              alignment: Alignment.centerRight,
                              child: Text("عدد أفراد العائلة"),
                            ),
                            suffixIcon: Icon(
                              Icons.supervisor_account,
                              color: Color(0xff53A7D8),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),

                        // كلمة المرور
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            label: Align(
                              alignment: Alignment.centerRight,
                              child: Text("الاحتياجات"),
                            ),
                            suffixIcon: Icon(
                              Icons.volunteer_activism_outlined,
                              color: Color(0xff53A7D8),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),

                        Container(
                          padding: EdgeInsets.only(bottom: 20),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xff53A7D8),
                              padding: EdgeInsets.symmetric(
                                horizontal: 80,
                                vertical: 12,
                              ),
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text('تسجيل الطلب'),
                          ),
                        ),
                        SizedBox(height: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
