import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokex/authentication/cubit/auth_cubit.dart';
import 'package:pokex/authentication/views/login_page.dart';
import 'package:pokex/authentication/views/signup_page.dart';
import 'package:pokex/home/cubit/home_cubit.dart';
import 'package:pokex/home/favourites_page.dart';
import 'package:pokex/home/views/home_page.dart';
import 'package:pokex/repository/home_repository.dart';
import 'package:pokex/repository/login_repository.dart';
import 'package:pokex/splash/splash_page.dart';

class AppRoutes {
  static const String splashPage = "/";
  static const String loginPage = "/login";
  static const String signupPage = "/signup";
  static const String homePage = "/home";
  static const String favouritesPage = "/favourites";

  Route? getRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashPage:
        {
          return MaterialPageRoute(
            builder: (_) => const SplashPage(),
          );
        }

      case loginPage:
        {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => AuthCubit(LoginRepository()),
              child: LoginPage(),
            ),
          );
        }

      case signupPage:
        {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => AuthCubit(LoginRepository()),
              child: SignupPage(),
            ),
          );
        }

      case favouritesPage:
        {
          return MaterialPageRoute(
            builder: (_) => const FavouritesPage(),
          );
        }

      case homePage:
        {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => HomeCubit(HomeRepository()),
              child: HomePage(),
            ),
          );
        }

      default:
        {
          return null;
        }
    }
  }
}
