// import 'package:flutter/material.dart';

// class allMyComplaints extends StatelessWidget {
//   allMyComplaints({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [FloatingActionButton(onPressed: () => allMyComplaints())],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_internet_application/model/ComplaintResponse.dart';
import 'package:flutter_internet_application/service/getComplain.dart';

class ComplaintsPage extends StatefulWidget {
  final String userToken;

  const ComplaintsPage({super.key, required this.userToken});

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  late Future<List<Complaint>> _complaintsFuture;
  final getComplaintService _service = getComplaintService();

  @override
  void initState() {
    super.initState();
    _complaintsFuture = _service.getUserComplaints(token: widget.userToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('شكاوي المستخدم')),
      body: FutureBuilder<List<Complaint>>(
        future: _complaintsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // أثناء التحميل
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // في حال وجود خطأ
            return Center(
              child: Text(
                'حدث خطأ: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // في حال عدم وجود بيانات
            return const Center(child: Text('لا توجد شكاوى حالياً'));
          }

          // عرض الشكاوى
          final complaints = snapshot.data!;

          return ListView.builder(
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final complaint = complaints[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(
                    complaint.identifier,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('الوصف: ${complaint.description}'),
                      Text('الحالة: ${complaint.status}'),
                      Text('الوجهة: ${complaint.destinationName}'),
                      Text('نوع الشكوى: ${complaint.complaintTypeName}'),
                      Text('العنوان: ${complaint.address}'),
                      Text('تاريخ الإنشاء: ${complaint.createdAt}'),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
