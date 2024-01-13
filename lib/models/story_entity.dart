class StoryEntity {
  final String id;
  final String picture;
  final String restaurantName;

  StoryEntity({
    required this.id,
    required this.picture,
    required this.restaurantName,
  });

  @override
  String toString() {
    return 'id: $id, story picture: $picture, restaurant: $restaurantName';
  }
}
