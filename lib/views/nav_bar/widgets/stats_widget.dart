import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({
    super.key,
    required this.statNum,
    required this.verticalGap,
    required this.label,
  });

  final String statNum;
  final SizedBox verticalGap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            statNum,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          verticalGap,
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
