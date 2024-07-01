import 'package:get_storage/get_storage.dart';

class Getters {
  static final GetStorage box = GetStorage();

  static String? getEmail() {
    String? email = box.read('email');
    return email;
  }
}
