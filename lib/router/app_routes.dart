import '../views/auth/login_view.dart';
import '../views/auth/signup_view.dart';
import '../views/auth/user_verification_view.dart';
import '../views/bottom_navigation_view.dart';
import '../views/home_view.dart';
import '../views/introduction/first_intro_view.dart';
import '../views/introduction/second_intro_view.dart';
import '../views/introduction/third_intro_view.dart';
import '../views/singel_product_view.dart';
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
  static const String shoppingCartRoute = '/shoppingCart';
  static const String singleProductRoute = '/singleProduct';
  static const String userVerificationRoute = '/verify';

  static getAppRoutes() {
    return {
      homeRoute: (context) => const HomeView(),
      singleProductRoute: (context) => const SingleProductView(),
      navigationRoute: (context) => const BottomNavigationView(),
      splashRoute: (context) => const SplashView(),
      firstIntroRoute: (context) => const FirstIntroView(),
      secondIntroRoute: (context) => const SecondIntroView(),
      thirdIntroRoute: (context) => const ThirdIntroScreen(),
      loginRoute: (context) => const LoginView(),
      signupRoute: (context) => const SignupView(),
      userVerificationRoute: (context) => const UserVerificationView(),
    };
  }
}
