import 'dart:developer';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../common/widgets/snackbar_message_widget.dart';
import '../loading_screen_view.dart';
import '../../common/widgets/elevated_button_widget.dart';
import '../../common/widgets/text_label_widget.dart';
import '../../common/widgets/textformfield_widget.dart';
import '../../constants/color_constant.dart';
import '../../models/user_entity.dart';
import '../../provider/is_dark_theme.dart';

import '../../services/user.dart';
import '../auth/login_view.dart';
import 'widgets/profile_edit_widget.dart';
import 'widgets/profile_widget.dart';
import 'widgets/stats_widget.dart';

File? _img;

final editProvider = StateProvider<bool>((ref) => false);

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final verticalGap = const SizedBox(height: 16);
  final horizontalGap = const SizedBox(width: 16);
  late UserEntity user;
  late int totalReview;

  late TextEditingController nameController;
  late TextEditingController contactController;
  late TextEditingController emailController;

  final currentPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hidePasswordValue = true;
  bool hideConfirmPasswordValue = true;
  bool hideCurrentPasswordValue = true;

  final passwordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    user = User.currentUser!;
    totalReview = User.getReviewsLength();

    nameController = TextEditingController(text: user.fullName);
    contactController = TextEditingController(text: user.contact);
    emailController = TextEditingController(text: user.email);
    super.initState();
  }

  void _reset() {
    nameController.clear();
    contactController.clear();
    emailController.clear();

    passwordController.clear();
    currentPasswordController.clear();
    confirmPasswordController.clear();
  }

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _updateDetailsBottomSheet() {
    showModalBottomSheet(
        // barrierColor: const Color.fromARGB(255, 104, 102, 102),
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Builder(
            builder: (context) {
              bool isEditing = ref.watch(editProvider);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.white,
                      thickness: 2,
                      endIndent: 140,
                      indent: 140,
                    ),
                    Container(
                      // height: 500,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ref.watch(editProvider.notifier).state =
                                    !ref.watch(editProvider);

                                Navigator.pop(context);
                                _updateDetailsBottomSheet();
                              },
                              child: TextFormFieldWidget(
                                isTextEditable: isEditing,
                                isRequired: false,
                                helperText: 'Full name cannot be empty',
                                controller: nameController,
                                hideValue: false,
                                keyboardType: TextInputType.text,
                                hintTextLable: 'Change name',
                                prefixIconData: FontAwesomeIcons.userCircle,
                                suffixIconButton: IconButton(
                                  onPressed: () {
                                    ref.watch(editProvider.notifier).state =
                                        !ref.watch(editProvider);
                                    if (isEditing) {
                                      var response = User.changeName(
                                          newName: nameController.text.trim());

                                      response.fold((fail) {
                                        Navigator.pop(context);

                                        nameController = TextEditingController(
                                            text: user.fullName);

                                        showSnackbarMsg(
                                            context: context,
                                            targetTitle: 'Error',
                                            targetMessage: fail.error,
                                            type: ContentType.failure);
                                      }, (r) {
                                        Navigator.pop(context);
                                        _updateDetailsBottomSheet();
                                      });
                                    }
                                  },
                                  icon: isEditing
                                      ? const Icon(Icons.send)
                                      : const Icon(Icons.edit),
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            verticalGap,
                            GestureDetector(
                              onTap: () {
                                ref.watch(editProvider.notifier).state =
                                    !ref.watch(editProvider);

                                Navigator.pop(context);
                                _updateDetailsBottomSheet();
                              },
                              child: TextFormFieldWidget(
                                isTextEditable: isEditing,
                                isRequired: false,
                                helperText: 'Contact cannot be empty.',
                                controller: contactController,
                                hideValue: false,
                                keyboardType: TextInputType.text,
                                hintTextLable: 'Change contact',
                                prefixIconData: Icons.call,
                                suffixIconButton: IconButton(
                                  onPressed: () {
                                    ref.watch(editProvider.notifier).state =
                                        !ref.watch(editProvider);

                                    if (isEditing) {
                                      var response = User.changeContact(
                                          newContact:
                                              contactController.text.trim());

                                      response.fold((fail) {
                                        Navigator.pop(context);

                                        contactController =
                                            TextEditingController(
                                                text: user.contact);

                                        showSnackbarMsg(
                                            context: context,
                                            targetTitle: 'Error',
                                            targetMessage: fail.error,
                                            type: ContentType.failure);
                                      }, (r) {
                                        Navigator.pop(context);
                                        _updateDetailsBottomSheet();
                                      });
                                    }
                                  },
                                  icon: isEditing
                                      ? const Icon(Icons.send)
                                      : const Icon(Icons.edit),
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            verticalGap,
                            GestureDetector(
                              onTap: () {
                                ref.watch(editProvider.notifier).state =
                                    !ref.watch(editProvider);

                                Navigator.pop(context);
                                _updateDetailsBottomSheet();
                              },
                              child: TextFormFieldWidget(
                                isTextEditable: isEditing,
                                isRequired: false,
                                helperText: 'Email cannot be empty.',
                                controller: emailController,
                                hideValue: false,
                                keyboardType: TextInputType.emailAddress,
                                hintTextLable: 'Change email',
                                prefixIconData: Icons.mail,
                                suffixIconButton: IconButton(
                                  onPressed: () {
                                    ref.watch(editProvider.notifier).state =
                                        !ref.watch(editProvider);
                                    if (isEditing) {
                                      var response = User.changeEmail(
                                          newEmail:
                                              emailController.text.trim());

                                      response.fold((fail) {
                                        Navigator.pop(context);

                                        emailController = TextEditingController(
                                            text: user.email);

                                        showSnackbarMsg(
                                            context: context,
                                            targetTitle: 'Error',
                                            targetMessage: fail.error,
                                            type: ContentType.failure);
                                      }, (r) {
                                        Navigator.pop(context);
                                        _updateDetailsBottomSheet();
                                      });
                                    }
                                  },
                                  icon: isEditing
                                      ? const Icon(Icons.send)
                                      : const Icon(Icons.edit),
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            verticalGap,
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  void _changePasswordBottomSheet() {
    showModalBottomSheet(
        // barrierColor: const Color.fromARGB(255, 104, 102, 102),
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Builder(
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.white,
                      thickness: 2,
                      endIndent: 140,
                      indent: 140,
                    ),
                    Container(
                      // height: 500,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: passwordFormKey,
                          child: Column(
                            children: [
                              TextLabelWidget(
                                labelName: 'Current Password',
                                horizontalGap: horizontalGap,
                                isRequired: true,
                                tooltipMessage:
                                    'Current password should match.',
                              ),
                              verticalGap,
                              TextFormFieldWidget(
                                isRequired: true,
                                helperText: 'Please, fill current password',
                                controller: currentPasswordController,
                                hideValue: hideCurrentPasswordValue,
                                keyboardType: TextInputType.name,
                                hintTextLable: 'Enter current password',
                                prefixIconData: Icons.lock,
                                suffixIconButton: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hideCurrentPasswordValue =
                                            !hideCurrentPasswordValue;
                                      });
                                      Navigator.pop(context);
                                      _changePasswordBottomSheet();
                                    },
                                    icon: hideCurrentPasswordValue
                                        ? const Icon(
                                            FontAwesomeIcons.eyeSlash,
                                            color: Colors.black,
                                          )
                                        : const Icon(
                                            FontAwesomeIcons.eye,
                                            color: Colors.black,
                                          )),
                              ),
                              verticalGap,
                              TextLabelWidget(
                                labelName: 'New Password',
                                horizontalGap: horizontalGap,
                                isRequired: true,
                                tooltipMessage: 'Set new password.',
                              ),
                              verticalGap,
                              TextFormFieldWidget(
                                isRequired: true,
                                helperText: 'Please, fill new password',
                                controller: passwordController,
                                hideValue: hidePasswordValue,
                                keyboardType: TextInputType.name,
                                hintTextLable: 'Enter new password',
                                prefixIconData: Icons.lock,
                                suffixIconButton: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hidePasswordValue = !hidePasswordValue;
                                      });
                                      Navigator.pop(context);
                                      _changePasswordBottomSheet();
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
                              verticalGap,
                              TextLabelWidget(
                                labelName: 'Confirm Password',
                                horizontalGap: horizontalGap,
                                isRequired: true,
                                tooltipMessage:
                                    'Confirm password is used for ensuring right password set.',
                              ),
                              verticalGap,
                              TextFormFieldWidget(
                                isRequired: true,
                                helperText: 'Please, fill confirm password',
                                controller: confirmPasswordController,
                                hideValue: hideConfirmPasswordValue,
                                keyboardType: TextInputType.name,
                                hintTextLable: 'Enter password again',
                                prefixIconData: Icons.lock,
                                suffixIconButton: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hideConfirmPasswordValue =
                                            !hideConfirmPasswordValue;
                                      });
                                      Navigator.pop(context);
                                      _changePasswordBottomSheet();
                                    },
                                    icon: hideConfirmPasswordValue
                                        ? const Icon(
                                            FontAwesomeIcons.eyeSlash,
                                            color: Colors.black,
                                          )
                                        : const Icon(FontAwesomeIcons.eye,
                                            color: Colors.black)),
                              ),
                              verticalGap,
                              ElevatedButtonWidget(
                                buttonLabel: 'Update',
                                onPress: () {
                                  log('Current pass: ${currentPasswordController.text.trim()}');
                                  log('New pass: ${passwordController.text.trim()}');
                                  log('Confirm pass: ${confirmPasswordController.text.trim()}');
                                  final response = User.changePassword(
                                    currentPassword:
                                        currentPasswordController.text.trim(),
                                    newPassword: passwordController.text.trim(),
                                    confirmPassword:
                                        confirmPasswordController.text.trim(),
                                  );

                                  response.fold((fail) {
                                    Navigator.pop(context);

                                    showSnackbarMsg(
                                      context: context,
                                      targetTitle: 'Error',
                                      targetMessage: fail.error,
                                      type: ContentType.failure,
                                    );
                                    // _changePasswordBottomSheet();
                                  }, (r) {
                                    Navigator.pop(context);

                                    showSnackbarMsg(
                                      context: context,
                                      targetTitle: 'Success',
                                      targetMessage:
                                          'Password updated successfully.',
                                      type: ContentType.success,
                                    );
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  void _modalForCamera() {
    showModalBottomSheet(
      backgroundColor: Colors.grey[300],
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                checkCameraPermission();
                _browseImage(ref, ImageSource.camera);
                Navigator.pop(context);
                // Upload image it is not null
              },
              icon: const Icon(Icons.camera),
              label: const Text('Camera'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _browseImage(ref, ImageSource.gallery);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.image),
              label: const Text('Gallery'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    emailController.dispose();

    passwordController.dispose();
    currentPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
                      User.signOut();

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoadingScreen()),
                          (route) => false);
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
              verticalGap,
              ProfileWidget(
                onPressed: () {
                  _modalForCamera();
                },
                userBackgroundImage: _img != null
                    ? FileImage(_img!) as ImageProvider<Object>
                    : AssetImage('assets/images/users/${user.picture}'),
                radius: 60,
              ),
              verticalGap,
              Text(
                user.fullName,
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
                        statNum: user.reservations.length.toString(),
                        verticalGap: verticalGap,
                        label: 'Reservations'),
                    StatsWidget(
                        statNum: totalReview.toString(),
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
                  onPressed: () => _updateDetailsBottomSheet(),
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
                  onPressed: () => _changePasswordBottomSheet(),
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
