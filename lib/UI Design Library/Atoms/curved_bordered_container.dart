import 'package:calculate_me/UI%20Design%20Library/Sub-atomic/colors.dart';
import 'package:calculate_me/UI%20Design%20Library/Sub-atomic/radii.dart';
import 'package:flutter/material.dart';

class CurvedBorderedContainer extends StatelessWidget {
  final Widget child;
  final double padding;
  final double height;
  const CurvedBorderedContainer({super.key, required this.child, this.padding = 20.0, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(padding),
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: UIColors.white,
          borderRadius: BorderRadius.circular(UIRadii.large),
          border: Border.all(
            color: UIColors.deepPrimary, // Border color
            width: 2.0, // Border width
          ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          child,
        ],
      ),
    );
  }
}