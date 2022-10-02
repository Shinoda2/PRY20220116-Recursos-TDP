import 'package:flutter/material.dart';

class InputWithHelp extends StatelessWidget {
  final String? placeholder;
  final String? tooltipMessage;
  final bool? multiline;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const InputWithHelp(
      {Key? key,
      required this.placeholder,
      required this.tooltipMessage,
      required this.controller,
      this.validator,
      this.keyboardType,
      this.multiline = false})
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
          Flexible(
            child: TextFormField(
              controller: controller,
              textInputAction: TextInputAction.done,
              maxLines: multiline == false ? 1 : 5,
              decoration: InputDecoration(hintText: placeholder!),
              validator: validator,
              keyboardType: keyboardType,
            ),
          ),
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
