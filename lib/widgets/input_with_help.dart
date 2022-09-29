import 'package:flutter/material.dart';

class InputWithHelp extends StatelessWidget {
  final String? placeholder;
  final String? tooltipMessage;
  final bool? multiline;
  final TextEditingController? controlador;

  const InputWithHelp(
      {Key? key, @required this.placeholder, @required this.tooltipMessage,this.multiline, @required this.controlador,})
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
            controller: controlador,
            maxLines: multiline == null ? null : 5,
            decoration: InputDecoration(hintText: placeholder!),
            validator: (value){
              if(value!.isEmpty){
                return 'Ingrese los síntomas.';
              }
              return null;
            },
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
