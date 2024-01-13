import '../models/restaurant_entity.dart';
import '../models/review_entity.dart';

class RestaurantData {
  RestaurantData._();

  static List<RestaurantEntity> restaurants = [
    RestaurantEntity(
      restaurantId: '1',
      name: 'Bhojan Griha',
      location: 'New Road, Kathmandu',
      status: 'Open',
      picture: '4.jpg',
      bookingTime: '7 am - 11 pm',
      rating: '5.0',
      contact: '9812345678',
      offer: '20% off on Valentine',
      description:
          "Bhojan Griha, nestled in the heart of New Road, Kathmandu, promises a luxurious and delightful dining experience. Step into a world where tradition meets modernity as you savor a diverse array of cuisines. With an ambiance that reflects cultural richness, each dish is a masterpiece crafted to perfection. Operating from 7 am to 11 pm, Bhojan Griha invites you to a gastronomic journey, offering a 20% off on Valentine's Day to make your dining experience even more special.",
      reviews: [
        ReviewEntity(
          reviewId: '1',
          text: 'Good restaurant.',
          userId: '1',
          userName: 'Gopal Adhikari',
          userPicture: '1.jpg',
        ),
        ReviewEntity(
          reviewId: '2',
          text: 'I love this Mo:Mo food here..',
          userId: '2',
          userName: 'Dr. Trishala Gurung',
          userPicture: '2.png',
        ),
        ReviewEntity(
          reviewId: '3',
          text: 'Excellent service and ambiance!',
          userId: '3',
          userName: 'Santosh Khanal',
          userPicture: '3.png',
        ),
      ],
    ),
    RestaurantEntity(
      restaurantId: '2',
      name: 'Himalayan Java Coffee',
      location: 'Putalisadak, Kathmandu',
      status: 'Open',
      picture: '3.jpg',
      bookingTime: '8 am - 10 pm',
      rating: '3.1',
      contact: '9876487623',
      offer: '10% off on Valentine',
      description:
          "A cozy coffee shop with a variety of coffee blends. Located in Putalisadak, Kathmandu, Himalayan Java Coffee is not just a coffee shop; it's a haven for coffee enthusiasts. Operating from 8 am to 10 pm, this cozy establishment serves an assortment of coffee blends that will tantalize your taste buds. With a rating of 3.1, Himalayan Java Coffee invites you to enjoy a 10% off on Valentine's Day. Whether you're looking for a casual catch-up or a quiet solo moment, this coffee haven is your ideal retreat.",
      reviews: [
        ReviewEntity(
          reviewId: '1',
          text: 'Delicious Indian cuisine!',
          userId: '4',
          userName: 'Jayadip Magar',
          userPicture: '4.png',
        ),
        ReviewEntity(
          reviewId: '2',
          text: 'Great ambiance and friendly staff!',
          userId: '3',
          userName: 'Santosh Khanal',
          userPicture: '3.png',
        ),
        ReviewEntity(
          reviewId: '3',
          text: 'Highly recommended!',
          userId: '1',
          userName: 'Gopal Adhikari',
          userPicture: '1.jpg',
        ),
      ],
    ),
    RestaurantEntity(
      restaurantId: '3',
      name: 'Mount Everest Cafe',
      location: 'Thamel, Kathmandu',
      status: 'Open',
      picture: '1.jpg',
      bookingTime: '6 am - 12 am',
      rating: '4.2',
      contact: '9856437864',
      description:
          "Discover tranquility at Mount Everest Cafe in Thamel, Kathmandu. Open from 6 am to 12 am, this café offers a panoramic view of the mountains, creating a serene atmosphere for your dining pleasure. With a rating of 4.2, the cozy ambiance complements the tasty food, making it a preferred spot for locals and tourists alike. Indulge in a delightful experience and escape into the beauty of the Himalayas.",
      reviews: [
        ReviewEntity(
          reviewId: '1',
          text: 'Scenic view and tasty food!',
          userId: '2',
          userName: 'Dr. Trishala Gurung',
          userPicture: '2.png',
        ),
        ReviewEntity(
          reviewId: '2',
          text: 'Cozy atmosphere!',
          userId: '1',
          userName: 'Gopal Adhikari',
          userPicture: '1.jpg',
        ),
        ReviewEntity(
          reviewId: '3',
          text: 'Lovely place!',
          userId: '3',
          userName: 'Santosh Khanal',
          userPicture: '3.png',
        ),
      ],
    ),
    RestaurantEntity(
      restaurantId: '4',
      name: 'Nepali Kitchen',
      location: 'Jhamsikhel, Lalitpur',
      status: 'Open',
      picture: '2.jpg',
      bookingTime: '10 am - 8 pm',
      rating: '4.8',
      offer: 'Buy 2 Pizza, Get free Drink',
      contact: '9878659856',
      description:
          'Authentic Nepali cuisine in a traditional setting. hamsikhel, Lalitpur, is home to Nepali Kitchen, where authenticity meets flavor. Open from 10 am to 8 pm, this restaurant specializes in traditional Nepali cuisine served in a warm and inviting setting. With a rating of 4.8, Nepali Kitchen has an enticing offer – buy 2 pizzas and get a free drink! Immerse yourself in the rich flavors of Nepal.',
      reviews: [],
    ),
    RestaurantEntity(
      restaurantId: '5',
      name: 'Pashupatinath Eats',
      location: 'Pashupati Road, Kathmandu',
      status: 'Open',
      picture: '5.jpg',
      bookingTime: '6 am - 11 pm',
      offer: '20% off on Valentine',
      rating: '4.7',
      contact: '9823546674',
      description:
          "Experience divine flavors near the sacred Pashupatinath Temple. Nestled on Pashupati Road, Kathmandu, Pashupatinath Eats is where divine flavors meet culinary excellence. Open from 6 am to 11 pm, this restaurant offers a 20% discount on Valentine's Day. With a rating of 4.7, it's a perfect spot to experience exquisite dishes in the vicinity of the sacred Pashupatinath Temple.",
      reviews: [],
    ),
    RestaurantEntity(
      restaurantId: '6',
      name: 'Himalayan Delight',
      location: 'Boudha, Kathmandu',
      status: 'Open',
      picture: '6.jpg',
      bookingTime: '11 am - 9 pm',
      rating: '4.4',
      contact: '9878643543',
      description: """
Located in Boudha, Kathmandu, Himalayan Delight invites you to indulge in the flavors inspired by the majestic Himalayas. Operating from 11 am to 9 pm, this restaurant has a rating of 4.4, reflecting its commitment to providing a delightful dining experience. 
Scenic views, tasty food, and a cozy atmosphere await you at Himalayan Delight.
""",
      reviews: [
        ReviewEntity(
          reviewId: '1',
          text: 'Scenic view and tasty food!',
          userId: '2',
          userName: 'Dr. Trishala Gurung',
          userPicture: '2.png',
        ),
        ReviewEntity(
          reviewId: '2',
          text: 'Cozy atmosphere!',
          userId: '1',
          userName: 'Gopal Adhikari',
          userPicture: '1.jpg',
        ),
        ReviewEntity(
          reviewId: '3',
          text: 'Lovely place!',
          userId: '3',
          userName: 'Santosh Khanal',
          userPicture: '3.png',
        ),
      ],
    ),
    RestaurantEntity(
      restaurantId: '7',
      name: 'Kathmandu Fusion',
      location: 'Durbarmarg, Kathmandu',
      status: 'Open',
      picture: '7.jpg',
      bookingTime: '12 pm - 10 pm',
      rating: '4.6',
      contact: '9800876565',
      offer: '20% off on New Year',
      description:
          'A fusion of flavors from around the world in the heart of Kathmandu. Durbarmarg, Kathmandu, hosts Kathmandu Fusion, a culinary fusion extravaganza. Open from 12 pm to 10 pm, this restaurant combines flavors from around the world in the heart of Kathmandu. With a rating of 4.6, Kathmandu Fusion is a go-to place for those seeking a diverse and delicious dining experience. Enjoy a 20% discount on New Year Day',
      reviews: [
        ReviewEntity(
          reviewId: '1',
          text: 'Delicious Indian cuisine!',
          userId: '4',
          userName: 'Jayadip Magar',
          userPicture: '4.png',
        ),
        ReviewEntity(
          reviewId: '2',
          text: 'Great ambiance and friendly staff!',
          userId: '3',
          userName: 'Santosh Khanal',
          userPicture: '3.png',
        ),
        ReviewEntity(
          reviewId: '3',
          text: 'Highly recommended!',
          userId: '1',
          userName: 'Gopal Adhikari',
          userPicture: '1.jpg',
        ),
      ],
    ),
    RestaurantEntity(
      restaurantId: '8',
      name: 'Yak & Yeti Dining',
      location: 'Durbar Marg, Kathmandu',
      status: 'Open',
      picture: '8.jpg',
      bookingTime: '7 am - 11 pm',
      rating: '4.9',
      contact: '9878656456',
      description:
          'Dine in style at Yak & Yeti Dining with a view of Durbar Marg. Experience style and elegance at Yak & Yeti Dining in Durbar Marg, Kathmandu. Open from 7 am to 11 pm, this restaurant boasts a rating of 4.9, reflecting its commitment to culinary excellence. Dine with a view of Durbar Marg and savor a unique blend of flavors in a sophisticated ambiance.',
      reviews: [],
    ),
  ];
}
