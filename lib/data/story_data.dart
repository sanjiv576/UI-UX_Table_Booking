import '../models/story_entity.dart';

class StoryData {
  StoryData._();

  static List<StoryEntity> stories = [
    StoryEntity(id: '6', picture: '6.jpg', restaurantName: 'Nepali Kitchen'),
    StoryEntity(id: '1', picture: '1.jpg', restaurantName: 'Bhojan Griha'),
    StoryEntity(id: '3', picture: '3.jpg', restaurantName: 'Himalayan Delight'),
    StoryEntity(id: '4', picture: '4.jpg', restaurantName: 'Kathmandu Fusion'),
    StoryEntity(id: '5', picture: '5.jpg', restaurantName: 'Yak & Yeti Dining'),
    StoryEntity(
        id: '2', picture: '2.jpg', restaurantName: 'Mount Everest Cafe'),
  ];
}
