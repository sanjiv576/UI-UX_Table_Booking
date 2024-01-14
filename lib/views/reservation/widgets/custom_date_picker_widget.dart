import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/is_dark_theme.dart';

class CustomDateTimePickerWidget extends StatelessWidget {
  const CustomDateTimePickerWidget(
      {super.key,
      required this.gap,
      required String textTitle,
      required VoidCallback onTap,
      String? dateTimeValue})
      : _textTitle = textTitle,
        _dateTimeValue = dateTimeValue ?? 'NA',
        _onTap = onTap;

  final SizedBox gap;
  final String _textTitle;
  final String _dateTimeValue;
  final VoidCallback _onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (contex, ref, child) {
      bool isDark = ref.read(isDarkThemeProvider);
      // Color activeColor = isDark
      //     ? AppColorConstant.nightTextColor
      //     : AppColorConstant.dayTextColor;
      return GestureDetector(
        onTap: _onTap,
        child: SizedBox(
          height: 100,
          // width: DeviceSize.width / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _textTitle.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              gap,
              Text(
                _dateTimeValue.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,

                // style:  TextStyle(
                //     color: activeColor, fontSize: 16, fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
