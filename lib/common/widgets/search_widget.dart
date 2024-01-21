import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/is_dark_theme.dart';

class SearchBarWidget extends ConsumerWidget {
  final TextEditingController controller;
  final IconData leadingIcon;
  final String hintText;
  final VoidCallback onPress;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.leadingIcon,
    required this.hintText,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: ref.watch(isDarkThemeProvider) ? Colors.white : Colors.black,
            width: 1,
          )),
      child: Row(
        children: [
          Icon(
            leadingIcon,
            color: Colors.black,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey[800]),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            onPressed: onPress,
            icon: const Icon(Icons.clear),
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
