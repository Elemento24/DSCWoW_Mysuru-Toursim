import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import './screens/services_screen.dart';
import './screens/home_screen.dart';
import './screens/hotels_screen.dart';
import './screens/hotel_screen.dart';
import './screens/places_screen.dart';
import './screens/place_screen.dart';
import './screens/signup_screen.dart';
import './screens/login_screen.dart';

import './providers/places.dart';
import './providers/hotels.dart';
import './providers/auth.dart';

import './widgets/splash.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => Hotels()),
        ChangeNotifierProvider(create: (ctx) => Places()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Mysuru Toursim',
          theme: ThemeData(
            primarySwatch: Colors.amber,
            accentColor: Colors.brown,
          ),
          // home: HomeScreen(),
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResSnapshot) =>
                      authResSnapshot.connectionState == ConnectionState.waiting
                          ? Splash()
                          : SignupScreen(),
                ),
          routes: {
            HotelsScreen.routeName: (ctx) => HotelsScreen(),
            HotelScreen.routeName: (ctx) => HotelScreen(),
            PlacesScreen.routeName: (ctx) => PlacesScreen(),
            PlaceScreen.routeName: (ctx) => PlaceScreen(),
            ServicesScreen.routeName: (ctx) => ServicesScreen(),
            SignupScreen.routeName: (ctx) => SignupScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
          },
        ),
      ),
    );
  }
}
