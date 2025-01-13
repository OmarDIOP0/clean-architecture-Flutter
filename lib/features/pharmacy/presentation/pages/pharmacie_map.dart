import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pharma_plus/core/constants/status.dart';
import 'package:pharma_plus/features/pharmacy/presentation/bloc/pharmacy_bloc.dart';  // Ton PharmacyBloc
import 'package:url_launcher/url_launcher.dart';
import 'package:pharma_plus/models/pharmacy/pharmacy.dart';
import 'package:geolocator/geolocator.dart';

import '../bloc/localisation_bloc.dart';

class MapPharmacy extends StatefulWidget {
  const MapPharmacy({super.key});

  @override
  State<MapPharmacy> createState() => _MapPharmacyState();
}

class _MapPharmacyState extends State<MapPharmacy> {
  @override
  void initState() {
    super.initState();
    context.read<LocationBloc>().add(GetUserLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent
    ));

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState is LocationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (locationState is LocationError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      context.read<LocationBloc>().add(GetUserLocationEvent());
                    },
                  ),
                  Text(
                    locationState.errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LocationBloc>().add(GetUserLocationEvent());
                    },
                    child: const Text('Try again'),
                  ),
                ],
              ),
            );
          } else if (locationState is LocationLoaded) {
            final userLocation = locationState.userLocation;

            return BlocBuilder<PharmacyBloc, PharmacyState>(
              builder: (context, pharmacyState) {
                if (pharmacyState is PharmacyLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (pharmacyState is PharmacyError) {
                  return Center(
                    child: Text('Error: ${pharmacyState.message}', style: const TextStyle(color: Colors.red)),
                  );
                } else if (pharmacyState is PharmacyLoaded) {
                  final pharmacies = pharmacyState.pharmacies;

                  return Stack(
                    children: [
                      FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(userLocation.latitude, userLocation.longitude),
                          initialZoom: 16,
                          minZoom: 5,
                          maxZoom: 19,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          ),
                          MarkerLayer(
                            markers: pharmacies.map((pharmacy) {
                              return Marker(
                                point: LatLng(pharmacy.lattitude ?? 0.0, pharmacy.longitude ?? 0.0),
                                width: 80,
                                height: 80,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.local_pharmacy,
                                    color: Colors.green[600],
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (ctx) => Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            Text(pharmacy.title ?? 'No name'),
                                            Text(pharmacy.location ?? 'No address'),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(userLocation.latitude, userLocation.longitude),
                                width: 80,
                                height: 80,
                                child: IconButton(
                                  icon: const Icon(Icons.location_history, size: 50),
                                  color: Colors.blue,
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                      ),
                                      builder: (ctx) => Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            const Row(
                                              children: [
                                                Icon(
                                                  Icons.location_history,
                                                  color: Colors.blue,
                                                  size: 30,
                                                ),
                                                SizedBox(width: 10),
                                                Text('My Location'),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            Text('Latitude: ${userLocation.latitude}, Longitude: ${userLocation.longitude}'),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Ajouter un widget pour étendre le haut et le bas, par exemple :
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 80, // Hauteur de la partie supérieure
                        child: Container(
                          color: Colors.white.withOpacity(0.1),
                          child: const Center(child: Text('')),
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: Text('No pharmacies found.'));
              },
            );
          }
          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }
}


