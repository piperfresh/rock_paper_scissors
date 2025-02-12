import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rock_paper_scissors/core/extensions/asset.dart';
import 'package:rock_paper_scissors/core/extensions/build_context.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/core/utils/app_color.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? icon;
  final String buttonTitle;
  final Color buttonColor;
  final Color shadowColor;
  final double height;

  const AppButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.buttonTitle,
    required this.buttonColor,
    required this.shadowColor,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30.w),
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ]),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            12.sbH,
            if (icon == null)
            SvgPicture.asset(icon?.svg ?? ''),
            Text(
              buttonTitle,
              style: context.textTheme.bodySmall,
            ),
            12.sbH,
          ],
        ),
      ),
    );
  }
}
