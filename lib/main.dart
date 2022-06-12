import 'package:domain/person/entities/coach.dart';
import 'package:domain/person/entities/person.dart';
import 'package:domain/person/entities/player.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/infrastructure.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:team_soccer/di/di.dart';
import 'package:team_soccer/screens/home/home_screen.dart';
import 'package:team_soccer/screens/login/login_screen.dart';

import 'package:team_soccer/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  await initializeDateFormatting('es');
  diInitializer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Team Up Soccer',
      theme: ligthTheme,
      home: LoginScreen.init(),
    );
  }
}
