
import 'package:flutter/material.dart';

import '../../../constants/color_constant.dart';

class ProfileEditWidget extends StatelessWidget {
  const ProfileEditWidget({
    super.key,
    required this.label,
    required this.trailingWidget,
    required this.leadingIconData,
  });

  final String label;
  final Widget trailingWidget;
  final IconData leadingIconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: KColors.gray100,
          borderRadius: BorderRadius.circular(4),
          border: const Border(
            top: BorderSide(color: Colors.black, width: 1),
            bottom: BorderSide(color: Colors.black, width: 1),
          )),
      child: ListTile(
        contentPadding: const EdgeInsets.all(4),
        leading: Icon(
          leadingIconData,
          color: Colors.black,
        ),
        title: Text(
          label,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black,
              ),
        ),
        trailing: trailingWidget,
      ),
    );
  }
}
