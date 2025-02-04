import 'package:car_rent_app/views/peyment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/booking_controller.dart';
import '../models/car_model.dart';
 // Import the PaymentScreen

class BookingScreen extends StatelessWidget {
  final Car car; // Selected car passed from the Home Screen
  final BookingController bookingController =
      Get.find<BookingController>(); // Initialize the controller

  BookingScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${car.name}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car Image and Details
            Center(
              child: Image.network(
                car.imageUrl,
                height: 100,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              car.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('\$${car.price.toStringAsFixed(2)} per day'),
            SizedBox(height: 20),

            // Start Date Picker
            Obx(() {
              return TextField(
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: bookingController.startDate.value,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (pickedDate != null) {
                    bookingController.updateDates(pickedDate, bookingController.endDate.value, car.price);
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(
                  text: DateFormat('yyyy-MM-dd').format(bookingController.startDate.value),
                ),
              );
            }),
            SizedBox(height: 20),

            // End Date Picker
            Obx(() {
              return TextField(
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: bookingController.endDate.value,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (pickedDate != null) {
                    bookingController.updateDates(bookingController.startDate.value, pickedDate, car.price);
                  }
                },
                decoration: InputDecoration(
                  labelText: 'End Date',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(
                  text: DateFormat('yyyy-MM-dd').format(bookingController.endDate.value),
                ),
              );
            }),
            SizedBox(height: 20),

            // Total Price Display
            Obx(() {
              return Text(
                'Total Price: \$${bookingController.totalPrice.value.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              );
            }),
            SizedBox(height: 20),

            // Confirm Booking Button
            ElevatedButton(
              onPressed: () {
                if (bookingController.startDate.value.isAfter(bookingController.endDate.value)) {
                  Get.snackbar('Error', 'Start date must be before end date');
                  return;
                }

                // Create the booking
                bookingController.createBooking(
                  '123', // Example user ID
                  car.id,
                  car.price,
                );

                // Navigate to the Payment Screen
                Get.to(() => PaymentScreen(amount: bookingController.totalPrice.value));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Confirm Booking',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}