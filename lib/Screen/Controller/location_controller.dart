import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController
{
  Rx<MapType> m = MapType.normal.obs;

  List<MapType> l1 = <MapType>[
    MapType.normal,
    MapType.hybrid,
    MapType.satellite,
    MapType.none,
    MapType.terrain,
  ].obs;

  RxDouble lat = 21.1702.obs;
  RxDouble lon = 72.8311.obs;
  Rx<Position> position = Position(accuracy: 0,altitude: 0,heading: 0,latitude: 0,longitude: 0,speed: 0,speedAccuracy: 0,timestamp: DateTime.now(),floor: 0).obs;
  Rx<LatLng> c =LatLng(21.1702, 72.8311).obs;
  Rx<Completer<GoogleMapController>> completer = Completer<GoogleMapController>().obs;
  Future<Future<PermissionStatus>?> CheckPermission() async
  {
    var status = await Permission.location.status;
    if(status.isDenied)
    {
      return Permission.location.request();
    }
    else
    {
      return null;
    }
    update();
  }

  void getCurrentLocation()
  async {
    position.value = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    c.value = LatLng(position.value.latitude, position.value.longitude);
    update();
  }

  RxSet<Marker> Markers()
  {
    return {
      Marker(
        markerId: MarkerId("Current Position"),
        position: LatLng(position.value.latitude,position.value.longitude),
        infoWindow: InfoWindow(title: "Current Position"),
      )
    }.obs;
  }


}