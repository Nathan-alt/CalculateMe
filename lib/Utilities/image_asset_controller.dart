import 'package:flutter/material.dart';

abstract class ImageAssetController {
  // Method to get the image widget
  static Widget widget(String imagePath, {double? width, double? height}) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}