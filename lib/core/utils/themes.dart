import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/core/utils/app_color.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        color: Color(0XFF04247C),
      ),
      // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      //     .copyWith(surface: AppColor.scaffoldBackgroundColor),
      textTheme: textTheme(AppColor.black),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color(0XFF04247C),
      ),
      textTheme: textTheme(AppColor.white),
      // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: AppColor.scaffoldBackgroundColor),
    );
  }

  static TextTheme textTheme(Color color) {
    return TextTheme(
      bodyLarge: TextStyle(
        color: AppColor.white,
        fontSize: 64.sp,
        fontWeight: FontWeight.w700,
      )
    );
  }
}
