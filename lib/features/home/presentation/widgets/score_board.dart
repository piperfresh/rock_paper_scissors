import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/core/extensions/build_context.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';

class ScoreBoard extends StatelessWidget {
  final int playerScore;
  final int computerScore;
  final int currentRound;

  const ScoreBoard({
    super.key,
    required this.playerScore,
    required this.computerScore,
    required this.currentRound,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Round $currentRound/3',
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 24.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Text(
                    'You',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    playerScore.toString(),
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 32.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 40.w),
              Column(
                children: [
                  Text(
                    'CPU',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    computerScore.toString(),
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 32.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
