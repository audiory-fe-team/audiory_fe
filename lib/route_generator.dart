import 'package:audiory_v0/screens/home_test/home_screen_test.dart';
import 'package:audiory_v0/screens/login/login_screen.dart';
import 'package:audiory_v0/screens/register/register_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreenTest());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case '/login':
        //check if args is the right type
        // if (args is String) {
        //   return MaterialPageRoute(builder: (_) => LoginScreen());
        // }
        return MaterialPageRoute(builder: (_) => LoginScreen());

      // return _errorRoute();
      default:
        // return MaterialPageRoute(builder: (_) => HomeScreeen());
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('Error')),
      );
    });
  }
}
