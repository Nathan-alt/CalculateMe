
extension StringExtension on String {
  /// Removes the last character from the string.
  /// If the string is empty, this method returns an empty string.
  ///
  /// Returns:
  /// - A string with the last character removed if the string is not empty.
  /// - An empty string if the original string is empty.
  String removeLastChar() {
    return isNotEmpty ? substring(0, length - 1) : "";
  }
}