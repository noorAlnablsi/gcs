import 'package:flutter/material.dart';

class Registerform extends StatelessWidget {
  const Registerform({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final nameController = TextEditingController();
    final nationalIdController = TextEditingController();
    final contactController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("إنشاء حساب"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "الاسم الكامل",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "الرجاء إدخال الاسم";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: nationalIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "الرقم الوطني",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length != 10) {
                    return "الرقم الوطني يجب أن يكون 10 خانات";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: contactController,
                decoration: const InputDecoration(
                  labelText: "الإيميل أو رقم الموبايل",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "الرجاء إدخال الإيميل أو رقم الموبايل";
                  }

                  final input = value.trim();

                  final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
                  final phoneRegex = RegExp(r'^(095|098)[0-9]{7}$');

                  if (emailRegex.hasMatch(input)) {
                    return null;
                  }

                  if (phoneRegex.hasMatch(input)) {
                    return null;
                  }

                  return "الرجاء إدخال إيميل صحيح أو رقم موبايل يبدأ بـ 095 أو 098";
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "كلمة السر",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "كلمة السر يجب أن تكون 6 محارف على الأقل";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Registerform(),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "إنشاء الحساب",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
