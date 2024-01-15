import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/color_constant.dart';
import '../../models/reservation_entity.dart';
import '../../services/user.dart';

class BookingHistoryView extends ConsumerStatefulWidget {
  const BookingHistoryView({Key? key}) : super(key: key);

  @override
  _BookingHistoryViewState createState() => _BookingHistoryViewState();
}

class _BookingHistoryViewState extends ConsumerState<BookingHistoryView> {
  late List<ReservationEntity> reservations;

  final verticalGap = const SizedBox(height: 4);
  final horizontalGap = const SizedBox(width: 16);

  @override
  void initState() {
    reservations = User.currentUser!.reservations;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: (reservations.length / 2).ceil(),
          itemBuilder: (context, rowIndex) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: buildItem(context, rowIndex, 0),
                    ),
                    horizontalGap,
                    Expanded(
                      child: buildItem(context, rowIndex, 1),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, int rowIndex, int columnIndex) {
    final index = rowIndex * 2 + columnIndex;
    if (index >= reservations.length) {
      return Container(); // Return an empty container for the last row if the items are odd.
    }

    final singleReservation = reservations[index];

    return Container(
      decoration: BoxDecoration(
        color: KColors.light100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/restaurants/${singleReservation.restaurantPicture}',
                  ),
                ),
              ),
            ),
            verticalGap,
            Text(
              singleReservation.restaurantName,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            verticalGap,
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: Colors.black,
                ),
                horizontalGap,
                Text(
                  singleReservation.pickDate,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black),
                ),
              ],
            ),
            verticalGap,
            Row(
              children: [
                const Icon(FontAwesomeIcons.clock, color: Colors.black),
                horizontalGap,
                Text(
                  singleReservation.pickTime,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black),
                ),
              ],
            ),
            verticalGap,
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.userCircle,
                  color: Colors.black,
                ),
                horizontalGap,
                Text(
                  '${singleReservation.guestsNum} People',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black),
                ),
              ],
            ),
            verticalGap,
            Text(
              'Status: ${singleReservation.status}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
