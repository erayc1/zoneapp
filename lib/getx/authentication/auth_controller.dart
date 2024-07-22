import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:zonne/screens/onboarding_screen.dart';
import 'package:zonne/screens/swiper_screen.dart';
import '../../screens/welcome_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;

  Future<void> registerWithEmail(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('kullanicilar').doc(user.uid).set({
          'email': email,
          'uid': user.uid,
          'createdAt': Timestamp.now(),
        });

        Get.to(() => const WelcomeScreen(), transition: Transition.rightToLeft);
      }
    } catch (e) {
      Get.snackbar('Hata', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithEmail(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('kullanicilar').doc(user.uid).get();

        if (userDoc.exists) {
          Get.to(() => SwiperScreen(), transition: Transition.rightToLeft);
        } else {
          Get.snackbar('Hata', 'Kullanıcı bulunamadı');
        }
      }
    } catch (e) {
      Get.snackbar('Hata', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    isLoading.value = true;
    try {
      await _auth.signOut();
      Get.to(() => OnboardingScreen(), transition: Transition.rightToLeft);
    } catch (e) {
      Get.snackbar('Hata', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
