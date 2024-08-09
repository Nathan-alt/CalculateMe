import 'package:calculate_me/Dtos/equation.dart';
import 'package:flutter/material.dart';
import 'richtext_equation.dart';

class HistoryListWidget extends StatefulWidget {
  HistoryListWidget(
      {super.key, required this.equations, this.alginment = Alignment.bottomRight});

  final Alignment alginment;
  final List<Equation> equations;

  @override
  State<HistoryListWidget> createState() => _HistoryListWidgetState();
}

class _HistoryListWidgetState extends State<HistoryListWidget> {
  late List<Equation> _equations;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void didUpdateWidget(HistoryListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // This is to ensure on re-render, it displays the first element.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    _equations = widget.equations;
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: widget.alginment,
            child: ListView.builder(
              reverse: true,
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: _equations.length,
              itemBuilder: (context, index) {
                final equation = _equations[index];
                return ListTile(
                  title: UIEquationRichText.smallMediumFadedColor(
                      equation: equation),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
