
import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';

class OutlineButtonWidget extends StatelessWidget {
  const OutlineButtonWidget({
    super.key,
    required this.buttonName,
    required this.onPress,
  });

  final String buttonName;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(
              color: Colors.black,
            ),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(KColors.light100),
          foregroundColor: MaterialStateProperty.all<Color>(
            Colors.black,
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(
            15,
          )),
        ),
        onPressed: onPress,
        child: Text(
          buttonName.toString(),
        ),
      ),
    );
  }
}
