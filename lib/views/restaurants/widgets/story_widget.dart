import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../models/story_entity.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({
    super.key,
    required this.stories,
    required SizedBox verticalGap,
    required SizedBox horizontalGap,
  })  : _verticalGap = verticalGap,
        _horizontalGap = horizontalGap;

  final List<StoryEntity> stories;
  final SizedBox _verticalGap;
  final SizedBox _horizontalGap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < stories.length; i++) ...{
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  log('Tap ${stories[i].restaurantName}');
                },
                onDoubleTap: () {
                  log('Double tap ${stories[i].restaurantName}');
                },
                child: Container(
                  height: 178,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/stories/${stories[i].picture}',
                      ),
                    ),
                  ),
                ),
              ),
              _verticalGap,
              Text(stories[i].restaurantName)
            ],
          ),
          _horizontalGap,
        }
      ],
    );
  }
}
