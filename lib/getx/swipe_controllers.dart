import 'package:get/get.dart';

class MySwiperController extends GetxController {
  var currentIndex = 0.obs;
  var likeStatus = ''.obs;

  void swipeLeft() {
    likeStatus.value = 'dislike';
  }

  void swipeRight() {
    likeStatus.value = 'like';
  }
}
