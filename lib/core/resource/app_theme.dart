

// // lib/core/resources/app_theme.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_internet_application/core/resource/color.dart';


// class AppTheme {
//   // 🌞 Light Theme
//   static final ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: AppColors.background,
//     primaryColor: AppColors.primary,
//     appBarTheme: AppBarTheme(
//       backgroundColor: AppColors.primary,
//       foregroundColor: AppColors.white,
//       elevation: 2,
//       centerTitle: true,
//     ),
//     floatingActionButtonTheme: FloatingActionButtonThemeData(
//       backgroundColor: AppColors.primary,
//       foregroundColor: AppColors.white,
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.primary,
//         foregroundColor: AppColors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     ),
//     textTheme: TextTheme(
//       bodyLarge: TextStyle(color: AppColors.textPrimary, fontSize: 16),
//       bodyMedium: TextStyle(color: AppColors.textSecondary, fontSize: 14),
//       headlineLarge: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
//       headlineMedium: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
//       titleLarge: TextStyle(color: AppColors.textSecondary, fontSize: 16),
//       titleMedium: TextStyle(color: AppColors.textSecondary, fontSize: 14),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: AppColors.white,
//       labelStyle: TextStyle(color: AppColors.textPrimary),
//       hintStyle: TextStyle(color: AppColors.textSecondary),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: AppColors.primary, width: 1.5),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: AppColors.error, width: 1.2),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: AppColors.error, width: 1.2),
//       ),
//     ),
//   );

//   // 🌑 Dark Theme
//   static final ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     scaffoldBackgroundColor: AppColors.darkBackground,
//     primaryColor: AppColors.darkPrimary,
//     appBarTheme: AppBarTheme(
//       backgroundColor: AppColors.darkPrimary,
//       foregroundColor: AppColors.white,
//       elevation: 2,
//       centerTitle: true,
//     ),
//     floatingActionButtonTheme: FloatingActionButtonThemeData(
//       backgroundColor: AppColors.darkPrimary,
//       foregroundColor: AppColors.white,
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.darkPrimary,
//         foregroundColor: AppColors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     ),
//     textTheme: TextTheme(
//       bodyLarge: TextStyle(color: AppColors.darkTextPrimary, fontSize: 16),
//       bodyMedium: TextStyle(color: AppColors.darkTextSecondary, fontSize: 14),
//       headlineLarge: TextStyle(color: AppColors.darkTextPrimary, fontSize: 24, fontWeight: FontWeight.bold),
//       headlineMedium: TextStyle(color: AppColors.darkTextPrimary, fontSize: 20, fontWeight: FontWeight.bold),
//       titleLarge: TextStyle(color: AppColors.darkTextSecondary, fontSize: 16),
//       titleMedium: TextStyle(color: AppColors.darkTextSecondary, fontSize: 14),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: Color(0xFF1E1E1E),
//       labelStyle: TextStyle(color: AppColors.darkTextPrimary),
//       hintStyle: TextStyle(color: AppColors.darkTextSecondary),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: AppColors.darkPrimary.withOpacity(0.5)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: AppColors.darkPrimary, width: 1.5),
//       ),
//       errorBorder: OutlineInputBorder(

//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: AppColors.error, width: 1.2),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: AppColors.error, width: 1.2),
//       ),
//     ),
//   );
// }

// lib/core/resources/app_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter_internet_application/core/resource/color.dart';

class AppTheme {
  // 🌞 Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
      background: AppColors.background,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onBackground: AppColors.textPrimary,
      onError: AppColors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 2,
      centerTitle: true,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimary, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.textSecondary, fontSize: 14),
      bodySmall: TextStyle(color: AppColors.textSecondary, fontSize: 12),
      headlineLarge: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: AppColors.textSecondary, fontSize: 16),
      titleMedium: TextStyle(color: AppColors.textSecondary, fontSize: 14),
      labelSmall: TextStyle(color: AppColors.textSecondary, fontSize: 12),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      labelStyle: TextStyle(color: AppColors.textPrimary),
      hintStyle: TextStyle(color: AppColors.textSecondary),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.error, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.error, width: 1.2),
      ),
    ),
  );

  // 🌑 Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.darkPrimary,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondary,
      error: AppColors.error,
      background: AppColors.darkBackground,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onBackground: AppColors.darkTextPrimary,
      onError: AppColors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: AppColors.white,
      elevation: 2,
      centerTitle: true,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: AppColors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextPrimary, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.darkTextSecondary, fontSize: 14),
      bodySmall: TextStyle(color: AppColors.darkTextSecondary, fontSize: 12),
      headlineLarge: TextStyle(color: AppColors.darkTextPrimary, fontSize: 24, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: AppColors.darkTextPrimary, fontSize: 20, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: AppColors.darkTextSecondary, fontSize: 16),
      titleMedium: TextStyle(color: AppColors.darkTextSecondary, fontSize: 14),
      labelSmall: TextStyle(color: AppColors.darkTextSecondary, fontSize: 12),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkBackground.withOpacity(0.85),
      labelStyle: TextStyle(color: AppColors.darkTextPrimary),
      hintStyle: TextStyle(color: AppColors.darkTextSecondary),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.darkPrimary.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.darkPrimary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.error, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.error, width: 1.2),
      ),
    ),
  );
}
