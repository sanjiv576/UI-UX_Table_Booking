import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/bottom_richtext_widget.dart';
import '../../common/widgets/elevated_button_widget.dart';

import '../../common/widgets/reusable_pinput_widget.dart';

class UserVerificationView extends ConsumerStatefulWidget {
  const UserVerificationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserVerificationViewState();
}

class _UserVerificationViewState extends ConsumerState<UserVerificationView> {
  String _fullPin = '';

  int? _correctOTP;
  String? _userRole;

  final _pin1Controller = TextEditingController();
  final _pin2Controller = TextEditingController();
  final _pin3Controller = TextEditingController();
  final _pin4Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _verticalGap = const SizedBox(height: 16);
  final _horizontalGap = const SizedBox(height: 12);

  void _submitPins({required otpPin}) {
    // if (UserVerification.checkOtp(yourOTP: int.parse(otpPin))) {
    //   // print('Move to Dashboard successfully');
    //   showSnackbarMsg(
    //       context: context,
    //       targetTitle: 'Success',
    //       targetMessage: 'Congratulations ! Your account has been created.',
    //       type: ContentType.success);

    //   if (_userRole == 'Restaurant Owner') {
    //     Navigator.popAndPushNamed(context, AppRoute.fillRestaurantDetailsRoute);
    //   } else {
    //
    //   }
    // } else {
    //   String errorMsg =
    //       '$otpPin OTP code does not match. Try Again. Correct OTP code is $_correctOTP';
    //   showSnackbarMsg(
    //       context: context,
    //       targetTitle: 'Error',
    //       targetMessage: errorMsg,
    //       type: ContentType.failure);
    // }

    // _resetFullPin();
    // _resetControllers();
  }

  void _resetFullPin() => _fullPin = '';

  void _resetControllers() {
    _pin1Controller.clear();
    _pin2Controller.clear();
    _pin3Controller.clear();
    _pin4Controller.clear();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   final Map<String, dynamic> arguments =
  //       ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

  //   _correctOTP = int.parse(arguments['correctOTP']!);
  //   _userRole = arguments['userRole'];
  // }

  @override
  void dispose() {
    super.dispose();

    _resetControllers();
    _resetFullPin();

    _pin1Controller.dispose();
    _pin2Controller.dispose();
    _pin3Controller.dispose();
    _pin4Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Verification'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/otp.png'),
                  radius: 100,
                  backgroundColor: Color(0xffd798f7),
                ),
                _verticalGap,
                Text(
                  'Verification',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                _verticalGap,
                Text(
                  'Enter the OTP send to your phone number.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                _verticalGap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusablePinput(
                      controllerName: _pin1Controller,
                      onChangedFunc: (pinValue) {
                        if (pinValue.length == 1) {
                          FocusScope.of(context).nextFocus();
                          _fullPin += pinValue.toString();
                        }
                      },
                    ),
                    ReusablePinput(
                      controllerName: _pin2Controller,
                      onChangedFunc: (pinValue) {
                        if (pinValue.length == 1) {
                          FocusScope.of(context).nextFocus();
                          _fullPin += pinValue.toString();
                        }
                      },
                    ),
                    ReusablePinput(
                      controllerName: _pin3Controller,
                      onChangedFunc: (pinValue) {
                        if (pinValue.length == 1) {
                          FocusScope.of(context).nextFocus();
                          _fullPin += pinValue.toString();
                        }
                      },
                    ),
                    ReusablePinput(
                      controllerName: _pin4Controller,
                      onChangedFunc: (pinValue) {
                        if (pinValue.length == 1) {
                          FocusScope.of(context).nextFocus();
                          _fullPin += pinValue.toString();
                        }
                      },
                    ),
                  ],
                ),
                _verticalGap,
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'OTP expires in 01:57',
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                _verticalGap,
                ElevatedButtonWidget(
                  buttonLabel: 'Verify Me',
                  onPress: () {
                    _submitPins(otpPin: _fullPin);
                  },
                ),
                _verticalGap,
                BottomRichTextWidget(
                    message: "Didn't receive any code ?    ",
                    textButtonName: 'Resend new code',
                    onClick: () {})
              ],
            ),
          ),
        ),
      )),
    );
  }
}
