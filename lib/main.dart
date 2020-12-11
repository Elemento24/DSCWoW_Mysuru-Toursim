import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import './screens/services_screen.dart';
import './screens/home_screen.dart';
import './screens/hotels_screen.dart';
import './screens/places_screen.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => null),
      ],
      child: MaterialApp(
        title: 'Mysuru Toursim',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          accentColor: Colors.brown,
        ),
        home: HomeScreen(),
        routes: {
          HotelsScreen.routeName: (ctx) => HotelsScreen(),
          PlacesScreen.routeName: (ctx) => PlacesScreen(),
          ServicesScreen.routeName: (ctx) => ServicesScreen(),
        },
      ),
    );
  }
}
