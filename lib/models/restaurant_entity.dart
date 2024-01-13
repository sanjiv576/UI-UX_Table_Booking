import 'review_entity.dart';

class RestaurantEntity {
  final String restaurantId;
  final String name;
  final String location;
  final String status;
  final String? offer;
  final String picture;
  final String bookingTime;
  final String rating;
  final String contact;
  final List<ReviewEntity>? reviews;

  RestaurantEntity({
    required this.restaurantId,
    required this.name,
    required this.location,
    required this.status,
    required this.picture,
    required this.bookingTime,
    required this.rating,
    required this.contact,
    this.offer,
    this.reviews,
  });

  @override
  String toString() {
    return 'restaurantId: $restaurantId, name: $name, picture: $picture, reviews: $reviews';
  }
}
