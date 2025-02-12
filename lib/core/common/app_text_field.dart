import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/core/utils/app_color.dart';

class TextFieldWithTitle extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isBigSize;
  final int? maxLines;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const TextFieldWithTitle({
    super.key,
    required this.title,
    this.controller,
    this.hintText,
    this.hintStyle,
    this.contentPadding,
    this.isBigSize = false,
    this.maxLines = 1,
    this.onTap,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 18.sp, color: AppColor.black)),
        6.sbH,
        TextField(
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontSize: 16.sp, color: AppColor.black),
          controller: controller,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          onTap: onTap,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: AppColor.black)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: AppColor.black)),
            contentPadding: contentPadding ?? const EdgeInsets.all(10),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: hintStyle ??
                Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 16.sp, color: AppColor.lightBlue),
          ),
        ),
      ],
    );
  }
}
