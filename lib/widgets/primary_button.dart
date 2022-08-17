import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed; // Notice the variable type
  const PrimaryButton({Key? key, @required this.text, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text!,
            style: Theme.of(context).textTheme.headline2),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent)
        ),
      ),
    );
  }
}
