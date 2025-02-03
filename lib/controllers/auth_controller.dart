import 'package:get/get.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs; // Observable to track login state
  var user = User(id: '', name: '', email: '', password: '', role: '').obs;

  void register(String name, String email, String password) {
    // Simulate registration logic
    user.update((val) {
      val?.id = '123'; // Example ID
      val?.name = name;
      val?.email = email;
      val?.password = password;
      val?.role = 'user';
    });
    isLoggedIn.value = true;
  }

  void login(String email, String password) {
    // Simulate login logic
    if (email == 'test' && password == '123') {
      user.update((val) {
        val?.id = '123';
        val?.name = 'Test User';
        val?.email = email;
        val?.password = password;
        val?.role = 'user';
      });
      isLoggedIn.value = true;
    } else {
      Get.snackbar('Error', 'Invalid credentials');
    }
  }

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