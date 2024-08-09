import 'package:calculate_me/Bases/base_viewmodel.dart';
import 'package:calculate_me/Constants/keyboard-literals.dart';
import 'package:calculate_me/Dtos/equation.dart';
import 'package:calculate_me/Extensions/strings.dart';
import 'package:calculate_me/Utilities/snackbar_alert_controller.dart';
import 'package:flutter/material.dart';

enum CalculatorState {
  numberInFocus,
  symbolInFocus,
  equalTapped,
  idle,
  newEquationSaved
}

class CalculatorScreenViewModel extends ChangeNotifier with ContextHolderMixin {
  // MARK: - Public Variables
  List<Equation> get previousEquations => List.from(_previousEquations);
  Equation get currentEquation => Equation(
      operators: _operators, // Default first number is positive
      operands: _operandsIncludingFocused,
      result: _result);
  bool historyEquationListUpdated = false;

  // MARK: - Private Variables
  final List<Equation> _previousEquations = [];
  List<String> _operators = [KeyboardLiterals.ADD]; // Default first number is positive
  List<int> _operands = [];
  int? _result;
  CalculatorState _state = CalculatorState.idle;
  String _focusedValue = "";

  // MARK: - Computed Properties
  List<int> get _operandsIncludingFocused =>
      [..._operands, if (_focusedValue.isNotEmpty) int.parse(_focusedValue)];

  // MARK: - Public methods
  void clearCurrentEquation() {
    _reset();
    notifyListeners();
  }

  void deleteCharacter() {
    if (_focusedValue.isNotEmpty) {
      _deleteFocusedValue();
    } else if (_operators.length > 1) {
      _deleteLastOperator();
    } else if (_operators.length == 1 &&
        _operators.first == KeyboardLiterals.SUBTRACT) {
      _operators = ["+"];
      _state = CalculatorState.idle;
    } else {
      SnackBarController.show(context, "Value already cleared");
    }
    notifyListeners();
  }

  void equalOperandPressed() {
    if (_state == CalculatorState.equalTapped) {
      _saveEquationAndReset();
      notifyListeners();
      return;
    }

    if (_focusedValue.isEmpty) {
      if (_state == CalculatorState.symbolInFocus) {
        SnackBarController.show(context,
            "Please remove symbol or complete equation first.");
      }
      return;
    }

    _storeNumberInEquation();
    _result = _calculateResult();
    _state = CalculatorState.equalTapped;
    _result = _result;
    notifyListeners();
  }

  void onTapOperator(String operandSymbol) {
    if (_state == CalculatorState.equalTapped) {
      _handleOperatorInEqualTappedState();
    }
    _appendOperator(operandSymbol);
    notifyListeners();
  }

  void appendNumericCharacter(String char) {
    if (_state == CalculatorState.equalTapped) {
      _saveEquationAndReset();
    }
    _focusedValue += char;
    notifyListeners();
  }

  void onTapUndefinedKey() {
    SnackBarController.show(context,
        "This is not functional, perhaps when hired it will be    :'P");
  }

  // MARK: - Private Methods
  void _deleteFocusedValue() {
    _focusedValue = _focusedValue.removeLastChar();
    _state = _focusedValue.isEmpty
        ? CalculatorState.symbolInFocus
        : CalculatorState.numberInFocus;
  }

  void _deleteLastOperator() {
    _operators.removeLast();
    _focusedValue = "${_operands.removeLast()}";
    _state = CalculatorState.numberInFocus;
  }

  int? _calculateResult() {
    if (_operands.isEmpty) {
      return null;
    }
    int result = 0;
    for (int i = 0; i < _operands.length; i++) {
      result +=
          _convertToSignedValue(symbol: _operators[i], value: _operands[i]);
    }
    return result;
  }

  int _convertToSignedValue({required String symbol, required int value}) {
    switch (symbol) {
      case KeyboardLiterals.ADD:
        return value;
      case KeyboardLiterals.SUBTRACT:
        return -value;
      default:
        throw ArgumentError("Unexpected symbol '$symbol' encountered");
    }
  }

  _reset() {
    _focusedValue = "";
    _operators = [KeyboardLiterals.ADD];
    _operands = [];
    _result = null;
    _state = CalculatorState.idle;
  }

  _appendOperator(String operandSymbol) {
    if (_focusedValue.isEmpty) {
      _operators.removeLast();
      _operators.add(operandSymbol);
    } else {
      _storeNumberInEquation();
      _operators.add(operandSymbol);
    }
    _state = CalculatorState.symbolInFocus;
  }

  _storeNumberInEquation() {
    final iValue = int.parse(_focusedValue);
    _focusedValue = "";
    _operands.add(iValue);
  }

  _saveEquationAndReset() {
    _previousEquations.add(currentEquation);
    historyEquationListUpdated = true;
    notifyListeners();
    _reset();
  }

  void _handleOperatorInEqualTappedState() {
    _saveEquationAndReset();
    final lastResult = _previousEquations.last.result!;
    _operators = [
      lastResult.isNegative ? KeyboardLiterals.SUBTRACT : KeyboardLiterals.ADD
    ];
    _focusedValue = "${lastResult.abs()}";
  }
}
