import '../models/restaurant_entity.dart';
import '../models/review_entity.dart';

class RestaurantData {
  RestaurantData._();

  static List<RestaurantEntity> restaurants = [
    RestaurantEntity(
      restaurantId: 1.toString(),
      name: 'Bhojan Griha',
      location: 'New Road, Kathmandu',
      status: 'Open',
      picture: '4.jpg',
      bookingTime: '7 am - 11 pm',
      rating: '5.0',
      contact: '98123345678',
      reviews: [
        ReviewEntity(
          reviewId: '1',
          text: 'Good restaurant.',
          userId: '1',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
        ReviewEntity(
          reviewId: '2',
          text: 'I love this Mo:Mo food here..',
          userId: '2',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
        ReviewEntity(
          reviewId: '3',
          text: 'Excellent service and ambiance!',
          userId: '3',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
      ],
    ),
    RestaurantEntity(
      restaurantId: 2.toString(),
      name: 'Himalayan Java Coffee',
      location: 'Putalisadak, Kathmandu',
      status: 'Open',
      picture: '3.jpg',
      bookingTime: '8 am - 10 pm',
      rating: '3.1',
      contact: '9876487623',
      reviews: [
        ReviewEntity(
          reviewId: '1',
          text: 'Delicious Indian cuisine!',
          userId: '4',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
        ReviewEntity(
          reviewId: '2',
          text: 'Great ambiance and friendly staff!',
          userId: '3',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
        ReviewEntity(
          reviewId: '3',
          text: 'Highly recommended!',
          userId: '1',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
      ],
    ),
    RestaurantEntity(
      restaurantId: 3.toString(),
      name: 'Mount Everest Cafe',
      location: 'Thamel, Kathmandu',
      status: 'Open',
      picture: '1.jpg',
      bookingTime: '6 am - 12 am',
      rating: '4.2',
      contact: '9856437864',
      reviews: [
        ReviewEntity(
          reviewId: '1',
          text: 'Scenic view and tasty food!',
          userId: '2',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
        ReviewEntity(
          reviewId: '2',
          text: 'Cozy atmosphere!',
          userId: '1',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
        ReviewEntity(
          reviewId: '3',
          text: 'Lovely place!',
          userId: '3',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
      ],
    ),
    RestaurantEntity(
      restaurantId: 4.toString(),
      name: 'Nepali Kitchen',
      location: 'Jhamsikhel, Lalitpur',
      status: 'Open',
      picture: '2.jpg',
      bookingTime: '10 am - 8 pm',
      rating: '4.8',
      contact: '9878659856',
      reviews: [],
    ),
    RestaurantEntity(
      restaurantId: 5.toString(),
      name: 'Pashupatinath Eats',
      location: 'Pashupati Road, Kathmandu',
      status: 'Open',
      picture: '5.jpg',
      bookingTime: '6 am - 11 pm',
      rating: '4.7',
      contact: '9823546674',
      reviews: [],
    ),
    RestaurantEntity(
      restaurantId: 6.toString(),
      name: 'Himalayan Delight',
      location: 'Boudha, Kathmandu',
      status: 'Open',
      picture: '6.jpg',
      bookingTime: '11 am - 9 pm',
      rating: '4.4',
      contact: '9878643543',
      reviews: [
        ReviewEntity(
          reviewId: '1',
          text: 'Scenic view and tasty food!',
          userId: '2',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
        ReviewEntity(
          reviewId: '2',
          text: 'Cozy atmosphere!',
          userId: '1',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
        ReviewEntity(
          reviewId: '3',
          text: 'Lovely place!',
          userId: '3',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
      ],
    ),
    RestaurantEntity(
      restaurantId: 7.toString(),
      name: 'Kathmandu Fusion',
      location: 'Durbarmarg, Kathmandu',
      status: 'Open',
      picture: '7.jpg',
      bookingTime: '12 pm - 10 pm',
      rating: '4.6',
      contact: '9800876565',
      reviews: [
        ReviewEntity(
          reviewId: '1',
          text: 'Delicious Indian cuisine!',
          userId: '4',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
        ReviewEntity(
          reviewId: '2',
          text: 'Great ambiance and friendly staff!',
          userId: '3',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
        ReviewEntity(
          reviewId: '3',
          text: 'Highly recommended!',
          userId: '1',
          userName: 'userName',
          userPicture: 'userPicture',
        ),
      ],
    ),
    RestaurantEntity(
      restaurantId: 8.toString(),
      name: 'Yak & Yeti Dining',
      location: 'Durbar Marg, Kathmandu',
      status: 'Open',
      picture: '8.jpg',
      bookingTime: '7 am - 11 pm',
      rating: '4.9',
      contact: '9878656456',
      reviews: [],
    ),
  ];
}
