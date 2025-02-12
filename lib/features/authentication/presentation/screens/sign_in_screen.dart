import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rock_paper_scissors/core/common/app_button.dart';
import 'package:rock_paper_scissors/core/common/app_text_field.dart';
import 'package:rock_paper_scissors/core/extensions/asset.dart';
import 'package:rock_paper_scissors/core/extensions/build_context.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/core/utils/app_color.dart';
import 'package:rock_paper_scissors/features/home/data/storage/user_storage.dart';
import 'package:rock_paper_scissors/features/home/presentation/screens/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final usernameController = TextEditingController();

  @override
  void initState() {
    usernameController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  Color get buttonColor {
    return usernameController.text.trim().isEmpty
        ? Colors.orangeAccent
        : AppColor.orange;
  }

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
            TextFieldWithTitle(
              title: 'Username',
              controller: usernameController,
            ),
            60.sbH,
            AppButton(
              icon: 'google_logo',
              onPressed: usernameController.text.trim().isEmpty
                  ? () {}
                  : () {
                      UserStorage.saveUserString(
                          username: usernameController.text);
                      context.push(MaterialPageRoute(
                        builder: (context) {
                          return const HomeScreen();
                        },
                      ));
                    },
              shadowColor: usernameController.text.trim().isEmpty
                  ? Colors.orangeAccent
                  : AppColor.deepOrange,
              buttonColor: buttonColor,
              buttonTitle: 'Continue',
              height: 51.h,
            )
          ],
        ),
      ),
    );
  }
}

