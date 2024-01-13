import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/color_constant.dart';
import '../../provider/is_dark_theme.dart';

class ReusablePinput extends ConsumerWidget {
  const ReusablePinput(
      {super.key, required this.onChangedFunc, required this.controllerName});

  final onChangedFunc;
  final controllerName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);
    return SizedBox(
      height: 70,
      width: 70,
      child: TextFormField(
        onChanged: onChangedFunc,
        controller: controllerName,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: isDarkTheme
              ? KColors.darkPrimaryColor
              : KColors.lightPrimaryColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
