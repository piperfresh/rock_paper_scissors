import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rock_paper_scissors/core/extensions/asset.dart';
import 'package:rock_paper_scissors/core/extensions/build_context.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/core/utils/app_color.dart';
import 'package:rock_paper_scissors/features/home/presentation/screens/home_screen.dart';

class GameOverOverlay extends StatelessWidget {
  final int playerScore;
  final int computerScore;
  final VoidCallback onRestart;

  const GameOverOverlay({
    super.key,
    required this.playerScore,
    required this.computerScore,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final bool playerWon = playerScore > computerScore;
    final bool isDraw = playerScore == computerScore;

    // return Builder(
    //   builder: (context) {
    //     WidgetsBinding.instance.addPostFrameCallback(
    //       (_) {
    //         _showGameBottomSheet(
    //           context: context,
    //           playerScore: playerScore,
    //           computerScore: computerScore,
    //           onRestart: onRestart,
    //         );
    //       },
    //     );
    //     return const SizedBox.shrink();
    //   },
    // );
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isDraw ? 'DRAW GAME!' : (playerWon ? 'YOU WIN!' : 'CPU WINS!'),
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 48.sp,
                color: isDraw
                    ? Colors.amber
                    : (playerWon ? Colors.green : Colors.red),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Final Score: $playerScore - $computerScore',
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 24.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    },));
                  },
                  icon: SvgPicture.asset('home'.svg),
                ),
                IconButton(
                  onPressed: () {
                    onRestart();
                    // context.pop();
                  },
                  icon: SvgPicture.asset('restart'.svg),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('forward'.svg),
                ),
                // SvgPicture.asset('home'.svg),
                // SvgPicture.asset('restart'.svg),
                // SvgPicture.asset('forward'.svg),
              ],
            ),
            // ElevatedButton(
            //   onPressed: onRestart,
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            //     child: Text(
            //       'Play Again',
            //       style: context.textTheme.bodyMedium?.copyWith(
            //         fontSize: 20.sp,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showGameBottomSheet({
  required BuildContext context,
  required int playerScore,
  required int computerScore,
  required VoidCallback onRestart,
}) async {
  final bool playerWon = playerScore > computerScore;
  final bool isDraw = playerScore == computerScore;
  return await showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 627.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.w),
                topRight: Radius.circular(12.w))),
        child: Column(
          children: [
            91.sbH,
            Container(
              height: 176.h,
              width: 176.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Text('AAA'),
            ),
            25.sbH,
            Text(
              isDraw ? 'DRAW GAME!' : (playerWon ? 'YOU WIN!' : 'CPU WINS!'),
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 48.sp,
                color: isDraw
                    ? AppColor.lightGold
                    : (playerWon ? Colors.green : Colors.red),
                fontWeight: FontWeight.bold,
              ),
            ),
            6.sbH,
            Text(
              'Final Score: $playerScore - $computerScore',
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 24.sp,
                color: Colors.white,
              ),
            ),
            34.sbH,
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('home'.svg),
                ),
                IconButton(
                  onPressed: () {
                    onRestart();
                    context.pop();
                  },
                  icon: SvgPicture.asset('restart'.svg),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('forward'.svg),
                ),
                // SvgPicture.asset('home'.svg),
                // SvgPicture.asset('restart'.svg),
                // SvgPicture.asset('forward'.svg),
              ],
            ),
          ],
        ),
      );
    },
  );
}
