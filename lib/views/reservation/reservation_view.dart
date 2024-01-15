import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../router/app_routes.dart';
import '../../common/widgets/elevated_button_widget.dart';

import '../../models/restaurant_entity.dart';
import '../../provider/is_dark_theme.dart';
import '../../services/pick_date_time.dart';
import 'widgets/custom_date_picker_widget.dart';
import 'widgets/round_icon_button.dart';

class ReservationView extends ConsumerStatefulWidget {
  const ReservationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReservationViewState();
}

class _ReservationViewState extends ConsumerState<ReservationView> {
  bool edit = false;
  int dinerNum = 1;
  String selectedDate = '';
  String selectedTime = '';
  bool outdoorSelected = false;
  bool indoorSelected = false;
  late bool isDark;
  // late Color activeTextColor;

  late RestaurantEntity? _restaurantEntity;
  // ReservationEntity? _reservationEntity;
  Map<dynamic, dynamic>? arguments;

  @override
  void initState() {
    isDark = ref.read(isDarkThemeProvider);
    // activeTextColor = isDark
    //     ? AppColorConstant.nightTextColor
    //     : AppColorConstant.dayTextColor;
    super.initState();
  }

  String? selectedPlace;

  @override
  void didChangeDependencies() {
    _restaurantEntity =
        ModalRoute.of(context)!.settings.arguments as RestaurantEntity;
    super.didChangeDependencies();
  }

  // void _submitReservation() {
  //   ReservationEntity newReservation = ReservationEntity(
  //     date: selectedDate,
  //     time: selectedTime,
  //     numberOfDinners: dinerNum,
  //     dinnerPlace: selectedPlace.toString(),
  //     isCancelled: false,
  //     isModifiedData: false,
  //     isFoodOrder: false,
  //     restaurantName:
  //         _restaurantEntity != null ? _restaurantEntity!.name : 'NA',
  //     userId: '1',
  //   );

  //   ref.watch(reservationViewModelProvider.notifier).createReservation(
  //       newReservation, _restaurantEntity!.restaurantId!, context);
  //   showSnackbarMsg(
  //     context: context,
  //     targetTitle: 'Success',
  //     targetMessage: 'Reservation successfully',
  //     type: ContentType.success,
  //   );

  //   Map<String, String> reservationDetailsMap = {
  //     'dinerNum': dinerNum.toString(),
  //     'time': selectedTime.toString(),
  //     'date': selectedDate.toString(),
  //     'place': selectedPlace.toString().toLowerCase(),
  //   };
  //   _resetProviders();
  //   Navigator.popAndPushNamed(context, AppRoute.customerConfirmationViewRoute,
  //       arguments: reservationDetailsMap);
  // }

  // void _submitEditReservation() {
  //   ReservationEntity editedReservation = ReservationEntity(
  //     date: selectedDate,
  //     time: selectedTime,
  //     numberOfDinners: dinerNum,
  //     dinnerPlace: selectedPlace.toString(),
  //     isCancelled: false,
  //     isModifiedData: false,
  //     isFoodOrder: false,
  //     restaurantName: '',
  //     userId: '1',
  //     reservationId: '1',
  //   );

// // call update reservation from viewmodel
//     ref.watch(reservationViewModelProvider.notifier).updateReservation(
//         editedReservation, _reservationEntity!.reservationId!, context);

//     _resetProviders();
//   }

  void _getDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(
          2026), // allow to add today or tomorrow days but not past date
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        selectedDate = PickDateTime.convertDate(date: pickedDate);
      });
    });
  }

