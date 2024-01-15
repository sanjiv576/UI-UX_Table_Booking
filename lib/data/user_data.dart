import '../models/reservation_entity.dart';

import '../models/user_entity.dart';

class UserData {
  UserData._();

  static List<UserEntity> users = [
    // user 1
    UserEntity(
      id: '1',
      fullName: 'Gopal Adhikari',
      contact: '9887665767',
      email: 'gopal@gmail.com',
      password: 'gopal123',
      picture: '1.jpg',
      reservations: [
        ReservationEntity(
          id: '1',
          restaurantName: 'Bhojan Griha',
          restaurantPicture: '4.jpg',
          guestsNum: 3,
          pickDate: 'Jan 11, 2024',
          pickTime: '3:00 PM',
          status: 'Reserved',
        ),
      ],
    ),
    // user 2

    UserEntity(
      id: '2',
      fullName: 'Dr. Trishala Gurung',
      contact: '9834356765',
      email: 'trishala@gmail.com',
      password: 'trishala123',
      picture: '2.png',
    ),
    // user 3

    UserEntity(
      id: '3',
      fullName: 'Santosh Khanal',
      contact: '9898767656',
      email: 'santosh@gmail.com',
      password: 'santosh123',
      picture: '3.png',
    ),

    // user 4

    UserEntity(
      id: '4',
      fullName: 'Jayadip Magar',
      contact: '9878675656',
      email: 'jd@gmail.com',
      password: 'jd123',
      picture: '4.png',
      reservations: [
        ReservationEntity(
            id: '1',
            restaurantName: 'Mount Everest Cafe',
            restaurantPicture: '1.jpg',
            guestsNum: 2,
            pickDate: 'Jan 1, 2024',
            pickTime: '11:00 AM'),
        ReservationEntity(
          id: '2',
          restaurantName: 'Nepali Kitchen',
          restaurantPicture: '2.jpg',
          guestsNum: 4,
          pickDate: 'Jan 5, 2024',
          pickTime: '7:00 PM',
          status: 'Canceled',
        ),
        ReservationEntity(
            id: '3',
            restaurantName: 'Himalayan Delight',
            restaurantPicture: '6.jpg',
            guestsNum: 3,
            pickDate: 'Jan 7, 2024',
            pickTime: '5:00 PM'),
        ReservationEntity(
            id: '4',
            restaurantName: 'Kathmandu Fusion',
            restaurantPicture: '7.jpg',
            guestsNum: 1,
            pickDate: 'Jan 11, 2024',
            pickTime: '9:00 AM'),
      ],
    ),
  ];
}
