import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final Color? buttonColor;

  const PrimaryButtonWidget(
      {super.key,
      required this.onPressed,
      required this.label,
      this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: buttonColor == null
            ? Theme.of(context).elevatedButtonTheme.style
            : ElevatedButton.styleFrom(backgroundColor: buttonColor),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
