/// Represents a mathematical equation consisting of operators, operands, and an optional result.
///
/// Example usage:
/// ```dart
/// final equation = Equation(
///   operators: ['+', '-'],
///   operands: [10, 5],
///   result: 15
/// );
/// ```
///
/// In this example, the equation represents a mathematical expression with the operators `+` and `-`
/// and the operands `10` and `5`. The result of evaluating this equation is `5`.
class Equation {
  /// A list of operators used in the equation. Operators are represented as strings
  /// ('+', '-').
  final List<String> operators;

  /// A list of operands used in the equation. Operands are represented as integers.
  final List<int> operands;

  /// The result of evaluating the equation. This is optional and can be `null`
  /// if the result is not yet computed.
  final int? result;

  /// Creates an [Equation] instance with the specified operators, operands, and optional result.
  ///
  /// [operators] is a list of operator strings (e.g., ['+', '-', '*']).
  /// [operands] is a list of integers representing the operands in the equation.
  /// [result] is an optional integer representing the result of evaluating the equation.
  Equation({
    required this.operators,
    required this.operands,
    this.result,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          false;

  @override
  int get hashCode =>
      operators.hashCode ^ operands.hashCode ^ result.hashCode;
}
