import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class BottomRichTextWidget extends StatelessWidget {
  const BottomRichTextWidget(
      {super.key,
      required this.message,
      required this.textButtonName,
      required this.onClick});

  final String message;
  final String textButtonName;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: message.toString(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          TextSpan(
            text: textButtonName.toString(),
            style: const TextStyle(
                fontSize: 16, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()..onTap = onClick,
          ),
        ],
      ),
    );
  }
}
