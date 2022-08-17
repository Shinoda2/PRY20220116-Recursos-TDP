import 'package:flutter/material.dart';

class WithTooltip extends StatelessWidget {
  final Widget? child;
  final String? tooltipMessage;

  const WithTooltip({Key? key, @required this.child, @required this.tooltipMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        child!,
        const SizedBox(
          width: 3.00,
        ),
        Tooltip(
          message: tooltipMessage!,
          child: const Icon(
            Icons.help_outline_rounded,
            color: Colors.grey,
            size: 22,
          ),
        )
      ],
    );
  }
}
