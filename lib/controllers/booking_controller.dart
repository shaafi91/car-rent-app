import 'package:get/get.dart';
import '../models/booking_model.dart';

class BookingController extends GetxController {
  var startDate = DateTime.now().obs; // Observable start date
  var endDate = DateTime.now().add(Duration(days: 1)).obs; // Observable end date
  var totalPrice = 0.0.obs; // Observable total price
  var bookings = <Booking>[].obs; // List to store booking history

  void updateDates(DateTime newStartDate, DateTime newEndDate, double carPrice) {
    startDate.value = newStartDate;
    endDate.value = newEndDate;
    // Calculate total price based on the number of days
    int days = endDate.value.difference(startDate.value).inDays;
    totalPrice.value = days * carPrice;
  }

  void createBooking(String userId, String carId, double carPrice) {
    // Simulate creating a booking
    DateTime now = DateTime.now();
    Booking newBooking = Booking(
      id: '123', // Example ID
      userId: userId,
      carId: carId,
      startDate: now,
      endDate: now.add(Duration(days: 1)),
      totalPrice: carPrice,
      status: 'Confirmed',
    );
    bookings.add(newBooking);
    Get.snackbar('Success', 'Booking created successfully');
  }
}