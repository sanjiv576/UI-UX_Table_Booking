import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget(
      {super.key, required String text, required IconData iconData})
      : _iconData = iconData,
        _text = text;

  final IconData _iconData;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return ListTile(
        leading: Icon(
          _iconData,
        ),
        contentPadding: const EdgeInsets.all(0),
        title: Text(
          _text,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      );
    });
  }
}
