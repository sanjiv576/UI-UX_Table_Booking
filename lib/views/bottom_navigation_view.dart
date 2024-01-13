import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/color_constant.dart';
import 'nav_bar/booking_history_view.dart';
import 'nav_bar/home_view.dart';
import 'nav_bar/profile_view.dart';
import 'nav_bar/search_view.dart';

// select index as the user clicks
final selectedIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavigationView extends ConsumerStatefulWidget {
  const BottomNavigationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomNavigationViewState();
}

class _BottomNavigationViewState extends ConsumerState<BottomNavigationView> {
  void _onTapItem(int index) {
    ref.watch(selectedIndexProvider.notifier).state = index;
  }

  final List<Widget> _screens = [
    const HomeView(),
    const SearchView(),
    const BookingHistoryView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: ref.watch(selectedIndexProvider),
        selectedItemColor: Colors.white,
        elevation: 2,
        selectedIconTheme: const IconThemeData(color: Colors.yellow),
        unselectedItemColor: Colors.white,
        backgroundColor: KColors.rose900,
        onTap: _onTapItem,
      ),
      body: _screens.elementAt(
        ref.watch(selectedIndexProvider),
      ),
    );
  }
}
