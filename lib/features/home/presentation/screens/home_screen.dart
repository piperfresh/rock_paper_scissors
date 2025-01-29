import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rock_paper_scissors/core/extensions/asset.dart';
import 'package:rock_paper_scissors/core/extensions/build_context.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/core/utils/app_color.dart';
import 'package:rock_paper_scissors/core/widgets/app_button.dart';
import 'package:rock_paper_scissors/features/home/presentation/screens/waiting_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'logo'.svg,
            height: 157.h,
            width: 180.w,
          ),
          73.sbH,
          SvgPicture.asset(
            'hand_crush'.svg,
          ),
          42.sbH,
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 52.w),
            child: AppButton(
                onPressed: () {
                  context.push(MaterialPageRoute(
                    builder: (context) {
                      return const WaitingScreen();
                    },
                  ));
                },
                icon: '',
                buttonTitle: 'Find your opponent',
                buttonColor: AppColor.light,
                shadowColor: AppColor.deepLight,
                height: 51.h),
          ),
        ],
      ),
    );
  }
}
