import 'package:calculate_me/UI%20Design%20Library/Atoms/texts.dart';
import 'package:calculate_me/UI%20Design%20Library/Sub-atomic/colors.dart';
import 'package:calculate_me/UI%20Design%20Library/Sub-atomic/radii.dart';
import 'package:calculate_me/UI%20Design%20Library/Sub-atomic/text_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants/image_asset_paths.dart';
import '../../Utilities/image_asset_controller.dart';

class UIButton extends StatelessWidget {
  final String? label;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final String? imagePath;
  final EdgeInsets padding;

  // Private constructor
  const UIButton._({
    this.label,
    required this.onPressed,
    required this.color,
    required this.textColor,
    this.imagePath,
    this.padding = EdgeInsets.zero
  });
  
  // Factory constructor for primary button

  factory UIButton.white({
    required String label,
    required VoidCallback onPressed,
  }) {
    return UIButton._(
      label: label,
      onPressed: onPressed,
      color: UIColors.white, // Primary color
      textColor: UIColors.primary,
    );
  }

  factory UIButton.primary({
    required String label,
    required VoidCallback onPressed,
  }) {
    return UIButton._(
      label: label,
      onPressed: onPressed,
      color: UIColors.primary, // Primary color
      textColor: UIColors.white,
    );
  }

  factory UIButton.secondary({
    required String label,
    required VoidCallback onPressed,
  }) {
    return UIButton._(
      label: label,
      onPressed: onPressed,
      color: UIColors.secondary, // Primary color
      textColor: UIColors.white,
    );
  }

  factory UIButton.whiteIcon({
    required String imagePath,
    required VoidCallback onPressed,
  }) {
    return UIButton._(
      onPressed: onPressed,
      color: UIColors.white, // Primary color
      textColor: UIColors.white,
      imagePath: imagePath,
      padding: const EdgeInsets.all(14),
    );
  }

  factory UIButton.secondaryIcon({
    required String imagePath,
    required VoidCallback onPressed,
  }) {
    return UIButton._(
      label: "",
      onPressed: onPressed,
      color: UIColors.secondary, // Primary color
      textColor: UIColors.white,
      imagePath: imagePath,
      padding: const EdgeInsets.all(14),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert( label != null || imagePath != null, "Either image path or label must be provided");
    final child = imagePath != null ? ImageAssetController.widget(imagePath!) : UIText.medium(label!, color: textColor);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
        child: MaterialButton(
          padding: padding,
          onPressed: onPressed,
          color: color,
          highlightColor: Colors.blueGrey[100],
          splashColor: Colors.white.withAlpha(100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIRadii.large),
          ),
          child: child
        )
    );
  }
}