import 'package:flutter/material.dart';
import 'package:trip_planner/PlanTripPage.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';

void main() {
  runApp(TripPlannerApp());
}

class TripPlannerApp extends StatelessWidget {
  const TripPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trip Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/signup': (context) => SignUpPage(),
      '/home': (context) => HomePage(),
      '/planTrip': (context) => PlanTripPage()
    }
    );

  }
}