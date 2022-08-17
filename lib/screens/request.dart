import 'package:flutter/material.dart';
import 'package:pry20220116/widgets/with_tooltip.dart';
import 'package:pry20220116/widgets/input_with_help.dart';
import 'package:pry20220116/widgets/primary_button.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          WithTooltip(child: Text('SOLICITUD', style: Theme.of(context).textTheme.headline1,), tooltipMessage: 'Ayuda'),
          const SizedBox(height: 15,),
          Form(
            child: Column(
              children: [
                InputWithHelp(placeholder: 'NOMBRE COMPLETO', tooltipMessage: 'Ayuda'),
                InputWithHelp(placeholder: 'EDAD', tooltipMessage: 'Ayuda'),
                InputWithHelp(placeholder: 'DIRECCION', tooltipMessage: 'Ayuda'),
                InputWithHelp(placeholder: 'SINTOMAS', tooltipMessage: 'Ayuda', multiline: true,),
                const SizedBox(height: 15,),
                PrimaryButton(text: 'SIGUIENTE', onPressed: () {})
              ],
            ),
          )
        ],
      ),
    );
  }
}
