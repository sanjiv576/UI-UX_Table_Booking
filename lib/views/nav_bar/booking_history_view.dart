import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingHistoryView extends ConsumerStatefulWidget {
  const BookingHistoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BookingHistoryViewState();
}

class _BookingHistoryViewState extends ConsumerState<BookingHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
    );
  }
}
