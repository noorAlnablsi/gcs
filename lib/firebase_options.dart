import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // على Windows Desktop سنستخدم إعدادات Web
    return const FirebaseOptions(
      apiKey: "AIzaSyABKB29rZHm3D8h-hdooJEms_HS1JqQuS8",
      authDomain: "fir-notification-4d01f.firebaseapp.com",
      projectId: "fir-notification-4d01f",
      storageBucket: "fir-notification-4d01f.firebasestorage.app",
      messagingSenderId: "360993062424",
      appId: "1:360993062424:web:37810be081c92bdfd3cd6d",
      measurementId: "G-J16GG05KJ7",
    );
  }
}
