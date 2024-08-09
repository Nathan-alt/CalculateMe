import 'package:calculate_me/Constants/keyboard-literals.dart';
import 'package:calculate_me/Dtos/equation.dart';
import 'package:calculate_me/Extensions/strings.dart';
import 'package:calculate_me/UI%20Design%20Library/Sub-atomic/colors.dart';
import 'package:calculate_me/UI%20Design%20Library/Sub-atomic/text_sizes.dart';
import 'package:calculate_me/features/Calculator/calculator_screen_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UIEquationRichText extends StatelessWidget {
  UIEquationRichText(
      {super.key,
        required Equation equation,
      required this.fontSize,
      required this.resultFontSize,
      this.operandColor = UIColors.black,
      this.operatorColor = UIColors.primary,
      }):
  result = equation.result,
  operators = equation.operators,
  operands = equation.operands;

  final List<String> operators;
  final List<int> operands;
  final int? result;
  final double fontSize;
  final double resultFontSize;
  final Color operandColor;
  final Color operatorColor;

  factory UIEquationRichText.mediumWithLargeResult(
      {required Equation equation}) {
    return UIEquationRichText(
      equation: equation,
      fontSize: TextSizes.medium,
      resultFontSize: TextSizes.large,
    );
  }

  factory UIEquationRichText.smallMediumFadedColor(
      {required Equation equation}) {
    return UIEquationRichText(
      equation: equation,
      fontSize: TextSizes.small,
      resultFontSize: TextSizes.medium,
      operandColor: UIColors.charcoalBlack,
      operatorColor: UIColors.fadedPrimary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            maxLines: 1,
            text: TextSpan(
              children: _buildTextSpans()
                  .reversed
                  .toList(), // Used to put the elements in reverse order
            ),
          ),
        ),
        RichText(
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          maxLines: 1,
          text: TextSpan(
            children: _resultTextSpan()
                .reversed
                .toList(), // Used to put the elements in reverse order
          ),
        )
      ],
    );
  }

  List<TextSpan> _buildTextSpans() {
    final List<TextSpan> spans = [];
    for (int i = 0; i < operators.length; i++) {
      if (!(i == 0 && operators[i] == KeyboardLiterals.ADD)) {
        spans.add(TextSpan(
          text: ' ${operators[i]} ',
          style: TextStyle(color: operatorColor, fontSize: fontSize),
        ));
      }
      // Add operand
      if (i < operands.length) {
        spans.add(TextSpan(
          text: '${operands[i]}',
          style: TextStyle(color: operandColor, fontSize: fontSize),
        ));
      }
    }

    final equationResult = result;
    if (equationResult != null) {
      spans.add(TextSpan(
        text: ' = ',
        style: TextStyle(color: operandColor, fontSize: fontSize),
      ));
    }
    return spans;
  }

  List<TextSpan> _resultTextSpan() {
    final List<TextSpan> spans = [];
    final equationResult = result;
    if (equationResult != null) {
      final displayResult = equationResult.isNegative ? equationResult * -1 : equationResult;

      if (equationResult.isNegative) {
        // if its negative put sign
        spans.add(TextSpan(
          text: '-',
          style: TextStyle(color: operandColor, fontSize: resultFontSize),
        ));
      }
      spans.add(TextSpan(
        text: '$displayResult',
        style: TextStyle(color: operandColor, fontSize: resultFontSize),
      ));
    }
    return spans;
  }
}
