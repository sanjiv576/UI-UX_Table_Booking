import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/widgets/bottom_richtext_widget.dart';
import '../../common/widgets/elevated_button_widget.dart';
import '../../common/widgets/text_label_widget.dart';
import '../../common/widgets/textformfield_widget.dart';
import '../../router/app_routes.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _verticalGap = const SizedBox(height: 16);
  final _horizontalGap = const SizedBox(width: 12);

  bool hidePasswordValue = true;

  final _emailController = TextEditingController(text: 'shrestha@gmail.com');
  final _passwordController = TextEditingController(text: 'a');
  final keyboardType = TextInputType.name;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _resetControllers() {
    _emailController.clear();
    _passwordController.clear();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      log('Email: $email, Password: $password');

      Navigator.pushNamed(context, AppRoutes.navigationRoute);
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 299,
                  child: Image.asset('assets/images/login.png'),
                ),
                _verticalGap,
                TextLabelWidget(
                  showInfoIcon: false,
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
                  showInfoIcon: false,
                  labelName: 'Password',
                  horizontalGap: _horizontalGap,
                  isRequired: true,
                  tooltipMessage: 'Password is required for authentication.',
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
                _verticalGap,
                ElevatedButtonWidget(
                  buttonLabel: 'Login',
                  onPress: _onLogin,
                ),
                _verticalGap,
                BottomRichTextWidget(
                  message: "Don't have an account ?    ",
                  textButtonName: 'Sign Up',
                  onClick: () {
                    _resetControllers();
                    Navigator.pushNamed(context, AppRoutes.signupRoute);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
