import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/booking_controller.dart';
import '../models/booking_model.dart';

class ViewBookingHistoryScreen extends StatelessWidget {
  final BookingController bookingController = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (bookingController.bookings.isEmpty) {
            return Center(child: Text('No bookings found'));
          }
          return ListView.builder(
            itemCount: bookingController.bookings.length,
            itemBuilder: (context, index) {
              Booking booking = bookingController.bookings[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(
                    'Car: ${booking.carId}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${DateFormat('yyyy-MM-dd').format(booking.startDate)} - ${DateFormat('yyyy-MM-dd').format(booking.endDate)}',
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Price: \$${booking.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.check_circle, color: Colors.green),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}