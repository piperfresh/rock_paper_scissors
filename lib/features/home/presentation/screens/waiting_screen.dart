import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rock_paper_scissors/core/common/capitalize_first_letter.dart';
import 'package:rock_paper_scissors/core/extensions/asset.dart';
import 'package:rock_paper_scissors/core/extensions/build_context.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/core/utils/app_color.dart';
import 'package:rock_paper_scissors/features/home/data/storage/user_storage.dart';
import 'package:rock_paper_scissors/features/home/presentation/providers/score_notifier.dart';
import 'package:rock_paper_scissors/features/home/presentation/screens/fight_screen.dart';
import 'package:rock_paper_scissors/features/home/presentation/widgets/waiting_rich_text.dart';

class WaitingScreen extends ConsumerStatefulWidget {
  const WaitingScreen({super.key});

  @override
  ConsumerState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends ConsumerState<WaitingScreen> {
  String? username;

  void loadUsername() async {
    final savedUsername = await UserStorage.getUserString();
    setState(() {
      username = savedUsername;
    });
  }

  @override
  void initState() {
    loadUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scoreData = ref.watch(scoreNotifierProvider);
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
            WaitingRichText(
              leftText: scoreData.computerLosses.toString(),
              rightText: 'Lose',
              leftTextColor: AppColor.orange1,
            ),
            WaitingRichText(
              leftText: scoreData.computerWins.toString(),
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
              capitalizeFirstLetter(username ?? 'player'),
              style: context.textTheme.bodyMedium,
            ),
            WaitingRichText(
              leftText: scoreData.playerLosses.toString(),
              rightText: 'Lose',
              leftTextColor: AppColor.orange1,
            ),
            WaitingRichText(
              leftText: scoreData.playerWins.toString(),
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
            ),
            20.sbH,
            InkWell(
              onTap: () async {
                await ref.read(scoreNotifierProvider.notifier).resetScores();
                await ref.read(scoreNotifierProvider.notifier).loadScore();
              },
              child: Text(
                'Reset Score',
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColor.yellow2,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class WaitingScreen extends ConsumerWidget {
//   const WaitingScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final scoreData = ref.watch(scoreNotifierProvider);
//     return Scaffold(
//       backgroundColor: AppColor.primary,
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset('computer_head'.svg),
//             12.sbH,
//             Text(
//               'Computer',
//               style: context.textTheme.bodyMedium,
//             ),
//             WaitingRichText(
//               leftText: scoreData.computerLosses.toString(),
//               rightText: 'Lose',
//               leftTextColor: AppColor.orange1,
//             ),
//             WaitingRichText(
//               leftText: scoreData.computerWins.toString(),
//               rightText: 'Win',
//               leftTextColor: AppColor.lightGreen,
//             ),
//             84.95.sbH,
//             Text(
//               'VS',
//               style: context.textTheme.bodySmall?.copyWith(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 56.sp,
//                 color: AppColor.yellow2,
//               ),
//             ),
//             84.sbH,
//             SvgPicture.asset('player_head'.svg),
//             12.sbH,
//             Text(
//               'Player',
//               style: context.textTheme.bodyMedium,
//             ),
//             WaitingRichText(
//               leftText: scoreData.playerLosses.toString(),
//               rightText: 'Lose',
//               leftTextColor: AppColor.orange1,
//             ),
//             WaitingRichText(
//               leftText: scoreData.playerWins.toString(),
//               rightText: 'Win',
//               leftTextColor: AppColor.lightGreen,
//             ),
//             10.sbH,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'if you are ready!',
//                   style: context.textTheme.bodySmall?.copyWith(
//                     color: AppColor.white,
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 12.sbW,
//                 GestureDetector(
//                   onTap: () {
//                     context.push(MaterialPageRoute(builder: (context) {
//                       return const FightScreen();
//                     },));
//                   },
//                   child: Text(
//                     'Start',
//                     style: context.textTheme.bodySmall?.copyWith(
//                       color: AppColor.yellow2,
//                       fontSize: 25.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
