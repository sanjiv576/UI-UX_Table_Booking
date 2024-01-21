import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/widgets/snackbar_message_widget.dart';
import '../../models/restaurant_entity.dart';
import '../../models/review_entity.dart';
import '../../provider/is_dark_theme.dart';
import '../../router/app_routes.dart';
import '../../services/user.dart';
import 'widgets/custom_detect_card_widget.dart';

final addFavoriteProvider = StateProvider<bool>((ref) => false);

class RestaurantView extends ConsumerStatefulWidget {
  const RestaurantView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends ConsumerState<RestaurantView> {
  SizedBox gap = const SizedBox(height: 16);
  final _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RestaurantEntity? _restaurantEntity;
  late bool isDark;

  late List<ReviewEntity> _restaurantReviewsList;

  @override
  void didChangeDependencies() {
    _restaurantEntity =
        ModalRoute.of(context)!.settings.arguments as RestaurantEntity?;

    isDark = ref.read(isDarkThemeProvider);

    _restaurantReviewsList = _restaurantEntity!.reviews!;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _reviewController.dispose();
  }

  void _reviewSubmit() {
    log('Restaurant id: ${_restaurantEntity!.restaurantId}');
    if (_formKey.currentState!.validate()) {
      User.addReview(
          restaurantId: _restaurantEntity!.restaurantId,
          reviewText: _reviewController.text.trim());

      setState(() {});

      _reviewController.clear();
    }
  }

  _callNow() async {
    String contact = _restaurantEntity!.contact;
    await FlutterPhoneDirectCaller.callNumber(contact);
  }

  @override
  Widget build(BuildContext context) {
    _restaurantReviewsList = _restaurantEntity!.reviews!;
    return Scaffold(
      appBar: AppBar(
        title: Text(_restaurantEntity!.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/restaurants/${_restaurantEntity!.picture}',
                  ),
                )),
              ),
              gap,
              Text(_restaurantEntity!.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              gap,
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: const Icon(
                        FontAwesomeIcons.locationDot,
                        size: 18,
                      ),
                      title: Text(
                        _restaurantEntity!.location,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: const Icon(
                        Icons.call,
                        size: 18,
                      ),
                      title: Text(
                        _restaurantEntity!.contact,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: const Icon(Icons.calendar_month),
                      title: Text(
                        'Booking ${_restaurantEntity!.bookingTime}',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: const Icon(
                        Icons.star,
                        size: 18,
                      ),
                      title: Text(
                        ' ${_restaurantEntity!.rating} Rating',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ],
              ),
              gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDetectCardWidget(
                    text: 'Book Table',
                    iconData: Icons.table_bar,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.reservationRoute,
                        arguments: _restaurantEntity,
                      );
                    },
                  ),
                  CustomDetectCardWidget(
                    text: 'Menu Book',
                    iconData: Icons.menu_book,
                    onTap: () {
                      // Navigator.pushNamed(
                      //     context, AppRoute.customerFoodMenuViewRoute);
                    },
                  ),
                  CustomDetectCardWidget(
                    text: 'Call Now',
                    iconData: Icons.call,
                    onTap: () {
                      _callNow();
                    },
                  ),
                ],
              ),
              gap,
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: IconButton(
                  onPressed: () {
                    // _handleFavorite();

                    ref.watch(addFavoriteProvider.notifier).state =
                        !ref.watch(addFavoriteProvider);
                  },
                  icon: Icon(
                    ref.watch(addFavoriteProvider)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: ref.watch(addFavoriteProvider)
                        ? Colors.pink
                        : Colors.black,
                    size: 40,
                  ),
                ),
                title: Text(
                  '${ref.watch(addFavoriteProvider) ? 'Added' : 'Add'} to favorite',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              gap,
              Text(
                _restaurantEntity!.description,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              gap,
              const Divider(thickness: 3),
              gap,
              Text(
                'Reviews',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              gap,
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _reviewController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      showSnackbarMsg(
                          context: context,
                          targetTitle: 'Empty',
                          targetMessage: 'Review is left empty.',
                          type: ContentType.failure);
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter review here',
                    suffixIcon: IconButton(
                        onPressed: () {
                          _reviewSubmit();
                        },
                        icon: Icon(
                          Icons.send,
                          color: isDark ? Colors.white : Colors.blue,
                        )),
                    hintStyle: Theme.of(context).textTheme.titleSmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              gap,
              gap,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // itemCount: restaurantState.allReviews.length,
                itemCount: _restaurantReviewsList.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                          'assets/images/users/${_restaurantEntity!.reviews![index].userPicture}'),
                    ),
                    title: Text(
                      _restaurantReviewsList[index].userName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      // 'users\' review here',
                      // _restaurantEntity!.reviews![index].text,
                      _restaurantReviewsList[index].text,

                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  );
                }),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
