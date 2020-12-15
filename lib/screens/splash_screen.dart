import 'package:MoviePKR/screens/main_page.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:splashscreen/splashscreen.dart';

class MainSplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  Future<Widget> loadFromFuture() async {
    //Fetch data while splash screen is showing.
    await new Future.delayed(const Duration(
        seconds: 5)); //replace this with actual code to fetch data on app load

    return Future.value(new MyHomePage(title: 'MoviePKR'));
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      navigateAfterFuture: loadFromFuture(),
      gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [AppColors.primaryColor, AppColors.secondaryColor]),
      image: Image.asset(
        'assets/images/logo.png',
      ),
      photoSize: 100,
    );
  }
}
