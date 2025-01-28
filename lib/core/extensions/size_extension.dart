import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/core/configs/size_configs.dart';

extension ResponsiveSizeExtension on num {
  double get h => SizeConfig.getProportionateScreenHeight(toDouble());

  double get w => SizeConfig.getProportionateScreenWidth(toDouble());

  double get sp => SizeConfig.getProportionateScreenWidth(toDouble());

  SizedBox get sbW => SizedBox(width: w);

  SizedBox get sbH => SizedBox(height: h);
}