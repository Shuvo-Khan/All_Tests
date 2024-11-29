import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  Timer? _latestLocationTimer;
  final Completer<GoogleMapController> _controller = Completer();
  final List<LatLng> _polylineUpdates = [];
  late LatLng _currentLocation;
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _locationUpdates();
  }

  @override
  void dispose() {
    _latestLocationTimer?.cancel();
    super.dispose();
  }

  Future<Position> getLocationPermission() async {
    bool serviceEnable;
    LocationPermission permission;
    serviceEnable = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission are denied');
      }
      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openLocationSettings();
        return Future.error('Location Permission are denied Permanently');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _animateToLocation(LatLng location) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: location, zoom: 14),
    ));
  }

  void _locationUpdates() {
    _latestLocationTimer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) async {
        Position position = await getLocationPermission();
        LatLng newLocation = LatLng(position.latitude, position.longitude);

        _addPolyline(_currentLocation, newLocation);
        _addMarker(newLocation, 'new-location');
        _animateToLocation(newLocation);
        setState(
          () {
            _currentLocation = newLocation;
          },
        );
      },
    );
  }

  Future<void> _getCurrentLocation() async {
    Position position = await getLocationPermission();
    _currentLocation = LatLng(position.latitude, position.longitude);

    _addMarker(_currentLocation, 'current-location');
    _animateToLocation(_currentLocation);
  }

  void _addMarker(LatLng position, String id) {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId(id),
        position: position,
        infoWindow: InfoWindow(
          title: "My Current Location",
          snippet: "${position.latitude}, ${position.longitude}",
        ),
      ),
    );
  }

  void _addPolyline(LatLng oldLocation, LatLng newLocation) {
    _polylineUpdates.add(newLocation);
    _polylines.add(
      Polyline(
        polylineId: const PolylineId("polyline1"),
        points: _polylineUpdates,
        color: Colors.blue,
        width: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Google maps",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[300],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.335164, -122.057268),
          // Default position before loading
          zoom: 10,
        ),
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Position position = await getLocationPermission();
          LatLng location = LatLng(position.latitude, position.longitude);
          _animateToLocation(location);
        },
        child: const Icon(
          Icons.my_location,
          size: 20,
        ),
      ),
    );
  }
}
