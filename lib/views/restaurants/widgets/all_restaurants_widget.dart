import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/restaurant_entity.dart';
import '../../../provider/is_dark_theme.dart';
import 'restaurant_card_widget.dart';

class AllRestaurantsWidget extends ConsumerWidget {
  AllRestaurantsWidget({
    super.key,
    required this.allRestaurants,
  });

  final List<RestaurantEntity> allRestaurants;
  final SizedBox _verticalGap = const SizedBox(height: 4);
  final SizedBox _horizontalGap = const SizedBox(width: 4);

  late double screenHeight;
  late double screenWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);
 
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < allRestaurants.length; i++) ...{
            RestaurantCardWidget(
              isDarkTheme: isDarkTheme,
              restaurants: allRestaurants,
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
