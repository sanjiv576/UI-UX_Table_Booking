import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../services/user_verifcation.dart';
import '../../common/widgets/bottom_richtext_widget.dart';
import '../../models/user.dart';
import '../../router/app_routes.dart';

import '../../common/widgets/elevated_button_widget.dart';
import '../../common/widgets/text_label_widget.dart';
import '../../common/widgets/textformfield_widget.dart';
import '../../services/notification.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  final _verticalGap = const SizedBox(height: 16);
  final _horizontalGap = const SizedBox(width: 12);

  bool hidePasswordValue = true;
  bool hideConfirmPasswordValue = true;

  final _fullNameController = TextEditingController(text: 'Sanjiv Shrestha');
  final _emailController = TextEditingController(text: 'shrestha@gmail.com');
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController(text: 'a');
  final _confirmPasswordController = TextEditingController(text: 'aa');
  final keyboardType = TextInputType.name;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  void _resetControllers() {
    _fullNameController.clear();
    _emailController.clear();
    _contactController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  void _onSignUp() {
    if (_formKey.currentState!.validate()) {
      String name = _fullNameController.text.trim();
      String contact = _contactController.text.trim() ?? 'NA';
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

      UserEntity user =
          UserEntity(fullName: name, email: email, password: password);

      if (confirmPassword != password) {
        log('Passwords do not matcj');
        Fluttertoast.showToast(
          msg: 'Password and Confirm Password must match.',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }

      int otp = UserVerification.getOtp;
      SendNotification.showSimpleNotifications(otp: otp);

      Navigator.pushNamed(context, AppRoutes.userVerificationRoute, arguments:otp );
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextLabelWidget(
                  labelName: 'Full Name',
                  horizontalGap: _horizontalGap,
                  isRequired: true,
                  tooltipMessage:
                      'Full name is used to represent you as a valid user.',
                ),
                _verticalGap,
                TextFormFieldWidget(
                  isRequired: true,
                  helperText: 'Please, fill full name.',
                  controller: _fullNameController,
                  hideValue: false,
                  keyboardType: keyboardType,
                  hintTextLable: 'Enter full name',
                  prefixIconData: Icons.person,
                  suffixIconButton: null,
                ),
                _verticalGap,
                TextLabelWidget(
                  labelName: 'Contact',
                  horizontalGap: _horizontalGap,
                  isRequired: false,
                  tooltipMessage: 'Contact is an optional.',
                ),
                _verticalGap,
                TextFormFieldWidget(
                  isRequired: false,
                  helperText: 'Contact can be empty.',
                  controller: _contactController,
                  hideValue: false,
                  keyboardType: TextInputType.phone,
                  hintTextLable: 'Enter phone number',
                  prefixIconData: Icons.call,
                  suffixIconButton: null,
                ),
                _verticalGap,
                TextLabelWidget(
                  labelName: 'Email',
                  horizontalGap: _horizontalGap,
                  isRequired: true,
                  tooltipMessage: 'Email is used for authentication.',
                ),
                _verticalGap,
                TextFormFieldWidget(
                  isRequired: true,
                  helperText: 'Please, fill email',
                  controller: _emailController,
                  hideValue: false,
                  keyboardType: TextInputType.emailAddress,
                  hintTextLable: 'Enter email',
                  prefixIconData: Icons.mail,
                  suffixIconButton: null,
                ),
                _verticalGap,
                TextLabelWidget(
                  labelName: 'Password',
                  horizontalGap: _horizontalGap,
                  isRequired: true,
                  tooltipMessage: 'Password is required to authenticate.',
                ),
                _verticalGap,
                TextFormFieldWidget(
                  isRequired: true,
                  helperText: 'Please, fill password',
                  controller: _passwordController,
                  hideValue: hidePasswordValue,
                  keyboardType: keyboardType,
                  hintTextLable: 'Enter password',
                  prefixIconData: Icons.lock,
                  suffixIconButton: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePasswordValue = !hidePasswordValue;
                        });
                      },
                      icon: hidePasswordValue
                          ? const Icon(
                              FontAwesomeIcons.eyeSlash,
                              color: Colors.black,
                            )
                          : const Icon(
                              FontAwesomeIcons.eye,
                              color: Colors.black,
                            )),
                ),
                _verticalGap,
                TextLabelWidget(
                  labelName: 'Confirm Password',
                  horizontalGap: _horizontalGap,
                  isRequired: true,
                  tooltipMessage:
                      'Confirm password is used for ensuring right password set.',
                ),
                _verticalGap,
                TextFormFieldWidget(
                  isRequired: true,
                  helperText: 'Please, fill confirm password',
                  controller: _confirmPasswordController,
                  hideValue: hideConfirmPasswordValue,
                  keyboardType: keyboardType,
                  hintTextLable: 'Enter password again',
                  prefixIconData: Icons.lock,
                  suffixIconButton: IconButton(
                      onPressed: () {
                        setState(() {
                          hideConfirmPasswordValue = !hideConfirmPasswordValue;
                        });
                      },
                      icon: hideConfirmPasswordValue
                          ? const Icon(
                              FontAwesomeIcons.eyeSlash,
                              color: Colors.black,
                            )
                          : const Icon(FontAwesomeIcons.eye,
                              color: Colors.black)),
                ),
                _verticalGap,
                ElevatedButtonWidget(
                  buttonLabel: 'Sign Up',
                  onPress: _onSignUp,
                ),
                _verticalGap,
                BottomRichTextWidget(
                  message: 'Already a member ?   ',
                  textButtonName: 'Login Now',
                  onClick: () {
                    _resetControllers();
                    Navigator.pushNamed(context, AppRoutes.loginRoute);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
