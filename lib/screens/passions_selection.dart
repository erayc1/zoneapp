import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zonne/screens/add_photos_screen.dart';

import '../utils/colors.dart';

class PassionsSelectionScreen extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController hakkindaController;
  final DateTime? selectedDate;
  final String selectedGender;
  final List<String> selectedOptions;

  const PassionsSelectionScreen({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.hakkindaController,
    this.selectedDate,
    required this.selectedGender,
    required this.selectedOptions,
  });

  @override
  _PassionsSelectionScreenState createState() =>
      _PassionsSelectionScreenState();
}

class _PassionsSelectionScreenState extends State<PassionsSelectionScreen> {
  final Set<String> _selectedPassions = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'İlgi Alanların',
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: TextButton(
              onPressed: () => Get.to(
                  () => AddPhotosScreen(
                        nameController: widget.nameController,
                        phoneController: widget.phoneController,
                        hakkindaController: widget.hakkindaController,
                        selectedDate: widget.selectedDate,
                        selectedGender: widget.selectedGender,
                        selectedOptions: widget.selectedOptions,
                        selectedPassions: _selectedPassions.toList(),
                      ),
                  transition: Transition.rightToLeft),
              child: const Text(
                'Atla',
                style: TextStyle(
                  color: ColorUtils.pink,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'İlgi alanlarınızdan birkaçını seçin ve herkesin neye tutkulu olduğunuzu bilmesini sağlayın.',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 10,
                childAspectRatio: 3,
                children: [
                  _buildPassionChip('Fotoğraf', Icons.photo_camera),
                  _buildPassionChip('Alışveriş', Icons.shopping_bag),
                  _buildPassionChip('Karaoke', Icons.mic),
                  _buildPassionChip('Yoga', Icons.self_improvement),
                  _buildPassionChip('Gastronomi', Icons.restaurant),
                  _buildPassionChip('Tenis', Icons.sports_tennis),
                  _buildPassionChip('Koşmak', Icons.directions_run),
                  _buildPassionChip('Yüzmek', Icons.pool),
                  _buildPassionChip('Resim', Icons.brush),
                  _buildPassionChip('Traveling', Icons.flight),
                  _buildPassionChip('Paraşüt', Icons.paragliding),
                  _buildPassionChip('Music', Icons.music_note),
                ],
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
                  onPressed: () => Get.to(
                      () => AddPhotosScreen(
                            nameController: widget.nameController,
                            phoneController: widget.phoneController,
                            hakkindaController: widget.hakkindaController,
                            selectedDate: widget.selectedDate,
                            selectedGender: widget.selectedGender,
                            selectedOptions: widget.selectedOptions,
                            selectedPassions: _selectedPassions.toList(),
                          ),
                      transition: Transition.rightToLeft),
                  child: const Text(
                    'Devam Et',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.white,
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

  Widget _buildPassionChip(String label, IconData icon) {
    final bool selected = _selectedPassions.contains(label);
    return FilterChip(
      showCheckmark: false,
      label: Text(label),
      avatar: Icon(
        icon,
        color: selected ? Colors.white : ColorUtils.pink,
      ),
      selected: selected,
      onSelected: (bool value) {
        setState(() {
          if (value) {
            _selectedPassions.add(label);
          } else {
            _selectedPassions.remove(label);
          }
        });
      },
      backgroundColor: Colors.white,
      selectedColor: ColorUtils.pink,
      labelStyle: TextStyle(
        color: selected ? Colors.white : ColorUtils.pink,
        fontFamily: 'Poppins',
      ),
    );
  }
}
