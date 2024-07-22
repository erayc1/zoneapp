import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var userData = {}.obs;
  var photoUrls = <String>[].obs;
  var isLoading = true.obs;
  var currentPage = 0.0.obs;

  Future<void> fetchUserData(String userId) async {
    try {
      isLoading.value = true;
      final QuerySnapshot userSnapshot = await _firestore
          .collection('kullanici_bilgiler')
          .where('userId', isEqualTo: userId)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        userData.value = userSnapshot.docs.first.data() as Map<String, dynamic>;
        photoUrls.value = List<String>.from(userData['photoUrls']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Image>> getImages() async {
    final List<Image> images = [];
    for (var url in photoUrls) {
      final Image image = Image.network(url, fit: BoxFit.cover);
      await precacheImage(image.image, Get.context!);
      images.add(image);
    }
    return images;
  }
}
