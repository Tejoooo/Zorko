import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zorko/components/snackBar.dart';
import 'package:zorko/constants.dart';
import 'package:http/http.dart' as http;


class RestaurantModel {
  final String name;
  final String id;
  final String address;
  final double longitude;
  final double latitude;
  final String image; // New property for the image
  final bool open;

  RestaurantModel({
    required this.name,
    required this.id,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.image,
    required this.open, 
  
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id:json['id'].toString(),
      name: json['name'],
      address: json['address'],
      longitude: json['longitude'] ?? 73.900,
      latitude: json['latitude'] ?? 23.8989,
      image: '', 
      open: true, 
    );
  }
}

class HeatMaps extends StatefulWidget {
  const HeatMaps({Key? key}) : super(key: key);

  @override
  State<HeatMaps> createState() => _HeatMapsState();
}

class _HeatMapsState extends State<HeatMaps> {
  late GoogleMapController mapController;

  LatLng _center = LatLng(-23.5557714, -46.6395571);
  double zoom = 11.0;
  bool _isLoading = false;

  Set<Marker> markers = Set();

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() async{
    final response = await http.get(Uri.parse(backendURL+"api/outlets/"));
    if (response.statusCode == 200){
      print(jsonDecode(response.body));
      List<RestaurantModel> restaurants = (jsonDecode(response.body) as List)
      .map((data) => RestaurantModel.fromJson(data))
      .toList();

    for (RestaurantModel restaurant in restaurants) {
      _addMarker(restaurant, LatLng(restaurant.latitude, restaurant.longitude));
    }
    } else{
      ErrorSnackBar(context, "un able to fetch outlets");
    }
  }

  void _addMarker(RestaurantModel restaurant, LatLng position) {
    markers.add(
      Marker(
        markerId: MarkerId(restaurant.name + position.longitude.toString() + position.latitude.toString() + restaurant.address),
        position: position,
        onTap: () {
          _onMarkerTapped(restaurant);
        },
        infoWindow: InfoWindow(
          title: restaurant.name,
          snippet: restaurant.address,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  void _onMarkerTapped(RestaurantModel restaurant) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width:  MediaQuery.of(context).size.width.clamp(150, double.infinity),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                restaurant.name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                restaurant.address,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              if (restaurant.open)
              Text(
                'Open',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.green,
                ),
              ),
               if (!restaurant.open)
              Text(
                'Closed',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 8.0),
              Image.asset(
                'assets/${restaurant.image}', // Assuming the images are in the assets/images folder
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ],
          ),
        );
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: zoom,
            ),
            markers: markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle floating action button press
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
