import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/color_constant.dart';
import '../../../models/restaurant_entity.dart';
import '../../../router/app_routes.dart';
import 'restaurant_label_widget.dart';

class RestaurantCardWidget extends StatelessWidget {
  const RestaurantCardWidget({
    super.key,
    required this.isDarkTheme,
    required this.restaurants,
    required this.i,
    required SizedBox verticalGap,
  }) : _verticalGap = verticalGap;

  final bool isDarkTheme;
  final List<RestaurantEntity> restaurants;
  final int i;
  final SizedBox _verticalGap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.singleRestaurantRoute,
            arguments: restaurants[i]);
      },
      onDoubleTap: () {
        Navigator.pushNamed(context, AppRoutes.reservationRoute,
            arguments: restaurants[i]);
      },
      child: Container(
        //     width: 100,
        // height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isDarkTheme ? Colors.white : KColors.light100,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(
                3.0,
                8.0,
              ), // Adjust the values to control the shadow direction
              blurRadius: 6.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/restaurants/${restaurants[i].picture}',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                // color: Colors.red,
                // height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurants[i].name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.black),
                    ),
                    _verticalGap,
                    RestaurantLabelWidget(
                      textName: restaurants[i].location,
                      iconData: FontAwesomeIcons.locationDot,
                    ),
                    _verticalGap,
                    Row(
                      children: [
                        Expanded(
                          child: RestaurantLabelWidget(
                            textName: '${restaurants[i].rating} Rating',
                            iconData: Icons.star,
                          ),
                        ),
                        Expanded(
                          child: RestaurantLabelWidget(
                            textName: restaurants[i].status,
                            iconData: restaurants[i].status == 'Open'
                                ? Icons.check_circle
                                : Icons.clear,
                          ),
                        ),
                      ],
                    ),
                    _verticalGap,
                    Text(
                      restaurants[i].offer ?? 'No Offer',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
