import 'dart:async';
import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../common/widgets/bottom_richtext_widget.dart';
import '../../common/widgets/elevated_button_widget.dart';
import '../../common/widgets/reusable_pinput_widget.dart';
import '../../common/widgets/snackbar_message_widget.dart';
import '../../router/app_routes.dart';
import '../../services/notification.dart';
import '../../services/user.dart';
import '../../services/user_verifcation.dart';

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

  late int _expireTimeInSeconds;
  late Timer _timer;

  final _formKey = GlobalKey<FormState>();

  final _verticalGap = const SizedBox(height: 16);
  final _horizontalGap = const SizedBox(height: 12);

  void _submitPins({required otpPin}) {
    var response = User.verifyUser(otpPin: otpPin);
    response.fold((fail) {
      showSnackbarMsg(
          context: context,
          targetTitle: 'Failed',
          targetMessage: fail.error,
          type: ContentType.failure);
    }, (r) {
      _resetControllers();
      showSnackbarMsg(
          context: context,
          targetTitle: 'Success',
          targetMessage: 'Congratulations ! Your account has been created.',
          type: ContentType.success);

      Navigator.popAndPushNamed(context, AppRoutes.navigationRoute);
    });

    _resetFullPin();
    _resetControllers();
  }

  void _resetFullPin() => _fullPin = '';

  void _resetControllers() {
    _pin1Controller.clear();
    _pin2Controller.clear();
    _pin3Controller.clear();
    _pin4Controller.clear();
  }

  void _resendOtp() {
    _correctOTP = UserVerification.getOtp;
    SendNotification.showSimpleNotifications(
        message: 'New OTP code is: $_correctOTP!', title: 'New OTP Code');

    setState(() {
      _expireTimeInSeconds = 120;
      _startTimer();
    });
    log('Resend correct OTP: $_correctOTP');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _correctOTP = ModalRoute.of(context)?.settings.arguments as int;
    log('Correct OTP: $_correctOTP');
  }

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

  String _formatTimer(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    _expireTimeInSeconds = 120; // 2 mins
    _startTimer();
    SendNotification.checkForNotifications();

    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_expireTimeInSeconds > 0) {
          _expireTimeInSeconds--;
          if (_expireTimeInSeconds == 0) {
            UserVerification.isOTPexpired = true;
          } else {
            UserVerification.isOTPexpired = false;
          }
        } else {
          // Timer expired
          Fluttertoast.showToast(
              msg: 'OTP code is expired. Please, send new code.');
          _timer.cancel();
        }
      });
    });
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
                    'OTP expires in ${_formatTimer(_expireTimeInSeconds)}',
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
                  onClick: _resendOtp,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
