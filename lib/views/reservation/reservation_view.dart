import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../common/widgets/elevated_button_widget.dart';
import '../../common/widgets/snackbar_message_widget.dart';
import '../../models/restaurant_entity.dart';
import '../../provider/is_dark_theme.dart';
import '../../router/app_routes.dart';
import '../../services/pick_date_time.dart';
import '../../services/user.dart';
import 'widgets/custom_date_picker_widget.dart';
import 'widgets/round_icon_button.dart';

class ReservationView extends ConsumerStatefulWidget {
  const ReservationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReservationViewState();
}

class _ReservationViewState extends ConsumerState<ReservationView> {
  int dinerNum = 1;
  String selectedDate = '';
  String selectedTime = '';
  late bool isDark;

  late RestaurantEntity? _restaurantEntity;

  @override
  void initState() {
    isDark = ref.read(isDarkThemeProvider);

    super.initState();
  }

  String? selectedPlace;

  @override
  void didChangeDependencies() {
    _restaurantEntity =
        ModalRoute.of(context)!.settings.arguments as RestaurantEntity;
    super.didChangeDependencies();
  }

  void _onReservation() {
    if (selectedDate == '' || selectedTime == '') {
      showSnackbarMsg(
        context: context,
        targetTitle: 'Error',
        targetMessage: 'Date and Time cannot be empty.',
        type: ContentType.failure,
      );
      return;
    }

    Alert(
      context: context,
      type: AlertType.info,
      style: AlertStyle(
        isCloseButton: false,
        descStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white),
        titleStyle: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: Colors.white),
      ),
      title: "Information",
      desc:
          "Are you sure want to reserve the table for $dinerNum people on $selectedDate, at $selectedTime ?",
      buttons: [
        DialogButton(
          onPressed: () {
            User.reserveTable(
              restaurantName: _restaurantEntity!.name,
              restaurantPicture: _restaurantEntity!.picture,
              dinerNum: dinerNum,
              pickDate: selectedDate,
              pickTime: selectedTime,
            );

            _resetProviders();

            showSnackbarMsg(
              context: context,
              targetTitle: 'Success',
              targetMessage: 'Reservation successfully',
              type: ContentType.success,
            );

            Navigator.popAndPushNamed(
                context, AppRoutes.reservationSuccessRoute);
          },
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  void _getDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(
          2025), // allow to add today or tomorrow days but not past date
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

  void _resetProviders() {
    setState(() {
      dinerNum = 1;
      selectedDate = '';
      selectedTime = '';
    });
  }

  final verticalGap = const SizedBox(height: 16);
  final horizontalGap = const SizedBox(width: 16);

  @override
  Widget build(BuildContext context) {
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
                  GestureDetector(
                    onTap: _getDatePicker,
                    child: CustomDateTimePickerWidget(
                      // gap: gap,
                      gap: const SizedBox(height: 15),
                      onTap: _getDatePicker,
                      textTitle: 'Pick Date',
                      dateTimeValue: selectedDate,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _getTimePicker,
                    child: CustomDateTimePickerWidget(
                      // gap: gap,
                      gap: const SizedBox(height: 15),
                      onTap: _getTimePicker,
                      textTitle: 'Pick Time',
                      dateTimeValue: selectedTime,
                    ),
                  ),
                ],
              ),
              verticalGap,

              ElevatedButtonWidget(
                buttonLabel: 'Book Table',
                onPress: () {
                  _onReservation();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
