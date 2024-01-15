import '../views/loading_screen_view.dart';
import '../views/reservation/reservation_success_view.dart';
import '../views/reservation/reservation_view.dart';
import '../views/restaurants/single_restaurant_view.dart';
import '../views/auth/login_view.dart';
import '../views/auth/signup_view.dart';
import '../views/auth/user_verification_view.dart';
import '../views/bottom_navigation_view.dart';
import '../views/introduction/first_intro_view.dart';
import '../views/introduction/second_intro_view.dart';
import '../views/introduction/third_intro_view.dart';
import '../views/nav_bar/home_view.dart';
import '../views/splash_view.dart';

class AppRoutes {
  // avoid making constructor
  AppRoutes._();

  static const String splashRoute = '/';

  static const String homeRoute = '/home';
  static const String firstIntroRoute = '/firstIntro';
  static const String secondIntroRoute = '/secondIntro';
  static const String thirdIntroRoute = '/thirdRoute';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String navigationRoute = '/navigation';
  static const String userVerificationRoute = '/verify';
  static const String singleRestaurantRoute = '/restaurant';
  static const String reservationRoute = '/reservation';
  static const String reservationSuccessRoute = '/success';
  static const String loadingRoute = '/loading';

  static getAppRoutes() {
    return {
      homeRoute: (context) => const HomeView(),
      navigationRoute: (context) => const BottomNavigationView(),
      splashRoute: (context) => const SplashView(),
      firstIntroRoute: (context) => const FirstIntroView(),
      secondIntroRoute: (context) => const SecondIntroView(),
      thirdIntroRoute: (context) => const ThirdIntroScreen(),
      loginRoute: (context) => const LoginView(),
      signupRoute: (context) => const SignupView(),
      userVerificationRoute: (context) => const UserVerificationView(),
      singleRestaurantRoute: (context) => const RestaurantView(),
      reservationRoute: (context) => const ReservationView(),
      reservationSuccessRoute: (context) => const ReservationSuccessView(),
      loadingRoute: (context) => const LoadingScreen(),
    };
  }
}
