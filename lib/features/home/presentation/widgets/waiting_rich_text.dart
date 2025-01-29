import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/core/extensions/build_context.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/core/utils/app_color.dart';

class WaitingRichText extends StatelessWidget {
  const WaitingRichText({
    super.key,
    required this.leftText,
    required this.rightText,
    this.leftTextColor,
  });

  final String leftText;
  final String rightText;
  final Color? leftTextColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: leftText,
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 19.5.sp,
              color: leftTextColor,
            ),
            children: [
          TextSpan(
            text: ' $rightText',
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 19.5.sp,
              color: AppColor.white,
            ),
          ),
        ]));
  }
}