//  function that allows to pick time from UI
  void _getTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) return;

      setState(() {
        selectedTime = PickDateTime.convertTime(time: pickedTime);
      });
    });
  }

  // void _reservationSubmit() {
  //   if ((indoorSelected || outdoorSelected)) {
  //     selectedPlace = indoorSelected ? 'Indoor' : 'Outdoor';

  //     String textMessage = 'Do you sure want to reserve table ?';

  //     showMyDialogBox(textMessage, () {
  //       _submitReservation();
  //     }, context);
  //   } else {
  //     showSnackbarMsg(
  //       context: context,
  //       targetTitle: 'Missing',
  //       targetMessage: 'Something is missing date, time or dinner place.',
  //       type: ContentType.failure,
  //     );
  //   }
  // }

  // void _editSubmit() {
  //   if ((indoorSelected || outdoorSelected)) {
  //     selectedPlace = indoorSelected ? 'Indoor' : 'Outdoor';

  //     // print('Diner number: $_dinerNum\nDate: ${_selectedDate!}\nTime: ${_selectedTime!}\nPlaceType: $selectedPlace');
  //     String textMessage = 'Do you sure want to reserve table ?';

  //     showMyDialogBox(textMessage, () {
  //       _submitEditReservation();
  //     }, context);
  //   } else {
  //     showSnackbarMsg(
  //       context: context,
  //       targetTitle: 'Missing',
  //       targetMessage: 'Something is missing date, time or dinner place.',
  //       type: ContentType.failure,
  //     );
  //   }
  // }

  String url =
      'https://hips.hearstapps.com/housebeautiful.cdnds.net/17/42/2048x1024/landscape-1508239345-family-eating-lunch-close-up-of-food-on-wooden-table.jpg?resize=1200:*';

  void _resetProviders() {
    setState(() {
      dinerNum = 1;
      outdoorSelected = false;
      indoorSelected = false;
      selectedDate = '';
      selectedTime = '';
      edit = false;
    });
  }

  final verticalGap = const SizedBox(height: 16);
  final horizontalGap = const SizedBox(width: 16);

  @override
  Widget build(BuildContext context) {
    // final reservationState = ref.watch(reservationViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Now'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ListTile(
              //   contentPadding: const EdgeInsets.all(0),
              //   leading: CircleAvatar(
              //     radius: 50,
              //     backgroundImage: NetworkImage(
              //       url,
              //       // _restaurantEntity != null
              //       //     ? ApiEndpoints.imageUrl + _restaurantEntity!.picture!
              //       //     : url,
              //     ),
              //     backgroundColor: Colors.white,
              //   ),
              //   title: Text(_restaurantEntity!.name
              //       // _restaurantEntity != null
              //       //     ? _restaurantEntity!.name
              //       //     : _reservationEntity!.restaurantName,
              //       // style: kBoldPoppinsTextStyle.copyWith(
              //       //     fontSize: 20, color: activeTextColor),
              //       ),
              //   trailing: IconButton(
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //     icon: const Icon(
              //       Icons.clear,
              //       // color: activeTextColor,
              //     ),
              //   ),
              // ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/images/restaurants/${_restaurantEntity!.picture}'),
                  ),
                  horizontalGap,
                  Text(
                    _restaurantEntity!.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
              verticalGap,
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/reservations/$dinerNum.png',
                  fit: BoxFit.cover,
                ),
              ),
              verticalGap,
              Text(
                'Pick number of Guests',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              verticalGap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        dinerNum.toString(),
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      horizontalGap,
                      Text(
                        'people',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: [
                      RoundIconButton(
                        icon: FontAwesomeIcons.minus,
                        onPressedCustom: dinerNum > 1
                            ? () {
                                setState(() {
                                  dinerNum--;
                                });
                              }
                            : null,
                      ),
                      const SizedBox(width: 15),
                      RoundIconButton(
                        icon: FontAwesomeIcons.plus,
                        onPressedCustom: dinerNum < 6
                            ? () {
                                setState(() {
                                  dinerNum++;
                                });
                              }
                            : null,
                      )
                    ],
                  ),
                ],
              ),
              // gap,
              const SizedBox(height: 15),

              Row(
                children: [
                  CustomDateTimePickerWidget(
                    // gap: gap,
                    gap: const SizedBox(height: 15),
                    onTap: _getDatePicker,
                    textTitle: 'Pick Date',
                    dateTimeValue: selectedDate,
                  ),
                  const Spacer(),
                  CustomDateTimePickerWidget(
                    // gap: gap,
                    gap: const SizedBox(height: 15),
                    onTap: _getTimePicker,
                    textTitle: 'Pick Time',
                    dateTimeValue: selectedTime,
                  ),
                ],
              ),
              verticalGap,

              ElevatedButtonWidget(
                  buttonLabel: 'Book Table',
                  onPress: () {
                    Navigator.popAndPushNamed(
                        context, AppRoutes.reservationSuccessRoute);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
