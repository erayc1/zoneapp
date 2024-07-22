import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GoogleMapController? mapController;
  Rx<LatLng> center = const LatLng(41.0082, 28.9784).obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  late AnimationController rippleController;
  late Animation<double> rippleAnimation;

  @override
  void onInit() {
    super.onInit();
    rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    rippleAnimation =
        Tween<double>(begin: 0, end: 50).animate(rippleController);
    fetchUserLocation();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> fetchUserLocation() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('kullanici_bilgiler')
            .where('userId', isEqualTo: currentUser.uid)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          DocumentSnapshot userDoc = userSnapshot.docs.first;
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          center.value = LatLng(userData['lat'], userData['lon']);
          BitmapDescriptor userIcon =
              await _createCustomMarkerBitmap(userData['photoUrls'][0]);
          markers.add(
            Marker(
              markerId: const MarkerId('userLocation'),
              position: center.value,
              infoWindow: const InfoWindow(
                title: 'Kullanıcı Lokasyonu',
              ),
              icon: userIcon,
            ),
          );
          mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: center.value, zoom: 10.0),
            ),
          );
          fetchOtherUsersLocations();
        }
      }
    } catch (e) {
      Get.snackbar('Hata', e.toString());
    }
  }

  Future<void> fetchOtherUsersLocations() async {
    try {
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
          .collection('kullanici_bilgiler')
          .get();

      if (usersSnapshot.docs.isNotEmpty) {
        for (var doc in usersSnapshot.docs) {
          Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
          if (userData['userId'] != FirebaseAuth.instance.currentUser!.uid) {
            BitmapDescriptor userIcon =
                await _createCustomMarkerBitmap(userData['photoUrls'][0]);
            markers.add(
              Marker(
                markerId: MarkerId(userData['userId']),
                position: LatLng(userData['lat'], userData['lon']),
                infoWindow: InfoWindow(
                  title: userData['name'],
                ),
                icon: userIcon,
              ),
            );
          }
        }
      }
    } catch (e) {
      Get.snackbar('Hata', e.toString());
    }
  }

  Future<BitmapDescriptor> _createCustomMarkerBitmap(String imageUrl) async {
    final http.Response response = await http.get(Uri.parse(imageUrl));
    final Uint8List markerImageBytes = response.bodyBytes;

    final ui.Codec codec = await ui.instantiateImageCodec(
      markerImageBytes,
      targetWidth: 100,
      targetHeight: 100,
    );
    final ui.FrameInfo fi = await codec.getNextFrame();
    final ui.Image image = fi.image;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..isAntiAlias = true;
    final double radius = 50.0;

    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      paint,
    );

    canvas.clipPath(
      Path()
        ..addOval(Rect.fromCircle(
          center: Offset(radius, radius),
          radius: radius,
        )),
    );

    canvas.drawImageRect(
      image,
      Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTRB(0, 0, 2 * radius, 2 * radius),
      paint,
    );

    final ui.Picture picture = pictureRecorder.endRecording();
    final ui.Image img = await picture.toImage(
      (2 * radius).toInt(),
      (2 * radius).toInt(),
    );
    final ByteData? byteData = await img.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(resizedMarkerImageBytes);
  }

  @override
  void onClose() {
    rippleController.dispose();
    super.onClose();
  }
}
