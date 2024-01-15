import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/restaurant_data.dart';
import '../../data/story_data.dart';
import '../../models/restaurant_entity.dart';
import '../../models/story_entity.dart';
import '../../provider/is_dark_theme.dart';
import '../restaurants/widgets/all_restaurants_widget.dart';
import '../restaurants/widgets/popular_restaurants_widget.dart';
import '../restaurants/widgets/story_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomeView> with TickerProviderStateMixin {
  late double width;
  late double height;

  List<RestaurantEntity> allRestaurants = RestaurantData.restaurants;
  List<RestaurantEntity> popularRestaurants = RestaurantData.restaurants;
  List<StoryEntity> stories = StoryData.stories;

  final _verticalGap = const SizedBox(height: 16);
  final _horizontalGap = const SizedBox(width: 16);

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkThemeValue = ref.watch(isDarkThemeProvider);

    // get sizes of the device, then, send to device size class
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    log('Width: $width');
    log('Height: $height');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi 👋, Sanjiv',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                _verticalGap,
                Text(
                  'Restaurant Stories',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                _verticalGap,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: StoryWidget(
                      stories: stories,
                      verticalGap: _verticalGap,
                      horizontalGap: _horizontalGap),
                ),
                _verticalGap,
                TabBar.secondary(
                  controller: _tabController,
                  indicatorColor: darkThemeValue ? Colors.white : Colors.black,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                  tabs: const <Widget>[
                    Tab(
                      text: 'All',
                    ),
                    Tab(text: 'Popular'),
                  ],
                ),
                _verticalGap,
                SizedBox(
                  height: height * 0.7,
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      AllRestaurantsWidget(allRestaurants: allRestaurants),
                      PopularRestaurantsWidget(
                          popularRestaurants: popularRestaurants,
                          verticalGap: _verticalGap),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
