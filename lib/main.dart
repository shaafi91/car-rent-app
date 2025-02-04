import 'package:car_rent_app/controllers/auth_controller.dart';
import 'package:car_rent_app/controllers/booking_controller.dart';
import 'package:car_rent_app/controllers/car_controller.dart';
import 'package:car_rent_app/models/car_model.dart';
import 'package:car_rent_app/views/booking_history.dart';
import 'package:car_rent_app/views/peyment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rent_app/views/login_screen.dart';
import 'package:car_rent_app/views/home_screen.dart';
import 'package:car_rent_app/views/booking_screen.dart';
import 'package:car_rent_app/controllers/payment_controller.dart'; // Import PaymentController

void main() {
  // Initialize controllers here
  
  Get.put(PaymentController()); // Initialize PaymentController


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Car Rent App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/payment', page: () => PaymentScreen(amount: 0.0)),
        GetPage(
            name: '/view_booking_history',
            page: () => ViewBookingHistoryScreen()),
        GetPage(
            name: '/booking',
            page: () => BookingScreen(
                car: Car(
                    id: '',
                    name: '',
                    price: 0.0,
                    imageUrl: '',
                    isAvailable: false))),
      ],
    );
  }
}
