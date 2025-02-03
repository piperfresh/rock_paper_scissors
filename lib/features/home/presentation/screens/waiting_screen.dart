import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rock_paper_scissors/core/extensions/asset.dart';
import 'package:rock_paper_scissors/core/extensions/build_context.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/core/utils/app_color.dart';
import 'package:rock_paper_scissors/features/home/presentation/screens/fight_screen.dart';
import 'package:rock_paper_scissors/features/home/presentation/widgets/waiting_rich_text.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('computer_head'.svg),
            12.sbH,
            Text(
              'Computer',
              style: context.textTheme.bodyMedium,
            ),
            const WaitingRichText(
              leftText: '1',
              rightText: 'Lose',
              leftTextColor: AppColor.orange1,
            ),
            const WaitingRichText(
              leftText: '20',
              rightText: 'Win',
              leftTextColor: AppColor.lightGreen,
            ),
            84.95.sbH,
            Text(
              'VS',
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 56.sp,
                color: AppColor.yellow2,
              ),
            ),
            84.sbH,
            SvgPicture.asset('player_head'.svg),
            12.sbH,
            Text(
              'Player',
              style: context.textTheme.bodyMedium,
            ),
            const WaitingRichText(
              leftText: '1',
              rightText: 'Lose',
              leftTextColor: AppColor.orange1,
            ),
            const WaitingRichText(
              leftText: '20',
              rightText: 'Win',
              leftTextColor: AppColor.lightGreen,
            ),
            10.sbH,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'if you are ready!',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColor.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                12.sbW,
                GestureDetector(
                  onTap: () {
                    context.push(MaterialPageRoute(builder: (context) {
                      return const FightScreen();
                    },));
                  },
                  child: Text(
                    'Start',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColor.yellow2,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
