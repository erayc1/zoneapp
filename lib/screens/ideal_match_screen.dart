import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zonne/screens/passions_selection.dart';

import '../utils/colors.dart';

class IdealMatchScreen extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController hakkindaController;
  final DateTime? selectedDate;
  final String selectedGender;

  const IdealMatchScreen({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.hakkindaController,
    this.selectedDate,
    required this.selectedGender,
  });

  @override
  _IdealMatchScreenState createState() => _IdealMatchScreenState();
}

class _IdealMatchScreenState extends State<IdealMatchScreen> {
  final List<String> selectedOptions = [];

  void toggleSelection(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Arzu Edilen İlişki',
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 1.1,
                children: [
                  _buildMatchOption('Aşk', 'assets/images/ask.png'),
                  _buildMatchOption('Arkadaşlık', 'assets/images/arkadas.png'),
                  _buildMatchOption('Eğlence', 'assets/images/eglence.png'),
                  _buildMatchOption('İş', 'assets/images/is.png'),
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
                      () => PassionsSelectionScreen(
                            nameController: widget.nameController,
                            phoneController: widget.phoneController,
                            hakkindaController: widget.hakkindaController,
                            selectedDate: widget.selectedDate,
                            selectedGender: widget.selectedGender,
                            selectedOptions: selectedOptions,
                          ),
                      transition: Transition.rightToLeft),
                  child: const Text(
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
          ],
        ),
      ),
    );
  }

  Widget _buildMatchOption(String title, String imagePath) {
    final bool selected = selectedOptions.contains(title);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: selected ? ColorUtils.pink : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () => toggleSelection(title),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 10),
            Text(title,
                style: TextStyle(
                    color: selected ? ColorUtils.darkBlue : Colors.grey,
                    fontFamily: 'Poppins')),
            if (selected) const Icon(Icons.check, color: ColorUtils.pink),
          ],
        ),
      ),
    );
  }
}
