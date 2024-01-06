import 'package:flutter/material.dart';
import 'super_tooltip_widget.dart';

class TextLabelWidget extends StatelessWidget {
  TextLabelWidget({
    super.key,
    required this.labelName,
    required SizedBox horizontalGap,
    required this.isRequired,
    required this.tooltipMessage,
    this.showInfoIcon,
  }) : _horizontalGap = horizontalGap;

  final String labelName;
  final SizedBox _horizontalGap;
  final bool isRequired;
  final String tooltipMessage;
  bool? showInfoIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          labelName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        _horizontalGap,
        isRequired
            ? Text(
                '*',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.red),
              )
            : Text(
                '(Optional)',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w300),
              ),
        _horizontalGap,
        showInfoIcon ?? true
            ? SuperToolTipWidget(tooltipMessage: tooltipMessage)
            : Container(),
      ],
    );
  }
}
