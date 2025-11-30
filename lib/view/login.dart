import 'package:flutter/material.dart';
import 'package:flutter_internet_application/service/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_internet_application/view/complain.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController identifierController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String errorMessage = "";
  String successMessage = "";

  final LoginService loginService = LoginService();

  Future<String> getDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("Obtained Device Token: $token"); // طباعة التوكن هنا أيضاً
    return token ?? "";
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
      successMessage = "";
    });

    final deviceToken = await getDeviceToken();

    final result = await loginService.login(
      identifier: identifierController.text.trim(),
      password: passwordController.text.trim(),
      deviceToken: deviceToken,
    );

    setState(() {
      isLoading = false;

      if (result["success"] == true) {
        successMessage = result["message"] ?? "تم تسجيل الدخول بنجاح 🎉";

        // الانتقال إلى صفحة ComplaintFormPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ComplaintFormPage()),
        );
      } else {
        errorMessage = result["message"] ?? "حدث خطأ غير متوقع";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: identifierController,
              decoration: const InputDecoration(
                labelText: "Mobile / Email",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 25),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: login,
                  child: const Text("Login"),
                ),
              ),
            const SizedBox(height: 15),
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
            if (successMessage.isNotEmpty)
              Text(successMessage, style: const TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
