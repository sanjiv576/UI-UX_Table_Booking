import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextFormFieldWidget extends ConsumerWidget {
  const TextFormFieldWidget({
    super.key,
    required this.isRequired,
    required this.helperText,
    required this.controller,
    required this.hideValue,
    required this.keyboardType,
    required this.hintTextLable,
    required this.prefixIconData,
    required this.suffixIconButton,
    this.isTextEditable,
  });

  final bool isRequired;
  final String helperText;
  final TextEditingController controller;
  final bool hideValue;
  final TextInputType keyboardType;
  final String hintTextLable;
  final IconData prefixIconData;
  final IconButton? suffixIconButton;
  final bool? isTextEditable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      validator: (value) {
        if (isRequired && value!.isEmpty) {
          return '⚠️ $helperText';
        }
        return null;
      },
      enabled: isTextEditable ?? true,
      style: const TextStyle(color: Colors.black),
      controller: controller,
      obscureText: hideValue,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintTextLable,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.grey[800]),
        prefixIcon: Icon(
          prefixIconData,
          color: Colors.black,
        ),
        suffixIcon: suffixIconButton,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
