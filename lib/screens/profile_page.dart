import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx/authentication/auth_controller.dart';
import '../getx/user_profile_controller.dart';
import '../utils/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final UserProfileController profileController =
        Get.put(UserProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ayarlar',
          style: TextStyle(
              color: Colors.black, fontFamily: 'Poppins', fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 8, bottom: 8),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade400)),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: ColorUtils.pink,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Obx(() {
          if (profileController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: profileController.photoUrl.value.isNotEmpty
                    ? NetworkImage(profileController.photoUrl.value)
                    : const AssetImage('assets/images/profile.png')
                        as ImageProvider,
              ),
              const SizedBox(height: 10),
              Text(
                profileController.name.value,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 30),
              ListTile(
                leading: const Icon(Icons.person, color: ColorUtils.pink),
                title: const Text('Profili Düzenle',
                    style: TextStyle(fontFamily: 'Poppins')),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: ColorUtils.pink),
                onTap: () {},
              ),
              ListTile(
                leading:
                    const Icon(Icons.notifications, color: ColorUtils.pink),
                title: const Text('Bildirimler',
                    style: TextStyle(fontFamily: 'Poppins')),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: ColorUtils.pink),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.security, color: ColorUtils.pink),
                title: const Text('Güvenlik',
                    style: TextStyle(fontFamily: 'Poppins')),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: ColorUtils.pink),
                onTap: () {},
              ),
              SwitchListTile(
                title: const Text('Koyu Mod',
                    style: TextStyle(fontFamily: 'Poppins')),
                value: false,
                onChanged: (bool value) {},
                secondary: const Icon(Icons.dark_mode, color: ColorUtils.pink),
              ),
              ListTile(
                leading: const Icon(Icons.group_add, color: ColorUtils.pink),
                title: const Text('Arkadaşlarını Davet Et',
                    style: TextStyle(fontFamily: 'Poppins')),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: ColorUtils.pink),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: ColorUtils.pink),
                title: const Text('Çıkış Yap',
                    style: TextStyle(fontFamily: 'Poppins')),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: ColorUtils.pink),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.all(20.0),
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.logout, color: ColorUtils.pink),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Çıkış Yapmak İstediğine Emin Misin?',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: ColorUtils.pink),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('İptal',
                                      style: TextStyle(
                                          color: ColorUtils.pink,
                                          fontFamily: 'Poppins')),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: ColorUtils.pink),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      backgroundColor: ColorUtils.pink),
                                  onPressed: () async {
                                    Get.back();
                                    await authController.signOut();
                                  },
                                  child: const Text('Çıkış Yap',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins')),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Obx(() {
                              if (authController.isLoading.value) {
                                return const CircularProgressIndicator();
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
