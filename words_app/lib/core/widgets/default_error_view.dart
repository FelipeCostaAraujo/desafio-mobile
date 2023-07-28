import 'package:flutter/material.dart';

class DefaultErrorView extends StatelessWidget {
  final String message;
  final String? buttonLabel;
  final VoidCallback? onTryAgain;
  const DefaultErrorView(
      {this.buttonLabel, this.onTryAgain, required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: Text(
                message,
                style: const TextStyle(fontSize: 24, color: Colors.red),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red[300],
              fixedSize: const Size(200, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onTryAgain,
            child: Text(buttonLabel ?? "Tente novamente"),
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}
