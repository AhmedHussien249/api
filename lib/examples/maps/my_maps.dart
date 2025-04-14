import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MyMaps extends StatefulWidget {
  const MyMaps({super.key});

  @override
  State<MyMaps> createState() => _MyMapsState();
}

class _MyMapsState extends State<MyMaps> {
  Set<Marker> markers = {};
  LatLng? currentLocation;
  String address = "Address";
  final _controller = Completer<GoogleMapController>();


  @override
  void initState() {
    _determinePosition();

    super.initState();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final location = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude, location.longitude);
    print("********");
    print(placemarks.first.country);
    print(placemarks.first.name);
    print(placemarks.first.administrativeArea);
    print(placemarks.first.street);
    print(placemarks.first.locality);
    print(placemarks.first.postalCode);
    print(placemarks.first.thoroughfare);
    address ="${placemarks.first.country}-${placemarks.first.name}-${placemarks.first.administrativeArea}";

    markers.add(Marker(
      markerId: MarkerId("1"),
      position: LatLng(location.latitude, location.longitude),
    ));
    currentLocation = LatLng(location.latitude, location.longitude);
    setState(() {});

    final mapController = await _controller.future;
    mapController.animateCamera(CameraUpdate.newLatLng(currentLocation!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: address.isNotEmpty
          ? AppBar(
              title: Text(address),
            )
          : null,
      floatingActionButton: FloatingActionButton(onPressed: () {
        MapsLauncher.launchCoordinates(37.4220041, -122.0862462);
      }),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              markers: markers,
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              onTap: (location) async {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                    location.latitude, location.longitude);
                print("********");
                print(placemarks.first.country);
                print(placemarks.first.name);
                print(placemarks.first.administrativeArea);
                print(placemarks.first.street);
                print(placemarks.first.locality);
                print(placemarks.first.postalCode);
                print(placemarks.first.thoroughfare);
                address ="${placemarks.first.country}-${placemarks.first.name}-${placemarks.first.administrativeArea}";

                markers.add(Marker(
                  markerId: MarkerId("1"),
                  position: location,
                ));
                setState(() {});
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(31.11573109793634, 30.933508846905532),
                  zoom: 14)),
    );
  }
}
