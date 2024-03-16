import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/common_widgets/custom_app_bar.dart';
import 'package:weather_app/controller/bloc/get_weather_data_bloc.dart';
import 'package:weather_app/controller/bloc/get_weather_data_event.dart';
import 'package:weather_app/controller/bloc/get_weather_data_state.dart';
import 'package:weather_app/view/data_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _currentLocationFuture = _getCurrentLocation();
    super.initState();
  }

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
    _getAddressFromLatLng();
  }

  Position? _currentPosition;
  String _currentAddress = "";
  late Future<void> _currentLocationFuture;

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}";
        log("Current Address$_currentAddress");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Weather Data"),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: _currentLocationFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Fetching Your Current Location");
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (BuildContext context) {
                                    return GetWeatherDataBloc();
                                  },
                                  child: DataScreen(
                                      currentAddress: _currentAddress)),
                            ));
                      },
                      child: const Text("Fetch Data for this location"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
