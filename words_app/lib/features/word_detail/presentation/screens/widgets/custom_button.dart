import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback? onPressed;
  const CustomButton({required this.buttonLabel, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red[300],
          fixedSize: Size(MediaQuery.of(context).size.width, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(buttonLabel),
      ),
    );
  }
}
