import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../models/reservation_entity.dart';

import '../data/user_data.dart';
import '../failure/failure.dart';
import '../models/user_entity.dart';
import 'user_verifcation.dart';

class User {
  static UserEntity? currentUser;
  static UserEntity? signUpUser;

// for login
  static Either<Failure, bool> signIn(
      {required String email, required String password}) {
    for (var user in UserData.users) {
      if (user.email == email && user.password == password) {
        currentUser = user;
        return const Right(true);
      }
    }

    return Left(Failure(
      error: 'Account has not been registered or incorrect credentials',
    ));
  }

  // for sign up

  static int signUp({
    required String fullName,
    required String contact,
    required String email,
    required String password,
  }) {
    int id = UserData.users.length + 1;
    signUpUser = UserEntity(
      id: id.toString(),
      fullName: fullName,
      contact: contact,
      email: email,
      password: password,
    );

    return UserVerification.getOtp;
  }

// verify user
  static Either<Failure, bool> verifyUser({required String otpPin}) {
    bool result = UserVerification.checkOtp(yourOTP: int.parse(otpPin));
    if (result) {
      if (signUpUser != null) {
        currentUser = signUpUser;
        UserData.users.add(signUpUser!);
      }

      return const Right(true);
    }
    return Left(Failure(error: 'Provided OTP code does not match. Try Again.'));
  }

  // reserve the table

  static void reserveTable({
    required String restaurantName,
    required String restaurantPicture,
    required int dinerNum,
    required String pickDate,
    required String pickTime,
  }) {
    int id = currentUser!.reservations.length + 1;

    ReservationEntity reservation = ReservationEntity(
      id: id.toString(),
      restaurantName: restaurantName,
      restaurantPicture: restaurantPicture,
      guestsNum: dinerNum,
      pickDate: pickDate,
      pickTime: pickTime,
    );

    currentUser!.reservations.insert(0, reservation);
  }
}
