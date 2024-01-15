import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../data/restaurant_data.dart';
import '../models/restaurant_entity.dart';
import '../models/review_entity.dart';
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

// Return the total number of reviews written by a user
  static int getReviewsLength() {
    int totalReview = 0;

    for (RestaurantEntity restaurant in RestaurantData.restaurants) {
      if (restaurant.reviews != null && restaurant.reviews!.isNotEmpty) {
        for (ReviewEntity review in restaurant.reviews!) {
          if (review.userId == currentUser!.id) {
            totalReview++;
          }
        }
      }
    }

    return totalReview;
  }

  // user log out

  static void signOut() {
    currentUser = null;
  }

  // change full name
  static Either<Failure, bool> changeName({required String newName}) {
    if (newName.isEmpty) {
      return Left(Failure(error: 'Name cannot be empty.'));
    }

    for (var user in UserData.users) {
      if (user.id == currentUser!.id) {
        user.fullName = newName;

        currentUser = UserEntity(
          id: currentUser!.id,
          fullName: newName,
          contact: currentUser!.contact,
          email: currentUser!.email,
          password: currentUser!.password,
        );
        return const Right(true);
      }
    }

    return Left(Failure(error: 'Something went wrong'));
  }

  // change contact

  static Either<Failure, bool> changeContact({required String newContact}) {
    if (newContact.isEmpty) {
      return Left(Failure(error: 'Contact cannot be empty.'));
    }

    for (var user in UserData.users) {
      if (user.id == currentUser!.id) {
        user.contact = newContact;

        currentUser = UserEntity(
          id: currentUser!.id,
          fullName: currentUser!.fullName,
          contact: newContact,
          email: currentUser!.email,
          password: currentUser!.password,
        );
        return const Right(true);
      }
    }

    return Left(Failure(error: 'Something went wrong'));
  }

  // change email

  static Either<Failure, bool> changeEmail({required String newEmail}) {
    if (newEmail.isEmpty) {
      return Left(Failure(error: 'Email cannot be empty'));
    }

    for (var user in UserData.users) {
      if (user.id == currentUser!.id) {
        user.email = newEmail;

        currentUser = UserEntity(
          id: currentUser!.id,
          fullName: currentUser!.fullName,
          contact: currentUser!.contact,
          email: newEmail,
          password: currentUser!.password,
        );
        return const Right(true);
      }
    }

    return Left(Failure(error: 'Something went wrong'));
  }

  // change password

  static Either<Failure, bool> changePassword(
      {required String currentPassword,
      required String newPassword,
      required String confirmPassword}) {
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      return Left(Failure(error: 'Fields cannot be empty.'));
    } else if (currentPassword != currentUser!.password) {
      return Left(Failure(
          error: 'Provided password does not match with current password.'));
    } else if (newPassword != confirmPassword) {
      return Left(Failure(error: 'Password and Confirm password must match.'));
    }

    for (var user in UserData.users) {
      if (user.id == currentUser!.id && user.password == currentPassword) {
        user.password = newPassword;

        // update password in the state
        currentUser = UserEntity(
          id: currentUser!.id,
          fullName: currentUser!.fullName,
          contact: currentUser!.contact,
          email: currentUser!.email,
          password: newPassword,
        );

        return const Right(true);
      }
    }

    return Left(Failure(error: 'Something went wrong.'));
  }
}
