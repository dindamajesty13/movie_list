import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Oops!',
          style: textTheme.titleMedium,
        ),
        Text(
          'Something went wrong',
          style: textTheme.bodyLarge,
        ),
        Text(
          'Try again later!',
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }
}
