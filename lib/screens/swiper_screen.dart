import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:zonne/screens/profile_info_page.dart';
import '../getx/swipe_controllers.dart';
import '../widgets/filter_bottomSheet.dart';

class SwiperScreen extends StatelessWidget {
  const SwiperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MySwiperController swiperController = Get.put(MySwiperController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Keşfet',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              icon: Image.asset(
                "assets/images/filter.png",
                width: 40,
                height: 40,
              ),
              onPressed: () {
                showFilterBottomSheet(context);
              },
            ),
          )
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future:
            FirebaseFirestore.instance.collection('kullanici_bilgiler').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Bir hata oluştu'));
          }

          final List<DocumentSnapshot> profiles = snapshot.data!.docs;

          return Column(
            children: [
              Expanded(
                child: CardSwiper(
                  cardsCount: profiles.length,
                  cardBuilder: (BuildContext context, int index, int realIndex,
                      int length) {
                    return Obx(() {
                      final userProfile =
                          profiles[index].data() as Map<String, dynamic>;
                      final String imageUrl = userProfile['photoUrls'][0];

                      return Stack(
                        children: [
                          InkWell(
                            onTap: () => Get.to(() =>
                                ProfileInfoPage(userId: userProfile['userId'])),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userProfile['name'],
                                  style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          if (swiperController.likeStatus.value == 'like' &&
                              swiperController.currentIndex.value == realIndex)
                            const Center(
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 100,
                              ),
                            ),
                          if (swiperController.likeStatus.value == 'dislike' &&
                              swiperController.currentIndex.value == realIndex)
                            const Center(
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 100,
                              ),
                            ),
                        ],
                      );
                    });
                  },
                  onSwipe: (int index, int? realIndex,
                      CardSwiperDirection direction) {
                    if (direction == CardSwiperDirection.right) {
                      swiperController.swipeRight();
                    } else if (direction == CardSwiperDirection.left) {
                      swiperController.swipeLeft();
                    }
                    swiperController.currentIndex.value = index;
                    return true;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/geri.png",
                    height: 100,
                  ),
                  Image.asset(
                    "assets/images/carpi.png",
                    height: 100,
                  ),
                  Image.asset(
                    "assets/images/kalp.png",
                    height: 100,
                  ),
                  Image.asset(
                    "assets/images/yildiz.png",
                    height: 100,
                  )
                ],
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
