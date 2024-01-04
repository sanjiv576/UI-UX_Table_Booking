import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_booking/router/app_routes.dart';
import '../../common/widgets/bottom_richtext_widget.dart';

import '../../common/widgets/outline_button_widget.dart';
import 'widget/intro_widget.dart';

class ThirdIntroScreen extends ConsumerStatefulWidget {
  const ThirdIntroScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ThirdIntroScreenState();
}

class _ThirdIntroScreenState extends ConsumerState<ThirdIntroScreen> {
  int uptoColorfulIndex = 2;
  String imageName = 'join-us.png';
  final String message =
      'Sign up or log in now to elevate your dining experience and unlock a world of convenience at your favorite restaurants!';

  final _verticalGap = const SizedBox(height: 40);

  void func() {
    log('Outline button is Clicked');
    Navigator.pushNamed(context, AppRoutes.signupRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              IntroWidget(
                imageName: imageName,
                message: message,
                uptoColorfulIndex: uptoColorfulIndex,
              ),
              _verticalGap,
              OutlineButtonWidget(
                onPress: func,
                buttonName: 'Create an account',
              ),
              _verticalGap,
              BottomRichTextWidget(
                message: 'Already a member ?   ',
                textButtonName: 'Login Now',
                onClick: () {
                  Navigator.pushNamed(context, AppRoutes.loginRoute);
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
