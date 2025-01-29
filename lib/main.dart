import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/core/utils/themes.dart';

import 'core/configs/size_configs.dart';
import 'features/onboarding/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context, 430, 932);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const RpsSplashScreen(),
    );
  }
}
