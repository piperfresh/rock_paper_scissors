import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rock_paper_scissors/core/extensions/asset.dart';
import 'package:rock_paper_scissors/core/extensions/build_context.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/core/utils/app_color.dart';
import 'package:rock_paper_scissors/features/home/presentation/screens/home_screen.dart';

import '../../../../core/widgets/app_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 52.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'logo_2'.svg,
              height: 200.h,
            ),
            15.sbH,
            SvgPicture.asset(
              'rps_splash'.svg,
              height: 30.h,
            ),
            30.sbH,
            AppButton(
              icon: 'google_logo',
              onPressed: () {
                context.push(MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                },));
              },
              shadowColor: AppColor.deepOrange,
              buttonColor: AppColor.orange,
              buttonTitle: 'Continue with Google',
              height: 51.h,
            )
          ],
        ),
      ),
    );
  }
}

