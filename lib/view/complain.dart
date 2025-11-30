import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internet_application/model/complain.dart';
import 'package:geolocator/geolocator.dart';

class ComplaintFormPage extends StatefulWidget {
  const ComplaintFormPage({super.key});

  @override
  State<ComplaintFormPage> createState() => _ComplaintFormPageState();
}

class _ComplaintFormPageState extends State<ComplaintFormPage> {
  final PageController _pageController = PageController();

  // متغيرات لربط الحقول بالموديل
  String? complaintTypeId;
  String destinationId = "";
  String description = "";

  String lat = "";
  String lng = "";
  String address = "";

  File? document;
  List<File> documents = [];

  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    // 🔥 طلب الإذن بعد 800ms
    Future.delayed(const Duration(milliseconds: 800), () {
      requestLocationPermission();
    });
  }

  // ============================================================
  //      🔥 طلب إذن الموقع + تعبئة حقول الإحداثيات تلقائياً
  // ============================================================
  Future<void> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // التحقق من تفعيل GPS
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("يرجى تفعيل GPS")));
      return;
    }

    // التحقق من الإذن
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("تم رفض إذن الوصول للموقع نهائيًا. افتح الإعدادات."),
        ),
      );
      return;
    }

    // الحصول على الموقع بعد السماح
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      lat = pos.latitude.toString();
      lng = pos.longitude.toString();
    });

    print("Lat: $lat");
    print("Lng: $lng");
  }

  // ============================================================
  //              اختيار ملف واحد
  // ============================================================
  Future<void> pickSingleFile() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (res != null) {
      setState(() {
        document = File(res.files.single.path!);
      });
    }
  }

  // ============================================================
  //              اختيار ملفات متعددة
  // ============================================================
  Future<void> pickMultipleFiles() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (res != null) {
      setState(() {
        documents = res.paths.map((p) => File(p!)).toList();
      });
    }
  }

  // ============================================================
  //                       إرسال البيانات
  // ============================================================
  void submit() {
    Complain c = Complain(
      complaintTypeId: complaintTypeId,
      destinationId: destinationId,
      lat: lat,
      lng: lng,
      address: address,
      description: description,
      document: document,
      documents: documents,
    );

    print("===== FINAL RESULT =====");
    print(c.toMap());

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("تم إرسال الشكوى بنجاح")));
  }

  // ============================================================
  //                       واجهة التطبيق
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تقديم شكوى"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // -------- PAGE 1 --------
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      const Text("نوع الشكوى", style: TextStyle(fontSize: 16)),
                      TextField(
                        onChanged: (v) => complaintTypeId = v,
                        decoration: const InputDecoration(
                          hintText: "مثال: انقطاع خدمة",
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        "الجهة المعنية",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextField(
                        onChanged: (v) => destinationId = v,
                        decoration: const InputDecoration(
                          hintText: "مثال: البلدية",
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text("وصف المشكلة", style: TextStyle(fontSize: 16)),
                      TextField(maxLines: 3, onChanged: (v) => description = v),
                    ],
                  ),
                ),

                // -------- PAGE 2 --------
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      const Text("العنوان", style: TextStyle(fontSize: 16)),
                      TextField(onChanged: (v) => address = v),
                      const SizedBox(height: 16),

                      const Text(
                        "خط العرض (Lat)",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextField(
                        controller: TextEditingController(text: lat),
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: "يتم تعبئته تلقائيًا",
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        "خط الطول (Lng)",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextField(
                        controller: TextEditingController(text: lng),
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: "يتم تعبئته تلقائيًا",
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        "إرفاق وثيقة واحدة",
                        style: TextStyle(fontSize: 16),
                      ),
                      ElevatedButton(
                        onPressed: pickSingleFile,
                        child: const Text("اختر ملف"),
                      ),
                      if (document != null)
                        Text("تم اختيار: ${document!.path.split('/').last}"),

                      const SizedBox(height: 20),

                      const Text(
                        "إرفاق عدة وثائق",
                        style: TextStyle(fontSize: 16),
                      ),
                      ElevatedButton(
                        onPressed: pickMultipleFiles,
                        child: const Text("اختر عدة ملفات"),
                      ),

                      if (documents.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: documents
                              .map((f) => Text("• ${f.path.split('/').last}"))
                              .toList(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // -------- Navigation Buttons --------
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                if (currentPage == 1)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        setState(() => currentPage = 0);
                      },
                      child: const Text("السابق"),
                    ),
                  ),
                if (currentPage == 1) const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentPage == 0) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        setState(() => currentPage = 1);
                      } else {
                        submit();
                      }
                    },
                    child: Text(currentPage == 0 ? "التالي" : "إرسال"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
