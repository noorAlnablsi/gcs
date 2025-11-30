import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_internet_application/view/signUP.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase مرة واحدة فقط
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // الحصول على Device Token وطباعته
  String? token = await FirebaseMessaging.instance.getToken();
  debugPrint("Device Token: $token");

  // تشغيل التطبيق مرة واحدة
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpOrEnterAsGuest(),
    );
  }
}
