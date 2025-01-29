import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rock_paper_scissors/core/extensions/asset.dart';
import 'package:rock_paper_scissors/core/extensions/build_context.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/features/onboarding/screens/onboarding_screen.dart';

class RpsSplashScreen extends StatefulWidget {
  const RpsSplashScreen({super.key});

  @override
  State<RpsSplashScreen> createState() => _RpsSplashScreenState();
}

class _RpsSplashScreenState extends State<RpsSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _bottomController;
  late Animation<Offset> _leftIconAnimation;
  late Animation<Offset> _rightIconAnimation;
  late Animation<Offset> _centerIconAnimation;
  late Animation<Offset> _bottomIconAnimation;
  late Animation<double> _bottomIconFade;
  bool _showBottomIcon = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _bottomController = AnimationController(
      // duration: const Duration(seconds: 5),
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _leftIconAnimation = Tween(
      begin: Offset(-1.5.w, 0.0.h),
      end: Offset(0.0.w, 0.0.h),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rightIconAnimation = Tween(
      begin: Offset(1.5.w, 0.0.h),
      end: Offset(0.0.w, 0.0.h),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _centerIconAnimation = Tween(
      begin: Offset(0.0.w, -1.5.h),
      end: Offset(0.0.w, 0.0.h),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _bottomIconAnimation = Tween(
      // begin: const Offset(1.5, 0.0),
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _bottomController, curve: Curves.easeIn),
    );

    _bottomIconFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _bottomController,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward().then((value) {
      setState(() {
        _showBottomIcon = true;
      });
      _bottomController.forward().then(
            (value) {
          context.push(MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          ));
        },
          );
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          double sideSpacing = screenWidth < 400 ? 110.w : 90.w;
          // double sideSpacing =  90.w;

          double iconSpacing = screenWidth * 0.1; // 10% of screen width
          double centerIconSize = screenWidth * 0.25; // 25% of screen width
          double sideIconSize = screenWidth * 0.2; // 20% of screen width
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 90.w,

                // left: screenWidth * 0.25,
                // left: sideSpacing,
                child: SlideTransition(
                  position: _leftIconAnimation,
                  child: SvgPicture.asset(
                    'paper_splash'.svg,
                    height: 208.h,
                    width: 137.w,
                  ),
                ),
              ),
              Positioned(
                right: 88.w,
                bottom: 380.h,
                // right: screenWidth * 0.25,
                // right: sideSpacing,
                child: SlideTransition(
                  position: _rightIconAnimation,
                  child: SvgPicture.asset(
                    'scissors_splash'.svg,
                    height: 195.h,
                    width: 126.w,
                  ),
                ),
              ),
              Positioned(
                bottom: 350.h,
                // left: 90.w,
                // right: 90.w,
                // bottom:screenHeight * 0.35,
                // left: sideSpacing,
                // right: sideSpacing,
                left: screenWidth * 0.3,
                right: screenWidth * 0.3,
                child: SlideTransition(
                  position: _centerIconAnimation,
                  child: SvgPicture.asset(
                    'rock_splash'.svg,
                    height: 156.h,
                    width: 176.w,
                  ),
                ),
              ),
              if(_showBottomIcon)
              Positioned(
                bottom: 270.h,
                child: FadeTransition(
                  opacity: _bottomIconFade,
                  child: SlideTransition(
                    position: _bottomIconAnimation,
                    child: SvgPicture.asset(
                      'rps_splash'.svg,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
