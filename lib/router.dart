import 'package:apploja/pages/login.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case '/user':

      //return MaterialPageRoute(

      //  builder: (_) => const UserHomePage(), settings: settings);

      case '/admin':

      // return MaterialPageRoute(

      //   builder: (_) => const AdminHomePage(), settings: settings);

      case '/details':
      /* return MaterialPageRoute(builder: (_) => User(args as User)); */

      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
