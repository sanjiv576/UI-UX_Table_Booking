import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_booking/constants/color_constant.dart';
import 'package:table_booking/services/user_verifcation.dart';
import 'package:table_booking/views/auth/login_view.dart';
import 'package:table_booking/views/auth/signup_view.dart';
import 'package:table_booking/views/auth/user_verification_view.dart';

import 'nav_bar/home_view.dart';
import 'singel_product_view.dart';

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
    const LoginView(),
    const SignupView(),
    const UserVerificationView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: NavigationBar(
      //   indicatorColor: Colors.white,
      //   selectedIndex: ref.watch(selectedIndexProvider),
      //   onDestinationSelected: _onTapItem,
      //   backgroundColor: KColors.rose900,
      //   destinations: const [
      //     NavigationDestination(
      //         icon: Icon(
      //           Icons.home,
      //           color: Colors.white,
      //         ),
      //         label: 'Home'),
      //     NavigationDestination(icon: Icon(Icons.person), label: 'b'),
      //     NavigationDestination(icon: Icon(Icons.lock), label: 'c'),
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: ref.watch(selectedIndexProvider),
        selectedItemColor: Colors.yellow,

        // selectedIconTheme: const IconThemeData(color: Colors.black),
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
