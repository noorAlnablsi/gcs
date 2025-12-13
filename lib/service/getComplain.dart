
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetComplaintService {
  final Dio dio;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  GetComplaintService({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: "http://192.168.1.7:8000/api",
              connectTimeout: Duration(seconds: 10),
              receiveTimeout: Duration(seconds: 10),
            ),
          );

  // جلب الشكاوى الخاصة بالمستخدم
  Future<List<Map<String, dynamic>>> getUserComplaints() async {
    try {
      // استرجاع التوكن المخزن
      String? userToken = await storage.read(key: 'userToken');

      if (userToken == null || userToken.isEmpty) {
        print("Error: User token is empty!");
        return [];
      }

      // إرسال الطلب مع التوكن في الهيدر
      final response = await dio.get(
        "/user/complaints",
        options: Options(
          headers: {
            'Authorization': 'Bearer $userToken',
            'accept': 'application/json',
          },
        ),
      );

      print("Status code: ${response.statusCode}");
      print("Response body: ${response.data}");

      if (response.statusCode == 200 && response.data["success"] == true) {
        List complaints = response.data["data"] ?? [];
        return complaints
            .map<Map<String, dynamic>>((c) => c as Map<String, dynamic>)
            .toList();
      }

      print("Error fetching complaints: ${response.data["message"]}");
      return [];
    } catch (e) {
      print("Exception while fetching complaints: $e");
      return [];
    }
  }
}
