import 'package:get/get.dart';
import '../models/car_model.dart';

class CarController extends GetxController {
  var cars = <Car>[].obs; // Observable list of cars
  var filteredCars = <Car>[].obs; // Observable list for filtered cars

  @override
  void onInit() {
    super.onInit();
    fetchCars(); // Load initial car data
  }

void fetchCars() {
  List<Car> mockCars = [
    Car(id: '1', name: 'Toyota Camry', price: 50.0, imageUrl: 'assets/images/toyota_camry.jpg', isAvailable: true),
    Car(id: '2', name: 'Honda Civic', price: 45.0, imageUrl: 'assets/images/honda_civic.jpg', isAvailable: true),
    Car(id: '3', name: 'Tesla Model 3', price: 100.0, imageUrl: 'assets/images/tesla_model3.jpg', isAvailable: false),
    Car(id: '4', name: 'audi', price: 100.0, imageUrl: 'assets/images/car2.jpg', isAvailable: true),
  ];
  cars.assignAll(mockCars);
  filteredCars.assignAll(mockCars); // Initially, show all cars
}

  void searchCars(String query) {
    if (query.isEmpty) {
      filteredCars.assignAll(cars); // Show all cars if query is empty
    } else {
      filteredCars.assignAll(
        cars.where((car) => car.name.toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
  }

  void filterCarsByPrice(double minPrice, double maxPrice) {
    filteredCars.assignAll(
      cars.where((car) => car.price >= minPrice && car.price <= maxPrice).toList(),
    );
  }
}