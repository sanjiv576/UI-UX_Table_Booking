import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/widgets/search_widget.dart';
import '../../data/restaurant_data.dart';
import '../../provider/is_dark_theme.dart';
import '../restaurants/widgets/restaurant_card_widget.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  final _searchController = TextEditingController();

  List<dynamic> _filteredRestaurants = [];

  bool _isInitializeSearching = false;

  final _verticalGap = const SizedBox(height: 16);

  @override
  void initState() {
    // getProductData();
    _searchController.addListener(_onSearching);
    super.initState();
  }

  void _onSearching() {
    final searchQuery = _searchController.text.trim().toLowerCase();
    if (searchQuery.isEmpty) {
      setState(() {
        _isInitializeSearching = false;
        _filteredRestaurants = [];
      });
    } else {
      setState(() {
        _isInitializeSearching = true;

        _filteredRestaurants = RestaurantData.restaurants
            .where((product) =>
                product.name.toLowerCase().contains(searchQuery) ||
                product.location.toLowerCase().contains(searchQuery))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarWidget(
                controller: _searchController,
                leadingIcon: Icons.search,
                hintText: 'Enter restaurant by name or location',
                onPress: () {
                  setState(() {
                    _isInitializeSearching = false;
                    _filteredRestaurants = [];
                    _searchController.clear();
                  });
                },
              ),
              _verticalGap,
              Expanded(
                child: _isInitializeSearching
                    ? ListView.separated(
                        itemCount: _filteredRestaurants.length,
                        itemBuilder: (context, index) {
                          var singleProduct = _filteredRestaurants[index];
                          return GestureDetector(
                            onTap: () {
                              log('Product name ; ${singleProduct.name}');
                              // Navigator.pushNamed(
                              //     context, AppRoutes.singleProductRoute,
                              //     arguments: singleProduct);
                            },
                            child: RestaurantCardWidget(
                              isDarkTheme: ref.watch(isDarkThemeProvider),
                              restaurants: RestaurantData.restaurants,
                              i: index,
                              verticalGap: _verticalGap,
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 16,
                            color: Colors.transparent,
                          );
                        },
                      )
                    : const Center(
                        child: Text('No data found'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
