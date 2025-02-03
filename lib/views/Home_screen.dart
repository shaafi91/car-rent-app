import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/car_controller.dart';
import '../models/car_model.dart';
import 'booking_screen.dart'; // Import the BookingScreen
import 'package:car_rent_app/controllers/booking_controller.dart';
import 'package:car_rent_app/controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  final CarController carController = Get.put(CarController());
  final BookingController bookingController = Get.put(BookingController());
  final AuthController authController = Get.find<AuthController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Cars'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.logout), // Logout button
            onPressed: () {
              _logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Cars',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) {
                carController.searchCars(query);
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (carController.filteredCars.isEmpty) {
                  return Center(child: Text('No cars found'));
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: carController.filteredCars.length,
                  itemBuilder: (context, index) {
                    Car car = carController.filteredCars[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the BookingScreen and pass the selected car
                        Get.to(() => BookingScreen(car: car));
                      },
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.asset(
                                car.imageUrl, // Ensure this points to a valid image asset
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    car.name,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('\$${car.price.toStringAsFixed(2)} per day'),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        car.isAvailable ? Icons.check_circle : Icons.cancel,
                                        color: car.isAvailable ? Colors.green : Colors.red,
                                      ),
                                      SizedBox(width: 5),
                                      Text(car.isAvailable ? 'Available' : 'Not Available'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/view_booking_history');
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
                'View Booking History',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    double minPrice = 0;
    double maxPrice = 1000;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter by Price'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Slider(
              value: minPrice,
              min: 0,
              max: 1000,
              divisions: 100,
              label: 'Min Price: \$${minPrice.round()}',
              onChanged: (value) {
                minPrice = value;
              },
            ),
            Slider(
              value: maxPrice,
              min: 0,
              max: 1000,
              divisions: 100,
              label: 'Max Price: \$${maxPrice.round()}',
              onChanged: (value) {
                maxPrice = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              carController.filterCarsByPrice(minPrice, maxPrice);
              Navigator.pop(context);
            },
            child: Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _logout() {
    // Implement logout logic here
    authController.logout(); // Assuming you have a logout method in AuthController
    Get.offAllNamed('/login'); // Navigate to login screen and remove all previous routes
  }
}