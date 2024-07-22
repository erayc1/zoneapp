import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileController extends GetxController {
  var name = ''.obs;
  var photoUrl = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('kullanici_bilgiler')
            .where('userId', isEqualTo: currentUser.uid)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          DocumentSnapshot userDoc = userSnapshot.docs.first;
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          name.value = userData['name'];
          photoUrl.value = userData['photoUrls'][0];
        }
      }
    } catch (e) {
      Get.snackbar('Hata', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
