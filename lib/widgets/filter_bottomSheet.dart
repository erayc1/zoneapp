import 'package:flutter/material.dart';
import '../utils/colors.dart';

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Filtre',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Temizle',
                    style: TextStyle(color: ColorUtils.pink),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Bana Göster',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterChip(
                    label: const Text('Kız'), onSelected: (bool value) {}),
                FilterChip(
                    label: const Text('Erkek'), onSelected: (bool value) {}),
                FilterChip(
                    label: const Text('Diğer'), onSelected: (bool value) {}),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: ColorUtils.pink, width: 2),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  labelText: 'Beşiktaş,Balmumcu',
                  labelStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.location_on, color: ColorUtils.pink),
                  suffixIcon:
                      Icon(Icons.arrow_forward_ios, color: ColorUtils.pink),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Mesafe',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            Slider(
              value: 15,
              min: 0,
              max: 100,
              divisions: 100,
              label: '15km',
              activeColor: ColorUtils.pink,
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            const Text(
              'Yaş Aralığı',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            RangeSlider(
              values: const RangeValues(20, 40),
              min: 18,
              max: 100,
              divisions: 100,
              activeColor: ColorUtils.pink,
              labels: const RangeLabels('20', '40'),
              onChanged: (RangeValues values) {},
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorUtils.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Uygula',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
