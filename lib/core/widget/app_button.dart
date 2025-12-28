// // lib/core/widgets/app_button.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_internet_application/core/resource/color.dart';


// class AppButton extends StatelessWidget {
//   const AppButton({
//     Key? key,
//     required this.text,
//     required this.onTap,
//     this.width = 350,
//     this.height = 50,
//   }) : super(key: key);

//   final String text;
//   final VoidCallback onTap;
//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: FilledButton(
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(AppColors.primary),
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),
//         onPressed: onTap,
//         child: Text(
//           text,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.width = 350,
    this.height = 50,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    // 🌟 استخدم لون الثيم الحالي للزر
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      height: height,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(theme.primaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
