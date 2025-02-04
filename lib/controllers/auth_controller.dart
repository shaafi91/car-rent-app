import 'package:get/get.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs; // Observable to track login state
  var user = User(id: '', name: '', email: '', password: '', role: '').obs;

  // Registered user's email and password storage
  String? registeredEmail;
  String? registeredPassword;

  // Register the user and store their credentials
  void register(String name, String email, String password) {
    user.update((val) {
      val?.id = '123'; // Example ID
      val?.name = name;
      val?.email = email;
      val?.password = password;
      val?.role = 'user';
    });
    registeredEmail = email;
    registeredPassword = password;
    isLoggedIn.value = true;
  }

  // Login logic: validate against registered credentials
  bool login(String email, String password) {
    if (email == registeredEmail && password == registeredPassword) {
      user.update((val) {
        val?.id = '123';
        val?.name = 'Test User'; // You can update this based on registered user
        val?.email = email;
        val?.password = password; // Avoid storing password in production
        val?.role = 'user';
      });
      isLoggedIn.value = true;
      return true; // Successful login
    }
    return false; // Invalid credentials
  }

  // Logout logic
  void logout() {
    user.update((val) {
      val?.id = '';
      val?.name = '';
      val?.email = '';
      val?.password = '';
      val?.role = '';
    });
    isLoggedIn.value = false;
  }
}