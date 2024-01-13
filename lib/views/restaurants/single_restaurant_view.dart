import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/widgets/snackbar_message_widget.dart';
import '../../models/restaurant_entity.dart';
import '../../models/review_entity.dart';
import '../../provider/is_dark_theme.dart';
import 'widgets/custom_detect_card_widget.dart';
import 'widgets/custom_tilelist_widget.dart';


final addFavoriteProvider = StateProvider<bool>((ref) => false);

class RestaurantView extends ConsumerStatefulWidget {
  const RestaurantView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends ConsumerState<RestaurantView> {
  SizedBox gap = const SizedBox(height: 10);
  final _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RestaurantEntity? _restaurantEntity;
  late bool isDark;
  // late Color activeTextColor;
  bool _isFavoriteRestaurant = false;

  late List<ReviewEntity> _restaurantReviewsList;
  late String _favoriteId;

  // void _isFavorite() {
  //   // check whether this restaurant is favorite or not
  //   for (var sinlgeFavorite in _restaurantEntity!.favorite!) {
  //     if (sinlgeFavorite.userId == AuthState.userEntity!.id) {
  //       setState(() {
  //         _isFavoriteRestaurant = true;
  //       });
  //       _favoriteId = sinlgeFavorite.favoriteId!;
  //       break;
  //     }
  //   }
  // }

  @override
  void didChangeDependencies() {
    _restaurantEntity =
        ModalRoute.of(context)!.settings.arguments as RestaurantEntity?;

    isDark = ref.read(isDarkThemeProvider);
    // activeTextColor = isDark
    //     ? AppColorConstant.nightTextColor
    //     : AppColorConstant.dayTextColor;


    _restaurantReviewsList = _restaurantEntity!.reviews!;



    // _isFavorite();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _reviewController.dispose();
  }

  // void _handleFavorite() {
  //   if (_isFavoriteRestaurant) {
  //     setState(() {
  //       _isFavoriteRestaurant = false;
  //     });

  //     // remove as favorite
  //     ref.watch(restaurantViewModelProvider.notifier).deleteFavoriteRestaurant(
  //         restaurantId: _restaurantEntity!.restaurantId!,
  //         favoriteId: _favoriteId);

  //     // remove from the favorite list as well
  //     setState(() {
  //       _restaurantEntity!.favorite!.removeWhere((singleFavorite) =>
  //           singleFavorite.userId == AuthState.userEntity!.id);
  //     });
  //   } else {
  //     setState(() {
  //       _isFavoriteRestaurant = true;
  //     });

  //     // add as favorite
  //     ref.watch(restaurantViewModelProvider.notifier).addFavoriteRestaurant(
  //         restaurantId: _restaurantEntity!.restaurantId!);

  //     FavoriteEntity favoriteEntity = FavoriteEntity(
  //       userId: AuthState.userEntity!.id ?? '343dffd34dfdf',
  //       restaurantName: _restaurantEntity!.name,
  //       userName: AuthState.userEntity!.fullName,
  //     );
  //     // add to the favorite list
  //     setState(() {
  //       _restaurantEntity!.favorite!.add(favoriteEntity);
  //     });
  //   }
  // }

  // void _reviewSubmit() {
  //   if (_formKey.currentState!.validate()) {
  //     ReviewEntity newReview = ReviewEntity(
  //       text: _reviewController.text.trim(),
  //       rating: 3,
  //       // Note: below fields are inserted by server automatically
  //       userName: AuthState.userEntity!.fullName,
  //       userId: 'asdf',
  //       userPicture: AuthState.userEntity!.picture.toString(),
  //       restaurantId: '',
  //     );
  //     ref
  //         .watch(reviewsViewModelProvider.notifier)
  //         .addReview(review: newReview, restaurant: _restaurantEntity!);

  //     setState(() {
  //       _restaurantReviewsList.insert(0, newReview);
  //     });
  //     _reviewController.clear();
  //   }
  // }

  _callNow() async {
    String contact = _restaurantEntity!.contact;
    await FlutterPhoneDirectCaller.callNumber(contact);
  }

  @override
  Widget build(BuildContext context) {
    // final restaurantState = ref.read(reviewsViewModelProvider);
    // _restaurantReviewsList = restaurantState.allReviews;

    _restaurantReviewsList = _restaurantEntity!.reviews!;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://hips.hearstapps.com/housebeautiful.cdnds.net/17/42/2048x1024/landscape-1508239345-family-eating-lunch-close-up-of-food-on-wooden-table.jpg?resize=1200:*',
               
              ),
              gap,
              Text(
                _restaurantEntity!.name,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold
                )
              ),
              gap,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Wrap(
                            children: [
                              Icon(Icons.star, color: Colors.red),
                              Icon(Icons.star, color: Colors.red),
                              Icon(Icons.star, color: Colors.red),
                              Icon(Icons.star_half, color: Colors.red),
                            ],
                          ),
                        ),
                        CustomListTileWidget(
                          iconData: FontAwesomeIcons.locationDot,
                          text: _restaurantEntity!.location.toString(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomListTileWidget(
                            text:
                                // '${restaurantState.allReviews.length} Reviews',
                                '${_restaurantReviewsList.length} Reviews',
                            iconData: Icons.restaurant_menu),
                        CustomListTileWidget(
                            // text: '9812345678',
                            text: _restaurantEntity!.contact.toString(),
                            iconData: FontAwesomeIcons.phone),
                      ],
                    ),
                  ),
                ],
              ),
              gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomDetectCardWidget(
                    text: 'Reserve Table',
                    iconData: Icons.table_bar,
                    onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   AppRoute.customerReservationRoute,
                      //   arguments: _restaurantEntity,
                      // );

                      // Navigator.pushNamed(
                      //     context, AppRoute.customerReservationRoute,
                      //     arguments: {
                      //       'reservation': null,
                      //       'restaurant': _restaurantEntity,
                      //     });
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
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: _isFavoriteRestaurant ? Colors.pink : Colors.white,
                    size: 40,
                  ),
                ),
                title: Text(
                  '${_isFavoriteRestaurant ? 'Added' : 'Add'} to favorite',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                  
                ),
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
                    hintText: 'Leave a review',
                    suffixIcon: IconButton(
                        onPressed: () {
                          // _reviewSubmit();
                        },
                        icon: Icon(
                          Icons.send,
                          color: isDark ? Colors.white : Colors.blue,
                        )),
                    hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontStyle: FontStyle.italic),
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
                      backgroundImage: NetworkImage(
                        'https://previews.123rf.com/images/triken/triken1608/triken160800028/61320729-male-avatar-profile-picture-default-user-avatar-guest-avatar-simply-human-head-vector.jpg',
                        // ApiEndpoints.imageUrl +
                        //     // _restaurantEntity!.reviews![index].userPicture,
                        //     _restaurantReviewsList[index].userPicture,
                      ),
                    ),
                    title: Text(
                      // 'User full name',
                      // _restaurantEntity!.reviews![index].userName,
                      _restaurantReviewsList[index].userName,
                     style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      // 'users\' review here',
                      // _restaurantEntity!.reviews![index].text,
                      _restaurantReviewsList[index].text,

                     style: Theme.of(context).textTheme.titleMedium,
                    
                    ),
                    // trailing: Wrap(
                    //   direction: Axis.horizontal,
                    //   children: [
                    //     _restaurantEntity!.reviews![index].userId ==
                    //             AuthState.userEntity!.id
                    //         ? IconButton(
                    //             onPressed: () {},
                    //             icon: const Icon(Icons.edit),
                    //           )
                    //         : Container(
                    //             child: null,
                    //           )
                    //   ],
                    // ),
                  );
                }),
              ),
            ],
          ),
        ]),
      )),
    );
  }
}
