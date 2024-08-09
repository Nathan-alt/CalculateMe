import 'package:calculate_me/Dtos/equation.dart';
import 'package:calculate_me/Routing/route-controller.dart';
import 'package:calculate_me/UI%20Design%20Library/Atoms/curved_bordered_container.dart';
import 'package:calculate_me/UI%20Design%20Library/Atoms/safe_scaffold.dart';
import 'package:calculate_me/UI%20Design%20Library/Molecules/history_list.dart';
import 'package:calculate_me/UI%20Design%20Library/Molecules/keyboard.dart';
import 'package:calculate_me/UI%20Design%20Library/Molecules/richtext_equation.dart';
import 'package:calculate_me/features/Calculator/calculator_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  CalculatorScreenViewModel get readOnlyVm =>
      Provider.of<CalculatorScreenViewModel>(context, listen: false);

  _navigateToHistory() {
    Navigator.pushNamed(context, Screen.history.route,
        arguments: readOnlyVm.previousEquations);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      readOnlyVm.context = context;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UISafeScaffold(
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Expanded(
            child: Selector<CalculatorScreenViewModel, List<Equation>>(
              selector: (context, viewModel) => viewModel.previousEquations,
              builder: (context, equations, child) {
                return HistoryListWidget(
                  equations: equations,
                  // needsScroll: true,
                );
              },
            )
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          child: CurvedBorderedContainer(
              height: 100,
              child: Selector<CalculatorScreenViewModel, Equation>(
                  selector: (context, viewModel) => viewModel.currentEquation,
                  builder: (context, value, child) {
                    return UIEquationRichText.mediumWithLargeResult(
                      equation: value,
                    );
                  })),
        ),
        Flexible(
            flex: 2,
            child: Keyboard(
                numericTapHandler: readOnlyVm.appendNumericCharacter,
                equalOperandHandler: readOnlyVm.equalOperandPressed,
                backspaceHandler: readOnlyVm.deleteCharacter,
                clearHandler: readOnlyVm.clearCurrentEquation,
                mathSymbolHandler: readOnlyVm.onTapOperator,
                undefinedHandler: readOnlyVm.onTapUndefinedKey,
                onShowHistoryHandler: _navigateToHistory))
      ]),
    );
  }
}
