import 'package:calculate_me/Dtos/equation.dart';
import 'package:calculate_me/UI%20Design%20Library/Atoms/safe_scaffold.dart';
import 'package:calculate_me/UI%20Design%20Library/Molecules/history_list.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.equations});
  final List<Equation> equations;

  @override
  Widget build(BuildContext context) {
    return UISafeScaffold(
      appBar: AppBar(),
      child: HistoryListWidget(equations: equations, alginment: Alignment.topRight,),
    );
  }
}
