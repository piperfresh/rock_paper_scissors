import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/core/utils/themes.dart';
import 'package:rock_paper_scissors/features/onboarding/splash_screen.dart';

import 'core/configs/size_configs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
    // return LayoutBuilder(builder: (context, constraints) {
    //   return OrientationBuilder(
    //     builder: (context, orientation) {
    //       return ScreenUtilInit(
    //         designSize: DesignSizeConfig()
    //             .designSize(orientation: orientation, constraints: constraints),
    //         minTextAdapt: true,
    //         useInheritedMediaQuery: true,
    //         ensureScreenSize: true,
    //         rebuildFactor: (old, data) => true,
    //         child: MaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           title: 'Flutter Demo',
    //           theme: AppTheme.lightTheme,
    //           darkTheme: AppTheme.darkTheme,
    //           home: const RpsSplashScreen(),
    //         ),
    //       );
    //     },
    //   );
    // });
  }
}
