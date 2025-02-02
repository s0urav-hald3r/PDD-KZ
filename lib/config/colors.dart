import 'package:flutter/material.dart';

// Colors
const Color primaryColor = Color(0xFF3550DC);
const Color secondaryColor = Color(0xFF27E9F7);
const Color blackColor = Color(0xFF000000);
const Color whiteColor = Color(0xFFFFFFFF);
const Color textColor = Color(0xFF282828);
const Color greyColor = Color(0xFFF5F7FA);

// Gradient
Shader textShader = const LinearGradient(
  colors: [primaryColor, secondaryColor],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

Gradient containerGradient =
    const LinearGradient(colors: [primaryColor, secondaryColor]);
