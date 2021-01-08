import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/screens/mainPage/main_page.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

class MainSplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {

  Future<Widget> loadFromFuture() async {
    await Provider.of<MovieLists>(context, listen: false).fetchTrendingList();
    await Provider.of<MovieLists>(context, listen: false).fetchGenres();
    try {
      await Provider.of<MovieLists>(context, listen: false)
          .fetchSavedListsFromSF();
    } catch (error) {
      throw error;
    }

    return Future.value(new MyHomePage(title: 'MoviePKR2'));
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
      photoSize: 160,
    );
  }
}
