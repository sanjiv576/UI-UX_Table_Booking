import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../provider/is_dark_theme.dart';

class SuperToolTipWidget extends ConsumerStatefulWidget {
  const SuperToolTipWidget({
    super.key,
    required this.tooltipMessage,
  });

  final String tooltipMessage;

  @override
  ConsumerState<SuperToolTipWidget> createState() => _SuperToolTipWidgetState();
}

class _SuperToolTipWidgetState extends ConsumerState<SuperToolTipWidget> {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);
    return SuperTooltip(
      borderColor: !isDarkTheme ? Colors.white : Colors.black,
      content: Text(widget.tooltipMessage,
          softWrap: true, style: Theme.of(context).textTheme.labelMedium),
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: const Icon(
          FontAwesomeIcons.circleQuestion,
        ),
      ),
    );
  }
}
