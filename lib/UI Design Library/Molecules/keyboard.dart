import 'package:calculate_me/Constants/image_asset_paths.dart';
import 'package:calculate_me/Constants/keyboard-literals.dart';
import 'package:calculate_me/UI%20Design%20Library/Atoms/buttons.dart';
import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  Keyboard(
      {super.key,
      required this.numericTapHandler,
      required this.backspaceHandler,
      required this.clearHandler,
      required this.mathSymbolHandler,
      this.undefinedHandler = _defaultUndefinedHandler,
      required this.equalOperandHandler,
      required this.onShowHistoryHandler});

  // MARK: - Callbacks
  final ValueChanged<String> numericTapHandler;
  final VoidCallback backspaceHandler;
  final VoidCallback equalOperandHandler;
  final VoidCallback clearHandler;
  final VoidCallback undefinedHandler;
  final VoidCallback onShowHistoryHandler;
  final ValueChanged<String> mathSymbolHandler;

  // Default handler
  static void _defaultUndefinedHandler() {}

  // Key Layouts
  final _calculatorKeyColumns = [
    [KeyboardLiterals.HISTORY, '7', '4', '1', KeyboardLiterals.DEL],
    [KeyboardLiterals.CLEAR, '8', '5', '2', '0'],
    [KeyboardLiterals.MULTIPLY, '9', '6', '3', '.'],
    [
      KeyboardLiterals.DIVIDE,
      KeyboardLiterals.ADD,
      KeyboardLiterals.SUBTRACT,
      KeyboardLiterals.EQUAL
    ]
  ];

  final _secondaryStyleKeys = [
    KeyboardLiterals.DIVIDE,
    KeyboardLiterals.ADD,
    KeyboardLiterals.SUBTRACT,
    KeyboardLiterals.CLEAR,
    KeyboardLiterals.MULTIPLY
  ];

  final Set<String> _numericChars = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
  final Set<String> _mathSymbols = {
    KeyboardLiterals.ADD,
    KeyboardLiterals.SUBTRACT
  }; // Ignoring divide and multiplication

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _calculatorKeyColumns.map((columnKeys) {
        return Expanded(
          child: _keyboardColumn(columnKeys),
        );
      }).toList(),
    );
  }

  Widget _keyboardColumn(List<String> buttonCharacters) {
    return Column(
      children: buttonCharacters
          .map((e) => Expanded(
              flex: e.compareTo(KeyboardLiterals.EQUAL) == 0 ? 2 : 1,
              child: _button(e)
              ))
          .toList(),
    );
  }

  Widget _button(String key) {
    final VoidCallback function = _onTapHandler(key);
    if (key == KeyboardLiterals.EQUAL) {
      return UIButton.primary(label: key, onPressed: function);
    } else if (key == KeyboardLiterals.DEL) {
      return UIButton.whiteIcon(
          imagePath: ImageAssetPaths.deleteKey, onPressed: function);
    } else if (key == KeyboardLiterals.HISTORY) {
      return UIButton.secondaryIcon(
          imagePath: ImageAssetPaths.historyKey, onPressed: function);
    } else if (_secondaryStyleKeys.contains(key)) {
      return UIButton.secondary(label: key, onPressed: function);
    } else {
      return UIButton.white(label: key, onPressed: function);
    }
  }

  VoidCallback _onTapHandler(String key) {
    if (_numericChars.contains(key)) {
      return () => {numericTapHandler(key)};
    }
    if (KeyboardLiterals.DEL == key) {
      return () => {backspaceHandler()};
    }
    if (_mathSymbols.contains(key)) {
      return () => {mathSymbolHandler(key)};
    }
    if (KeyboardLiterals.EQUAL == key) {
      return () => {equalOperandHandler()};
    }
    if (KeyboardLiterals.CLEAR == key) {
      return () => {clearHandler()};
    }
    if (KeyboardLiterals.HISTORY == key) {
      return () => { onShowHistoryHandler() };
    }
    return () => {undefinedHandler()};
  }
}
