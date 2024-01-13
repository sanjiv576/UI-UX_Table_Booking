
import 'package:flutter/material.dart';

class RestaurantLabelWidget extends StatelessWidget {
  const RestaurantLabelWidget({
    super.key,
    required this.textName,
    required this.iconData,
  });

  final String textName;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Colors.black,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          textName,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
