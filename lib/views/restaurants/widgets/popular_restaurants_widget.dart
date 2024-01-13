
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/restaurant_entity.dart';
import '../../../provider/is_dark_theme.dart';
import 'restaurant_card_widget.dart';

class PopularRestaurantsWidget extends ConsumerWidget {
  const PopularRestaurantsWidget({
    super.key,
    required this.popularRestaurants,
    required SizedBox verticalGap,
  }) : _verticalGap = verticalGap;

  final List<RestaurantEntity> popularRestaurants;
  final SizedBox _verticalGap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = popularRestaurants.length - 1; i >= 0; i--) ...{
            RestaurantCardWidget(
              isDarkTheme: isDarkTheme,
              restaurants: popularRestaurants,
              i: i,
              verticalGap: _verticalGap,
            ),
            _verticalGap
          }
        ],
      ),
    );
  }
}
