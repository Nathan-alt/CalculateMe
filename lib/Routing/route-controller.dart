
import 'package:calculate_me/features/Calculator/calculator_screen_viewmodel.dart';
import 'package:calculate_me/features/History/history_screen.dart';
import 'package:calculate_me/features/UndefinedPage/undefined_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../Dtos/equation.dart';
import '../features/Calculator/calculator_screen.dart';

enum Screen {
  home,
  history
}

extension ScreenRoutes on Screen {
  static const _routes = {
    Screen.home: 'home',
    Screen.history: 'history',
  };

  static Screen? fromString(String? route) {
    if (route == null) return null;
    return _routes.entries
        .firstWhereOrNull((entry) => entry.value == route)
        ?.key;
  }

  String get route => _routes[this]!;
}

class RouteController {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Screen? routeName = ScreenRoutes.fromString(settings.name);

    switch (routeName) {
      case Screen.home:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => CalculatorScreenViewModel(),
            child: const CalculatorScreen(),
          ),
        );
      case Screen.history:
        final List<Equation> equations = settings.arguments as List<Equation>;
        return MaterialPageRoute(
          builder: (context) => HistoryScreen(equations: equations),
        );

      default:
        return MaterialPageRoute(builder: (context) => const UndefinedScreen());
    }
  }
}