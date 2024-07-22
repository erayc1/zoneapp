import 'package:flutter/material.dart';

import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  final List<Map<String, String>> pages = [
    {
      'imagePath': 'assets/images/resim1.png',
      'title': 'Algoritma',
      'description':
          'Botlarla asla eşleşmediğinizden emin olmak için bir inceleme sürecinden geçen kullanıcılar.'
    },
    {
      'imagePath': 'assets/images/resim2.png',
      'title': 'Eşleşme',
      'description':
          'Sizi, benzer ilgi alanlarına sahip çok sayıda insanla eşleştiriyoruz.'
    },
    {
      'imagePath': 'assets/images/resim3.png',
      'title': 'Gold Paket',
      'description':
          'Bugün kaydolun ve bizden birinci aydaki premium avantajların tadını çıkarın.'
    },
  ];

  OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.75);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.pages.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                    }
                    return Transform.scale(
                      scale: value,
                      child: OnboardingPage(
                        imagePath: widget.pages[index]['imagePath']!,
                        title: widget.pages[index]['title']!,
                        description: widget.pages[index]['description']!,
                        controller: _pageController,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
