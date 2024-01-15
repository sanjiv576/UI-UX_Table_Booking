import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_booking/constants/color_constant.dart';
import 'package:table_booking/provider/is_dark_theme.dart';

import '../auth/login_view.dart';
import 'widgets/profile_edit_widget.dart';
import 'widgets/profile_widget.dart';
import 'widgets/stats_widget.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final verticalGap = const SizedBox(height: 16);
  String statNum = '3';
  String label = 'Reserv';
  @override
  Widget build(BuildContext context) {
    bool darkThemeValue = ref.watch(isDarkThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Logout',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()),
                          (route) => false);
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
              verticalGap,
              ProfileWidget(
                onPressed: () {},
                userBackgroundImage:
                    const AssetImage('assets/images/default_user.png'),
                radius: 60,
              ),
              verticalGap,
              Text(
                'Sanjiv Shrestha',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              verticalGap,
              Container(
                decoration: BoxDecoration(
                  color: KColors.rose100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatsWidget(
                        statNum: '7',
                        verticalGap: verticalGap,
                        label: 'Reservations'),
                    StatsWidget(
                        statNum: '3',
                        verticalGap: verticalGap,
                        label: 'Reviews'),
                  ],
                ),
              ),
              verticalGap,
              ProfileEditWidget(
                label: 'Update Details',
                leadingIconData: Icons.edit,
                trailingWidget: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
              verticalGap,
              ProfileEditWidget(
                label: 'Change Password',
                leadingIconData: Icons.lock,
                trailingWidget: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
              verticalGap,
              ProfileEditWidget(
                  label: 'Dark Theme',
                  trailingWidget: Switch(
                      value: darkThemeValue,
                      onChanged: (value) {
                        setState(() {
                          // update the theme
                          ref
                              .watch(isDarkThemeProvider.notifier)
                              .updateTheme(value);

                          darkThemeValue = value;

                          log('Print : $darkThemeValue');
                        });
                      }),
                  leadingIconData: Icons.palette)
            ],
          ),
        ),
      ),
    );
  }
}
