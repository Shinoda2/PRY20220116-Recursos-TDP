import 'package:flutter/material.dart';

class InputWithHelp extends StatelessWidget {
  final String? placeholder;
  final String? tooltipMessage;
  final bool? multiline;

  const InputWithHelp(
      {Key? key, @required this.placeholder, @required this.tooltipMessage,this.multiline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.camera_alt_outlined),
          const SizedBox(
            width: 10.00,
          ),
          Flexible(child: TextFormField(
            maxLines: multiline == null ? null : 5,
            decoration: InputDecoration(hintText: placeholder!),
          ),),
          const SizedBox(
            width: 10.00,
          ),
          Tooltip(
            message: tooltipMessage!,
            child: const Icon(
              Icons.help_outline_rounded,
              color: Colors.grey,
              size: 24,
            ),
          )
        ],
      ),
    );
  }
}
