// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        "location Permissions are permentaly dissabled please enable");
  }
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  debugPrint("1");
  if (!serviceEnabled) {
  debugPrint("2");
    return Future.error('Location Serices are disabled');
  }
  // LocationPermission permission = await Geolocator.checkPermission();
  // debugPrint("3");
  // if (permission == LocationPermission.denied) {
  //   permission = await Geolocator.requestPermission();
  //   if (permission == LocationPermission.denied) {
  //     return Future.error("location permission are denied");
  //   }
  // }

  return await Geolocator.getCurrentPosition();
}
