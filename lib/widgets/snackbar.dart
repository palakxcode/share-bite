import 'package:get/get.dart';

void buildSnackBar(String level, String message) {
  Get.snackbar(level, message, snackPosition: SnackPosition.BOTTOM);
}
