import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(String fontFamily, double fontSize, FontWeight fontWeight, Color color, List<Shadow>? shadows) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight,
      shadows: shadows,
  );
}

// thin style
TextStyle getThinStyle(
    {fontFamily = FontConstants.kreon, fontSize = FontSize.s12, required Color color, List<Shadow>? shadows}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.thin, color, shadows);
}

// extralight style
TextStyle getExtraLightStyle(
    {fontFamily = FontConstants.kreon, fontSize = FontSize.s12, required Color color, List<Shadow>? shadows}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.extraLight, color, shadows);
}

// light style
TextStyle getLightStyle(
    {fontFamily = FontConstants.kreon, fontSize = FontSize.s12, required Color color, List<Shadow>? shadows})
{
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.light, color, shadows);
}

// regular style
TextStyle getRegularStyle(
    {fontFamily = FontConstants.kreon, fontSize = FontSize.s12, required Color color, List<Shadow>? shadows}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.regular, color, shadows);
}

// medium style
TextStyle getMediumStyle(
    {fontFamily = FontConstants.kreon, double fontSize = FontSize.s12, required Color color, List<Shadow>? shadows}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.medium, color, shadows);
}

// medium style
TextStyle getSemiBoldStyle(
    {fontFamily = FontConstants.kreon, double fontSize = FontSize.s12, required Color color, List<Shadow>? shadows}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.semiBold, color, shadows);
}

// bold style
TextStyle getBoldStyle(
    {fontFamily = FontConstants.kreon,  double fontSize = FontSize.s12, required Color color, List<Shadow>? shadows}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.bold, color, shadows,);
}

// extrabold style
TextStyle getExtraBoldStyle(
    {fontFamily = FontConstants.kreon, double fontSize = FontSize.s12, required Color color, List<Shadow>? shadows}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.extraBold, color, shadows);
}

// black style
TextStyle getBlackStyle(
    {fontFamily = FontConstants.kreon, double fontSize = FontSize.s12, required Color color, List<Shadow>? shadows}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.black, color, shadows);
}
