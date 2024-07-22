import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zonne/screens/login_page.dart';
import 'package:zonne/screens/signup_screen.dart';
import 'package:zonne/utils/colors.dart';

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final PageController controller;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorUtils.pink,
                fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: const TextStyle(fontSize: 15, fontFamily: 'Poppins'),
            ),
          ),
          const SizedBox(height: 20),
          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: const WormEffect(
              dotHeight: 12,
              dotWidth: 12,
              activeDotColor: Colors.pink,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorUtils.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: () => Get.to(
                () => const SignUpScreen(),
                transition: Transition.rightToLeft,
              ),
              child: const Text('Hesap Oluştur',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600)),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Hesabınız var mı ?",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              TextButton(
                onPressed: () => Get.to(
                  () => const LoginPage(),
                  transition: Transition.rightToLeft,
                ),
                child: const Text(
                  'Giriş Yap',
                  style:
                      TextStyle(color: ColorUtils.pink, fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
