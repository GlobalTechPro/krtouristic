import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:flutter/services.dart' show rootBundle;
import 'package:maps_launcher/maps_launcher.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

class GoogleProvider {
  late String _darkMapStyle;
  late String _lightMapStyle;
  final Map<String, Marker> markers = {};
  MinMaxZoomPreference zoomPref = const MinMaxZoomPreference(9.0, 18.0);
  Completer<GoogleMapController> _mapController = Completer();
  final CameraPosition currentCityPosition = CameraPosition(
    target: LatLng(globals.cityData["lat"], globals.cityData["lng"]),
    zoom: 11.0,
  );

  GoogleProvider() {
    setMapStyle();
  }

  void onMapCreated(GoogleMapController controller) async {
    _mapController.complete(controller);
    _mapController = Completer();
    setMapStyle();
  }

  Future<void> setMapStyle({String mapStyle = 'dark'}) async {
    _darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
    _lightMapStyle =
        await rootBundle.loadString('assets/map_styles/light.json');
    final controller = await _mapController.future;
    switch (mapStyle) {
      case 'dark':
        controller.setMapStyle(_darkMapStyle);
        break;
      case 'light':
        controller.setMapStyle(_lightMapStyle);
        break;
      default:
        controller.setMapStyle(_darkMapStyle);
        break;
    }
    // final theme = WidgetsBinding.instance.window.platformBrightness;
    // if (theme == Brightness.dark) {
    //   controller.setMapStyle(_darkMapStyle);
    // } else {
    //   controller.setMapStyle(_lightMapStyle);
    // }
  }

  static Future<void> openMapApp(double latitude, double longitude) async {
    final googleUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
    } else {
      MapsLauncher.launchCoordinates(latitude, longitude);
    }
  }

// @TODO: implement switching the theme from/to light/dark and change the map theme accordingly
// @override
// void didChangePlatformBrightness() {
//   setState(() {
//     _setMapStyle();
//   });
// }

  // GoogleMap initGoogleMapWidget() {
  // return GoogleMap(
  //   mapType: MapType.normal,
  //   minMaxZoomPreference: const MinMaxZoomPreference(9.0, 18.0),
  //   onMapCreated: _onMapCreated,
  //   initialCameraPosition: _currentCityPosition,
  //   zoomGesturesEnabled: true,
  //   tiltGesturesEnabled: true,
  //   myLocationEnabled: true,
  //   markers: markers.values.toSet(),
  //   onTap: (latLng) {},
  // );
  // }

}
