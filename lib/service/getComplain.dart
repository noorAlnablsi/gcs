import 'package:dio/dio.dart';
import 'package:flutter_internet_application/model/ComplaintResponse.dart';

// class getComplaintService {
//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: 'http://192.168.1.6:8000/api', // ضع رابط الـ API الأساسي

//       headers: {'Content-Type': 'application/json'},
//     ),
//   );

/// جلب جميع شكاوى المستخدم
// Future<List<Complaint>> getUserComplaints({required String token}) async {
//   try {
//     final response = await _dio.get(
//       '/user/complaints', // endpoint الخاص بالشكاوى
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token', // إضافة التوكن
//         },
//       ),
//     );

//     if (response.statusCode == 200 && response.data['success'] == true) {
//       final List complaintsJson = response.data['data'];
//       return complaintsJson.map((json) => Complaint.fromJson(json)).toList();
//     } else {
//       throw Exception(
//         'Failed to fetch complaints: ${response.data['message']}',
//       );
//     }
//   } on DioError catch (e) {
//     // معالجة الأخطاء الخاصة بالـ Dio
//     if (e.response != null) {
//       throw Exception(
//         'Dio error: ${e.response?.statusCode} ${e.response?.statusMessage}',
//       );
//     } else {
//       throw Exception('Dio error: ${e.message}');
//     }
//   } catch (e) {
//     throw Exception('Unexpected error: $e');
//   }
// }
//   Future<List<Complaint>> getUserComplaints({required String token}) async {
//     try {
//       final response = await _dio.get(
//         '/user/complaints',
//         options: Options(headers: {'Authorization': 'Bearer $token'}),
//       );

//       // ✅ اطبع الرد هنا مباشرة
//       print('Full response: ${response.data}');

//       // الآن قم بتحويل البيانات كما كان
//       final List complaintsJson = response.data['data'];
//       return complaintsJson.map((json) => Complaint.fromJson(json)).toList();
//     } on DioError catch (e) {
//       if (e.response != null) {
//         print('Dio error response: ${e.response?.data}');
//         throw Exception(
//           'Dio error: ${e.response?.statusCode} ${e.response?.statusMessage}',
//         );
//       } else {
//         print('Dio error message: ${e.message}');
//         throw Exception('Dio error: ${e.message}');
//       }
//     } catch (e) {
//       print('Unexpected error: $e');
//       throw Exception('Unexpected error: $e');
//     }
//   }
// }

class getComplaintService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.6:8000/api',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  /// جلب جميع شكاوى المستخدم مع طباعة الأخطاء
  Future<List<Complaint>> getUserComplaints({required String token}) async {
    try {
      final response = await _dio.get(
        '/user/complaints',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // 🔹 هنا: اطبع كامل الـ response قبل التحويل
      print('--- Full Response ---');
      print(response.data);
      print('---------------------');

      // 🔹 هنا: تحقق أن كل عنصر يتحول إلى Complaint بدون مشاكل
      final List complaintsJson = response.data['data'];
      final complaints = complaintsJson.map((json) {
        try {
          return Complaint.fromJson(json);
        } catch (e) {
          print('Error converting JSON to Complaint: $e');
          print('JSON that caused error: $json');
          throw e; // يمكن الاستمرار أو إلقاء الاستثناء
        }
      }).toList();

      return complaints;
    } on DioError catch (e) {
      print('DioError: ${e.response?.statusCode} ${e.response?.data}');
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }
}
