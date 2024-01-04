import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../router/app_routes.dart';
import 'widget/intro_widget.dart';

class SecondIntroView extends ConsumerStatefulWidget {
  const SecondIntroView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SecondIntroViewState();
}

class _SecondIntroViewState extends ConsumerState<SecondIntroView> {
  int uptoColorfulIndex = 1;
  String imageName = 'secure.png';
  final String message =
      'Your privacy is our top priority as you enjoy the convenience of hassle-free table reservations.';

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, AppRoutes.thirdIntroRoute);
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
