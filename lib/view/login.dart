import 'package:flutter/material.dart';
import 'package:flutter_internet_application/service/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_internet_application/view/complain.dart';
import 'package:flutter_internet_application/core/widget/app_textfield.dart';
import 'package:flutter_internet_application/core/widget/app_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController identifierController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;

  String errorMessage = "";
  String successMessage = "";

  final storage = const FlutterSecureStorage();
  final LoginService loginService = LoginService();

  // الحصول على Device Token من Firebase
  Future<String> getDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("Obtained Device Token: $token");
    return token ?? "";
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
      successMessage = "";
    });

    try {
      final deviceToken = await getDeviceToken();

      final result = await loginService.login(
        identifier: identifierController.text.trim(),
        password: passwordController.text.trim(),
        deviceToken: deviceToken,
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
        if (result["success"] == true) {
          successMessage = result["message"] ?? "تم تسجيل الدخول بنجاح 🎉";

          // حفظ التوكن في التخزين الآمن
          String userToken = result["data"]["token"] ?? "";
          storage.write(key: "userToken", value: userToken);

          // الانتقال مباشرة لواجهة تقديم الشكوى
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) {
                var complaintStepOne = ComplaintStepOne(
                  data: {},
                  userToken: '', // لا حاجة لتمرير التوكن بعد هذا التعديل
                );
                return complaintStepOne;
              },
            ),
          );
        } else {
          errorMessage = result["message"] ?? "حدث خطأ غير متوقع";
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "حدث خطأ أثناء تسجيل الدخول";
      });
      print("Login error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تسجيل الدخول")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: AppTextField(
                  labelText: "رقم الهاتف أو الإيميل",
                  hintText: "أدخل رقم الهاتف أو البريد",
                  controller: identifierController,
                  myIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AppTextField(
                  labelText: "كلمة المرور",
                  hintText: "أدخل كلمة المرور",
                  controller: passwordController,
                  obscureText: obscurePassword,
                  myIcon: const Icon(Icons.lock),
                  traillingIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => obscurePassword = !obscurePassword),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(text: "تسجيل الدخول", onTap: login),
              const SizedBox(height: 15),
              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: const TextStyle(color: Colors.red)),
              if (successMessage.isNotEmpty)
                Text(
                  successMessage,
                  style: const TextStyle(color: Colors.green),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
