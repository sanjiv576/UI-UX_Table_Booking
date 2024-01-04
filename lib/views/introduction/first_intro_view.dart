import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/color_constant.dart';
import '../../router/app_routes.dart';

import 'widget/intro_widget.dart';

class FirstIntroView extends ConsumerStatefulWidget {
  const FirstIntroView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FirstIntroViewState();
}

class _FirstIntroViewState extends ConsumerState<FirstIntroView> {
  int uptoColorfulIndex = 0;
  String imageName = 'dinning.png';
  final String message =
      'Welcome to our Table Reservation System! Say goodbye to waiting in lines and hello to seamless dining experiences. ';

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, AppRoutes.secondIntroRoute);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IntroWidget(
            imageName: imageName,
            message: message,
            uptoColorfulIndex: uptoColorfulIndex,
          ),
        ),
      )),
    );
  }
}
