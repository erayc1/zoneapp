import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:zonne/screens/email_sign_screen.dart';
import 'package:zonne/screens/phone_sign_screen.dart';

import '../utils/colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/zone.png',
                height: 100,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorUtils.pink,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () => Get.to(() => const EmailSignScreen(),
                    transition: Transition.rightToLeft),
                child: const Text(
                  'Email ile Devam Et',
                  style: TextStyle(
                      fontSize: 16, color: Colors.white, fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: ColorUtils.pink),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () => Get.to(
                  () => PhoneSignUpScreen(),
                  transition: Transition.rightToLeft,
                ),
                child: const Text(
                  'Telefon Numaranı Kullan',
                  style: TextStyle(
                      fontSize: 16,
                      color: ColorUtils.pink,
                      fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Veya',
                style: TextStyle(
                    fontSize: 14, color: Colors.black, fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.facebook,
                      color: ColorUtils.pink,
                    ),
                    iconSize: 40,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.google,
                        color: ColorUtils.pink),
                    iconSize: 40,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.apple,
                        color: ColorUtils.pink),
                    iconSize: 40,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Terms of use',
                      style: TextStyle(
                          color: ColorUtils.pink,
                          decoration: TextDecoration.underline,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                          color: ColorUtils.pink,
                          decoration: TextDecoration.underline,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
