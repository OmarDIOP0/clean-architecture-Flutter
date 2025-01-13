import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pharma_plus/models/pharmacy/pharmacy.dart';
import 'package:pharma_plus/services/pharmacy/pharmacy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _userLocation;
  bool _isLocationLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar('Les services de localisation sont désactivés.');
      return;
    }
    PermissionStatus permission = await Permission.location.status;
    if (permission.isDenied) {
      permission = await Permission.location.request();
      if (permission.isDenied) {
        _showSnackBar('La permission de localisation est refusée.');
        return;
      }
    }
    if (permission.isPermanentlyDenied) {
      _showSnackBar('La permission de localisation est définitivement refusée. Veuillez l’activer dans les paramètres.');
      return;
    }
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
      _isLocationLoading = false;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PharmacyService().getAllPharmacies(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Erreur lors du chargement des données de pharmacie"));
        }

        if (snapshot.connectionState == ConnectionState.waiting || _isLocationLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          var data = snapshot.data as List<Pharmacy>;

          return FlutterMap(
            options: MapOptions(
              initialCenter: _userLocation ?? const LatLng(14.6950110, -17.4580211), 
              initialZoom: 16,
              minZoom: 5,
              maxZoom: 19,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: List.generate(
                  data.length,
                      (index) => Marker(
                    point: LatLng(data[index].lattitude, data[index].longitude),
                    width: 80,
                    height: 80,
                    rotate: true,
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 50,
                      color: Colors.green[600],
                    ),
                  ),
                ),
              ),
              if (_userLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _userLocation!,
                      width: 80,
                      height: 80,
                      rotate: true,
                      child: const Icon(
                        Icons.my_location,
                        size: 50,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () async {
                      final url = Uri.parse('https://openstreetmap.org/copyright');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'Impossible d\'ouvrir $url';
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Center(child: Text("Aucune pharmacie trouvée"));
        }
      },
    );
  }
}
