import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../getx/profile_controller.dart';
import '../utils/colors.dart';
import '../widgets/profile_page_buildIcon.dart';

class ProfileInfoPage extends StatelessWidget {
  final String userId;

  const ProfileInfoPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    final PageController pageController = PageController();

    profileController.fetchUserData(userId);

    return Scaffold(
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (profileController.userData.isEmpty) {
          return const Center(child: Text('Kullanıcı bulunamadı'));
        }

        final String name = profileController.userData['name'];
        final String about = profileController.userData['hakkinda'];
        final String jobTitle = 'İç Mimar';
        final List<String> interests =
            List<String>.from(profileController.userData['selectedPassions']);

        return FutureBuilder<List<Image>>(
          future: profileController.getImages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Bir hata oluştu'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Resim bulunamadı'));
            }

            final List<Image> images = snapshot.data!;

            return SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 350,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return images[index];
                          },
                          onPageChanged: (index) {
                            profileController.currentPage.value =
                                index.toDouble();
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 40.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins'),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.grey)),
                                  child: Image.asset(
                                    "assets/images/send.png",
                                  ),
                                )
                              ],
                            ),
                            Text(
                              jobTitle,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontFamily: 'Poppins'),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Hakkında',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              about,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Daha Fazlasını Oku',
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'İlgi Alanları',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: interests
                                  .map((interest) => Chip(
                                        label: Text(interest),
                                        backgroundColor:
                                            Colors.pink.withOpacity(0.1),
                                        labelStyle: const TextStyle(
                                          color: ColorUtils.pink,
                                          fontFamily: 'Poppins',
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 60,
                    left: 10,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 12.0, top: 8, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade400)),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                            color: Colors.pink,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 320,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildIcon(Icons.close, Colors.red),
                        buildIcon(Icons.favorite, Colors.pink),
                        buildIcon(Icons.star, Colors.yellow),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 300,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: images.length,
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Colors.white,
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
