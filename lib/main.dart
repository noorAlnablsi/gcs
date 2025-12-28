// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/material.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter_internet_application/view/Auth/signUP.dart';
// // import 'firebase_options.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();

// //   // تهيئة Firebase مرة واحدة فقط
// //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// //   // الحصول على Device Token وطباعته
// //   String? token = await FirebaseMessaging.instance.getToken();
// //   debugPrint("Device Token: $token");

// //   // تشغيل التطبيق مرة واحدة
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: SignUpOrEnterAsGuest(),
// //     );
// //   }

// // }
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_internet_application/view/Auth/signUP.dart';
// import 'firebase_options.dart';

// // 🔵 Handler للإشعارات في الخلفية
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   debugPrint("🔔 إشعار من الخلفية: ${message.notification?.title}");
// }

// // نحتاج navigatorKey لعرض الـ pop-up من خارج سياق الواجهة
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // 🟦 تهيئة Firebase
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   // 🟦 تسجيل الـ background handler
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   // 🟦 جلب التوكن وطباعة
//   String? token = await FirebaseMessaging.instance.getToken();
//   debugPrint("📱 Device Token: $token");

//   // 🟦 تشغيل التطبيق
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: navigatorKey, // ← مهم لإظهار الـ popup
//       debugShowCheckedModeBanner: false,
//       home: NotificationHandler(child: SignUpOrEnterAsGuest()),
//     );
//   }
// }

// // ---------------------------------------------------------------
// //               🔥 Widget übernimmt إدارة الإشعارات
// // ---------------------------------------------------------------
// class NotificationHandler extends StatefulWidget {
//   final Widget child;

//   const NotificationHandler({required this.child, super.key});

//   @override
//   State<NotificationHandler> createState() => _NotificationHandlerState();
// }

// class _NotificationHandlerState extends State<NotificationHandler> {
//   @override
//   void initState() {
//     super.initState();
//     _setupNotifications();
//   }

//   Future<void> _setupNotifications() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;

//     // ⚠️ لطلب إذن iOS (لا يضر أندرويد)
//     await messaging.requestPermission(alert: true, badge: true, sound: true);

//     // ---------------------------------------------------
//     // 🟩 إشعار يصل والتطبيق مفتوح (Foreground)
//     // ---------------------------------------------------
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       debugPrint("📩 إشعار Foreground: ${message.notification?.title}");

//       if (message.notification != null) {
//         _showPopup(
//           message.notification!.title ?? "إشعار جديد",
//           message.notification!.body ?? "",
//         );
//       }
//     });

//     // ---------------------------------------------------
//     // 🟨 المستخدم يفتح التطبيق من الخلفية عبر الإشعار
//     // ---------------------------------------------------
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       debugPrint("📨 فتح التطبيق من Background عبر الإشعار");

//       if (message.data.containsKey("complaint_id")) {
//         String id = message.data["complaint_id"];
//         // يمكنك إضافة تنقل لصفحة الشكوى
//       }
//     });

//     // ---------------------------------------------------
//     // 🟥 التطبيق كان مغلق تماماً (Terminated)
//     // ---------------------------------------------------
//     RemoteMessage? initialMsg = await FirebaseMessaging.instance
//         .getInitialMessage();
//     if (initialMsg != null) {
//       debugPrint("🚀 التطبيق فتح من إشعار (Terminated)");

//       if (initialMsg.data.containsKey("complaint_id")) {
//         String id = initialMsg.data["complaint_id"];
//         // التنقل لصفحة الشكوى لو أردت
//       }
//     }
//   }

//   // 🔔 صندوق Pop-up بسيط
//   void _showPopup(String title, String body) {
//     showDialog(
//       context: navigatorKey.currentContext!,
//       builder: (_) => AlertDialog(
//         title: Text(title),
//         content: Text(body),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(navigatorKey.currentContext!),
//             child: const Text("إغلاق"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_internet_application/core/resource/app_theme.dart';
import 'package:flutter_internet_application/view/Auth/signUP.dart';

import 'firebase_options.dart';


// 🔵 Handler للإشعارات في الخلفية
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("🔔 إشعار من الخلفية: ${message.notification?.title}");
}

// نحتاج navigatorKey لعرض الـ pop-up من خارج سياق الواجهة
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🟦 تهيئة Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 🟦 تسجيل الـ background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 🟦 جلب التوكن وطباعة
  String? token = await FirebaseMessaging.instance.getToken();
  debugPrint("📱 Device Token: $token");

  // 🟦 تشغيل التطبيق
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false; // false → Light, true → Dark

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: NotificationHandler(
        child: SignUpOrEnterAsGuest(), // هنا ممكن بعد التسجيل تنتقلي للصفحة ComplaintStepOne مع toggleTheme
      ),
    );
  }
}

// ---------------------------------------------------------------
//               🔥 Widget لإدارة الإشعارات
// ---------------------------------------------------------------
class NotificationHandler extends StatefulWidget {
  final Widget child;

  const NotificationHandler({required this.child, super.key});

  @override
  State<NotificationHandler> createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler> {
  @override
  void initState() {
    super.initState();
    _setupNotifications();
  }

  Future<void> _setupNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("📩 إشعار Foreground: ${message.notification?.title}");
      if (message.notification != null) {
        _showPopup(
          message.notification!.title ?? "إشعار جديد",
          message.notification!.body ?? "",
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint("📨 فتح التطبيق من Background عبر الإشعار");
      if (message.data.containsKey("complaint_id")) {
        String id = message.data["complaint_id"];
        // يمكنك إضافة تنقل لصفحة الشكوى
      }
    });

    RemoteMessage? initialMsg = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMsg != null) {
      debugPrint("🚀 التطبيق فتح من إشعار (Terminated)");
      if (initialMsg.data.containsKey("complaint_id")) {
        String id = initialMsg.data["complaint_id"];
        // التنقل لصفحة الشكوى لو أردت
      }
    }
  }

  void _showPopup(String title, String body) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(navigatorKey.currentContext!),
            child: const Text("إغلاق"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
