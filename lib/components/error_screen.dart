import 'package:flutter/material.dart';

import 'error_text.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required this.onTryAgainPressed,
  });

  final Function() onTryAgainPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Image.asset(
              'assets/images/icon.png',
              width: double.infinity,
              height: 150.0,
            ),
          ),
          const ErrorText(),
          const SizedBox(height: 15.0),
          ElevatedButton(
            onPressed: onTryAgainPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Text(
              'Try Again!',
              style: textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
