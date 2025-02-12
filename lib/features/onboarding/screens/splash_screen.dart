import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rock_paper_scissors/core/extensions/asset.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/features/home/data/storage/user_storage.dart';
import 'package:rock_paper_scissors/features/home/presentation/screens/waiting_screen.dart';
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

  String? username;

  void loadUsername() async {
    final savedUsername = await UserStorage.getUserString();
    print('This is the saved username $savedUsername');
    setState(() {
      username = savedUsername;
    });
  }

  @override
  void initState() {
    loadUsername();
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
          if (username == '') {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const OnboardingScreen(),
                ));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const WaitingScreen(),
                ));
          }
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
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 90.w,
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
