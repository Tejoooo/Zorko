import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:google_maps_webservice/directions.dart';



class RestaurantModel {
  final String name;
  final String address;
  final double longitude;
  final double latitude;
  final String image; // New property for the image
  final bool open;
  RestaurantModel({
    required this.name,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.image, // Initialize the image property
    required this.open, // Initialize the image property
  
  });
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

  void _addMarkers() {
    List<RestaurantModel> restaurants = [
      RestaurantModel(
        name: 'Restaurant 1',
        address: 'Address 1',
        latitude: -23.550519,
        longitude: -46.633309,
        image: 'h11.jpg',
        open: true, // Sample image name
      ),
      RestaurantModel(
        name: 'Restaurant 2',
        address: 'Address 2',
        latitude: -23.5629,
        longitude: -46.6544,
        image: 'h11.jpg', 
        open: false,// Sample image name
      ),
      RestaurantModel(
        name: 'Restaurant 3',
        address: 'Address 3',
        latitude: -13.5629,
        longitude: -26.6544,
        image: 'h11.jpg',
        open: true, // Sample image name
      ),
      // Add more restaurants as needed
    ];

    for (RestaurantModel restaurant in restaurants) {
      _addMarker(restaurant, LatLng(restaurant.latitude, restaurant.longitude));
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
            markers: Set.from(markers),
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
