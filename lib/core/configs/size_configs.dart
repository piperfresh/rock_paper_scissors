import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double refHeight;
  static late double refWidth;

  void init(BuildContext context, double designWidth, double designHeight) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    refHeight = designHeight;
    refWidth = designWidth;

    if (screenHeight < 400) {
      blockSizeHorizontal = screenWidth / 100;
      blockSizeVertical = screenHeight / 100;
    } else {
      blockSizeHorizontal = screenWidth / refWidth;
      blockSizeVertical = screenHeight / refHeight;
    }

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  static double getProportionateScreenHeight(double inputHeight) {
    return (inputHeight / refHeight) * screenHeight;
  }

  static double getProportionateScreenWidth(double inputWidth) {
    return (inputWidth / refWidth) * screenWidth;
  }
}
