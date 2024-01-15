import 'package:flutter/material.dart';

import '../../../constants/color_constant.dart';

class RoundIconButton extends StatelessWidget {
  // const RoundIconButton({super.key});

  final IconData? icon;
  final VoidCallback? onPressedCustom;
  const RoundIconButton(
      {super.key, required this.icon, required this.onPressedCustom});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressedCustom,
      fillColor: KColors.rose900,
      elevation: 6.0,
      constraints: const BoxConstraints.tightFor(
        height: 50.0,
        width: 50.0,
      ),
      shape: const CircleBorder(),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
