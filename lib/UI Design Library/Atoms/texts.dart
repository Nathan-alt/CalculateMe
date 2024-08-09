import 'package:calculate_me/UI%20Design%20Library/Sub-atomic/colors.dart';
import 'package:flutter/material.dart';

import '../Sub-atomic/text_sizes.dart';

class UIText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  UIText(
      this.text, {super.key,
        this.size = TextSizes.medium,
        this.color = Colors.black,
      });

  factory UIText.large(String text, { color = UIColors.black}) {
    return UIText(text, size: TextSizes.large, color: color);
  }

  factory UIText.medium(String text, { color = UIColors.black}) {
    return UIText(text, size: TextSizes.medium, color: color);
  }

  factory UIText.small(String text, { color = UIColors.black} ) {
    return UIText(text, size: TextSizes.medium, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: size,
        color: color,
      ),
    );
  }
}