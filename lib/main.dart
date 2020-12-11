import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/hotels_screen.dart';

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
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),
        home: HomeScreen(),
        routes: {
          HotelsScreen.routeName: (ctx) => HotelsScreen(),
        },
      ),
    );
  }
}
