import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// Usada quando a localização do usuário não está disponível
const LatLng _fallbackLocation = LatLng(-22.01, -47.89);

// Mapa destaca parques e complexos esportivos e reduz elementos que não interessam para a feature 
const String _outdoorHighlightMapStyle = '''
[
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [{ "color": "#a8ddb0" }, { "saturation": 40 }, { "visibility": "on" }]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels",
    "stylers": [{ "visibility": "on" }]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [{ "color": "#0b6e2f" }, { "weight": 2 }]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.icon",
    "stylers": [{ "saturation": 60 }, { "lightness": -10 }, { "visibility": "on" }]
  },
  {
    "featureType": "poi.sports_complex",
    "elementType": "geometry.fill",
    "stylers": [{ "color": "#a8ddb0" }, { "visibility": "on" }]
  },
  {
    "featureType": "poi.sports_complex",
    "elementType": "labels",
    "stylers": [{ "visibility": "on" }]
  },
  {
    "featureType": "poi.sports_complex",
    "elementType": "labels.text.fill",
    "stylers": [{ "color": "#0b6e2f" }, { "weight": 2 }]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry.fill",
    "stylers": [{ "color": "#d3f2d6" }]
  },
  {
    "featureType": "poi.business",
    "stylers": [{ "visibility": "off" }]
  },
  {
    "featureType": "poi.medical",
    "stylers": [{ "visibility": "off" }]
  },
  {
    "featureType": "poi.government",
    "stylers": [{ "visibility": "off" }]
  },
  {
    "featureType": "poi.school",
    "stylers": [{ "visibility": "off" }]
  },
  {
    "featureType": "poi.attraction",
    "stylers": [{ "visibility": "simplified" }]
  },
  {
    "featureType": "transit",
    "stylers": [{ "visibility": "off" }]
  }
]
''';

class OutdoorExerciseMapPage extends StatefulWidget {
  const OutdoorExerciseMapPage({super.key});

  @override
  State<OutdoorExerciseMapPage> createState() => _OutdoorExerciseMapPageState();
}

class _OutdoorExerciseMapPageState extends State<OutdoorExerciseMapPage> {
  GoogleMapController? _mapController;
  LatLng _currentLocation = _fallbackLocation;
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
  }

  Future<void> _loadCurrentLocation() async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _isLoadingLocation = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        setState(() => _isLoadingLocation = false);
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLoadingLocation = false;
      });
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLocation, 14),
      );
    } catch (_) {
      setState(() => _isLoadingLocation = false);
    }
  }

  Future<void> _openInGoogleMaps() async {
    final Uri mapsUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1'
      '&query=parques+e+academias+ao+ar+livre+perto+de+'
      '${_currentLocation.latitude},${_currentLocation.longitude}',
    );

    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClearScaffoldView(
      appBarTitle: Text(
          'AGENDA',
          style: GoogleFonts.montserrat(
            fontSize: 28,
            height: 1.25,
            color: AppColors.darkGreen,
          ),
        ),
      child: Column(
        children: [
          const SizedBox(height: 56),
          Text(
            'Se exercitar em parques e áreas verdes reduz o estresse, '
            'melhora o humor e traz os benefícios extras do contato com a '
            'natureza. Explore o mapa e encontre um lugar perto de você:',
            textAlign: TextAlign.center,
            style: GoogleFonts.jetBrainsMono(
              textStyle: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _currentLocation,
                      zoom: 14,
                    ),
                    style: _outdoorHighlightMapStyle,
                    onMapCreated: (controller) => _mapController = controller,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                  ),
                  if (_isLoadingLocation)
                    const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.darkGreen,
                        ),
                      ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          CustomSolidButton(
            text: 'ABRIR NO GOOGLE MAPS',
            onPressed: _openInGoogleMaps,
            gradientColors: AppGradients.greenGradient,
            fontSize: 18,
            width: double.infinity,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}