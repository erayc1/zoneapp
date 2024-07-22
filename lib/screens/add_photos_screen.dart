import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zonne/screens/find_friends_screen.dart';

import '../functions/geolocator_func.dart';
import '../utils/colors.dart';

class AddPhotosScreen extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController hakkindaController;
  final DateTime? selectedDate;
  final String selectedGender;
  final List<String> selectedOptions;
  final List<String> selectedPassions;

  const AddPhotosScreen({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.hakkindaController,
    this.selectedDate,
    required this.selectedGender,
    required this.selectedOptions,
    required this.selectedPassions,
  });

  @override
  _AddPhotosScreenState createState() => _AddPhotosScreenState();
}

class _AddPhotosScreenState extends State<AddPhotosScreen> {
  final List<XFile?> _selectedImages = List<XFile?>.filled(6, null);
  final ImagePicker _picker = ImagePicker();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool isLoading = false;

  Future<void> _pickImage(int index) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImages[index] = image;
      });
    }
  }

  Future<void> saveUserInfo() async {
    setState(() {
      isLoading = true;
    });

    try {
      Position position = await getCurrentLocation();
      List<String> photoUrls = [];
      for (XFile? image in _selectedImages) {
        if (image != null) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          Reference storageReference = _storage.ref().child('images/$fileName');
          UploadTask uploadTask = storageReference.putFile(File(image.path));
          TaskSnapshot taskSnapshot = await uploadTask;
          String downloadUrl = await taskSnapshot.ref.getDownloadURL();
          photoUrls.add(downloadUrl);
        }
      }

      await _firestore.collection('kullanici_bilgiler').add({
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'name': widget.nameController.text.trim(),
        'phone': widget.phoneController.text.trim(),
        'hakkinda': widget.hakkindaController.text.trim(),
        'birthday': widget.selectedDate,
        'selectedGender': widget.selectedGender,
        'selectedOptions': widget.selectedOptions,
        'selectedPassions': widget.selectedPassions,
        'photoUrls': photoUrls,
        'lat': position.latitude,
        'lon': position.longitude,
        'createdAt': Timestamp.now(),
      });

      Get.to(
        () => const FindFriendsScreen(),
        transition: Transition.rightToLeft,
      );
    } catch (e) {
      Get.snackbar('Hata', e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'En İyi Fotoğraflarını Ekle',
          style: TextStyle(
              color: Colors.black, fontFamily: 'Poppins', fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
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
        padding: const EdgeInsets.only(right: 30.0, left: 30.0, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Daha yüksek miktarda günlük eşleşme elde etmek için en iyi fotoğraflarınızı ekleyin',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.builder(
                itemCount: _selectedImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 25,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return _buildAddPhotoTile(index);
                },
              ),
            ),
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorUtils.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    await saveUserInfo();
                  },
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          'Onayla',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAddPhotoTile(int index) {
    return DottedBorder(
      color: ColorUtils.pink,
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      dashPattern: const [9, 5],
      strokeWidth: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: _selectedImages[index] == null
              ? IconButton(
                  icon: const Icon(Icons.add, color: ColorUtils.pink, size: 30),
                  onPressed: () => _pickImage(index),
                )
              : Image.file(
                  File(_selectedImages[index]!.path),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
