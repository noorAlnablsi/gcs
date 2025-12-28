// import 'package:flutter/material.dart';
// import 'package:flutter_internet_application/view/login.dart';
// import 'package:flutter_internet_application/view/registerForm.dart';

// class SignUpOrEnterAsGuest extends StatelessWidget {
//   SignUpOrEnterAsGuest({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Column(
//               children: [
//                 SizedBox(
//                   height: 128,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: Image.asset(
//                       'assets/Isolation_Mode.png',
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 10),

//                 Text(
//                   "خدمة المواطن",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: 60),

//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 40),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => RegisterPage()),
//                     );
//                   },

//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     "إنشاء حساب",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             SizedBox(height: 15),

//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 40),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: OutlinedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginPage()),
//                     );
//                   },

//                   style: OutlinedButton.styleFrom(
//                     side: BorderSide(color: Colors.blue, width: 1.6),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     "الدخول كزائر",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.blue,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_internet_application/core/resource/color.dart';

import 'package:flutter_internet_application/core/widget/app_button.dart';

import 'package:flutter_internet_application/view/login.dart';
import 'package:flutter_internet_application/view/Auth/registerForm.dart';

class SignUpOrEnterAsGuest extends StatelessWidget {
  const SignUpOrEnterAsGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // الصورة
                Image.asset(
                  'assets/Isolation_Mode.png',
                  width: 180,
                  height: 200,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 20),

                // النص الرئيسي
                Text(
                  "خدمة المواطن",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 50),

                // زر إنشاء حساب
                AppButton(
                  text: "إنشاء حساب",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  width: double.infinity,
                  height: 50,
                ),

                const SizedBox(height: 16),

                // زر الدخول كزائر
                AppButton(
                  text: "تسجيل الدخول",
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                  },
                  width: double.infinity,
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
