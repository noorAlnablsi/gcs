import 'package:flutter/material.dart';
import 'package:flutter_internet_application/model/userModel.dart';
import 'package:flutter_internet_application/service/register.dart';
import 'package:flutter_internet_application/view/otp.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController identifierController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String errorMessage = "";
  String successMessage = "";

  AuthServiceImpl auth = AuthServiceImpl();

  Future<void> register() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
      successMessage = "";
    });

    User user = User(
      name: nameController.text.trim(),
      identifier: identifierController.text.trim(),
      national_id: nationalIdController.text.trim(),
      password: passwordController.text.trim(),
      role_id: 3,
    );

    final result = await auth.register(user);

    setState(() {
      isLoading = false;

      if (result["success"] == true) {
        successMessage = "تم إنشاء الحساب بنجاح 🎉";

        // 🔥 الانتقال إلى صفحة OTP مباشرة
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpVerify(
              identifier: user.identifier, // ← تمرير الإيميل أو الرقم
            ),
          ),
        );
      } else {
        if (result["errors"] != null && result["errors"].isNotEmpty) {
          errorMessage = result["errors"].values.first[0].toString();
        } else {
          errorMessage = result["message"] ?? "حدث خطأ غير متوقع";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: identifierController,
              decoration: const InputDecoration(labelText: "Email / Phone"),
            ),
            TextField(
              controller: nationalIdController,
              decoration: const InputDecoration(labelText: "National ID"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),

            const SizedBox(height: 20),

            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                onPressed: register,
                child: const Text("Create Account"),
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
