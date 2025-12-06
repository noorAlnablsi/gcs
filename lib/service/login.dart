// import 'package:dio/dio.dart';
// import 'package:flutter_internet_application/service/tokenManage.dart';

// class LoginService {
//   final Dio dio;

//   LoginService({Dio? dio})
//     : dio =
//           dio ??
//           Dio(
//             BaseOptions(
//               baseUrl: "http://192.168.1.106:8000/api", // تأكد من الـ IP الصحيح
//               connectTimeout: Duration(seconds: 10),
//               receiveTimeout: Duration(seconds: 10),
//             ),
//           );

//   /// تسجيل الدخول
//   Future<Map<String, dynamic>> login({
//     required String identifier,
//     required String password,
//     required String deviceToken,
//   }) async {
//     // طباعة deviceToken هنا
//     print("Device Token: $deviceToken");

//     try {
//       final response = await dio.post(
//         "/auth/login",
//         data: {
//           "identifier": identifier,
//           "password": password,
//           "device_token": deviceToken,
//         },
//         options: Options(validateStatus: (status) => true),
//       );

//       final res = response.data ?? {};

//       if (response.statusCode == 200 && res["success"] == true) {
//         // حفظ التوكن في حال نجاح تسجيل الدخول
//         String token = res["data"]["token"] ?? "";
//         if (token.isNotEmpty) {
//           await TokenStorage.saveToken(token);
//         }

//         return {
//           "success": true,
//           "message": res["message"] ?? "Login successful",
//           "data": res["data"] ?? {},
//         };
//       } else {
//         // أخطاء من السيرفر
//         return {
//           "success": false,
//           "message": res["message"] ?? "Login failed",
//           "errors": res["errors"] ?? {},
//         };
//       }
//     } catch (e, s) {
//       print("LOGIN ERROR: $e");
//       print("STACK: $s");
//       return {"success": false, "message": "Unexpected error", "errors": {}};
//     }
//   }
// }

// loginService.dart
import 'package:dio/dio.dart';
import 'package:flutter_internet_application/service/tokenManage.dart';

class LoginService {
  final Dio dio;

  LoginService({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: "http://192.168.1.6:8000/api",
              connectTimeout: Duration(seconds: 10),
              receiveTimeout: Duration(seconds: 10),
            ),
          );

  Future<Map<String, dynamic>> login({
    required String identifier,
    required String password,
    required String deviceToken,
  }) async {
    try {
      final response = await dio.post(
        "/auth/login",
        data: {
          "identifier": identifier,
          "password": password,
          "device_token": deviceToken,
        },
        options: Options(validateStatus: (status) => true),
      );

      final res = response.data ?? {};

      if (response.statusCode == 200 && res["success"] == true) {
        String token = res["data"]["token"] ?? "";
        if (token.isNotEmpty) {
          await TokenStorage.saveToken(token); // حفظ التوكن
        } else {
          return {"success": false, "message": "Token not received"};
        }

        return {
          "success": true,
          "message": res["message"] ?? "Login successful",
          "data": res["data"] ?? {},
        };
      } else {
        return {
          "success": false,
          "message": res["message"] ?? "Login failed",
          "errors": res["errors"] ?? {},
        };
      }
    } catch (e, s) {
      print("LOGIN ERROR: $e");
      print("STACK: $s");
      return {"success": false, "message": "Unexpected error", "errors": {}};
    }
  }
}
