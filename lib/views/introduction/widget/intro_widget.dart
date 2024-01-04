import 'package:flutter/material.dart';

import '../../../constants/color_constant.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    super.key,
    required this.imageName,
    required this.message,
    required this.uptoColorfulIndex,
  });

  final String imageName;
  final String message;
  final int uptoColorfulIndex;

  final _verticalGap = const SizedBox(height: 40);
  final _horizontalGap = const SizedBox(width: 12);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        Container(
          height: 256,
          width: double.infinity,
          decoration: BoxDecoration(
            color: KColors.introBgColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset('assets/images/$imageName'),
        ),
        _verticalGap,
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        _verticalGap,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++) ...{
              CircleAvatar(
                radius: 15,
                backgroundColor:
                    uptoColorfulIndex >= i ? KColors.light500 : KColors.light50,
              ),
              _horizontalGap,
            }
          ],
        )
      ],
    );
  }
}
