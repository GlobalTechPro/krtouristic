import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krtouristic/model/core/location.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:krtouristic/views/sights/sight_details_screen.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class MapHelper {
  static Future<Map<MarkerId, Marker>> createMarkers(locations, context) async {
    final Map<MarkerId, Marker> markers = {};
    final BitmapDescriptor markerBitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/sight_map.png',
    );
    for (final Location location in locations) {
      final markerId =
      MarkerId('${location.lat.toString()}${location.lng.toString()}');
      final marker = Marker(
        markerId: markerId,
        position: LatLng(location.lat, location.lng),
        icon: markerBitmap,
        infoWindow: InfoWindow(
          title: location.title,
          snippet: location.address,
        ),
      );
      markers[markerId] = marker;
    }

    return markers;
  }

  static Future<Map<MarkerId, Marker>> createLinkedMarkers(locations, context) async {
    final Map<MarkerId, Marker> markers = {};
    final BitmapDescriptor markerBitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/sight_map.png',
    );
    for (final Location location in locations) {
      final markerId =
      MarkerId('${location.lat.toString()}${location.lng.toString()}');
      /*
      // adding markers with the network images
      Uint8List bytes = (await NetworkAssetBundle(Uri.parse(location.headImage.url))
          .load(location.headImage.url))
          .buffer
          .asUint8List();
       */
      final marker = Marker(
        markerId: markerId,
        position: LatLng(location.lat, location.lng),
        icon: markerBitmap,
        // icon: BitmapDescriptor.fromBytes(bytes),
        infoWindow: InfoWindow(
          title: location.title,
          snippet: location.address,
          onTap: () {
            Route sightDetailsRoute = MaterialPageRoute(
              builder: (context) =>
                  SightDetailsScreen(sightId: location.firebaseId ?? ''),
            );
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.push(
              context,
              sightDetailsRoute,
            );
          },
        ),
      );
      markers[markerId] = marker;
    }

    return markers;
  }

  static Polyline _createPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId(polylineCoordinates.toString());
    return Polyline(
      polylineId: id,
      geodesic: true,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 4,
    );
  }

  static Future<Map<PolylineId, Polyline>> buildTourPolylines(
      {required LatLng origin, required LatLng destination}) async {
    Map<PolylineId, Polyline> polylines = {};
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      globals.googleApiKey,
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.walking,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      // print(result.errorMessage);
    }
    final polyline = _createPolyLine(polylineCoordinates);
    polylines[polyline.polylineId] = polyline;

    return polylines;
  }

  static Future<Map<MarkerId, Marker>> createTourMarkers(List<Location> locations) async {
    final Map<MarkerId, Marker> markers = {};
    BitmapDescriptor iconBitmap;

    BitmapDescriptor regularIconBitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/sight_map.png',
    );
    final BitmapDescriptor startMarkerBitmap =
    await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/start_icon.png',
    );
    final BitmapDescriptor finishMarkerBitmap =
    await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/finish_icon.png',
    );
    for (final location in locations) {
      if (location == locations[0]) {
        iconBitmap = startMarkerBitmap;
      } else if (location == locations[locations.length - 1]) {
        iconBitmap = finishMarkerBitmap;
      } else {
        iconBitmap = regularIconBitmap;
      }
      if (location != locations[0]
          && location != locations[locations.length - 1]
          && location.sightGroup == null) {
        continue;
      }
      final markerId =
      MarkerId('${location.lat.toString()}${location.lng.toString()}');
      markers[markerId] = Marker(
        markerId: markerId,
        position: LatLng(location.lat, location.lng),
        infoWindow: InfoWindow(
          title: location.title,
        ),
        icon: iconBitmap,
      );
    }

    return markers;
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

}