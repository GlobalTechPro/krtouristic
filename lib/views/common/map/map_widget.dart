import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:krtouristic/conf/responsive_app_config.dart';
import 'dart:async';

class MapWidget extends StatefulWidget {
  const MapWidget({
    Key? key,
    required this.height,
    this.markers,
    this.polylines,
    this.cameraPosition = const CameraPosition(
      target: LatLng(47.910573076933524, 33.391669323403704),
      zoom: 11.0,
    ),
  })
    : super(key: key);

  final double height;
  final Map<MarkerId, Marker>? markers;
  final Map<PolylineId, Polyline>? polylines;
  final CameraPosition cameraPosition;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late String _darkMapStyle;
  late String _lightMapStyle;
  MapType dialogMapType = MapType.normal;
  String mapTypeValue = 'normal';

  MinMaxZoomPreference zoomPref = const MinMaxZoomPreference(9.0, 18.0);
  Completer<GoogleMapController> _mapController = Completer();

  @override
  void initState() {
    super.initState();
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
  }

  void onMapCreated(GoogleMapController controller) async {
    _mapController.complete(controller);
    _mapController = Completer();
    setMapStyle();
  }

  Future<void> openMapDialog(BuildContext context, responsiveAppConfig) async {
    // BuildContext dialogContext;
    showDialog(
        context: context,
        builder: (_) {
          // dialogContext = context;
          return StatefulBuilder(builder: (context, setState) {
            return SimpleDialog(
              backgroundColor: const Color.fromRGBO(2, 51, 103, 1.0),
              contentPadding: const EdgeInsets.all(3.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              children: [
                Stack(children: [
                  SizedBox(
                    height: responsiveAppConfig.rHeight(80.0),
                    width: responsiveAppConfig.rWidth(80.0),
                    child: GoogleMap(
                      mapType: dialogMapType,
                      minMaxZoomPreference: zoomPref,
                      onMapCreated: onMapCreated,
                      initialCameraPosition: widget.cameraPosition,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      tiltGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      compassEnabled: true,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      markers: Set<Marker>.of(widget.markers?.values ?? {}),
                      polylines: Set<Polyline>.of(widget.polylines?.values ?? {}),
                    ),
                  ),
                  Positioned(
                    left: 15.0,
                    top: 5.0,
                    child: DropdownButton(
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 213, 0, 1.0),
                      ),
                      dropdownColor: const Color.fromRGBO(2, 51, 103, 1.0),
                      value: mapTypeValue,
                      underline: Container(
                        height: 2,
                        color: const Color.fromRGBO(255, 213, 0, 1.0),
                      ),
                      icon: const Icon(
                        Icons.map_outlined,
                        color: Color.fromRGBO(255, 213, 0, 1.0),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "normal",
                          child: Text(
                            "Звичайна",
                          ),
                        ),
                        DropdownMenuItem(
                          value: "satellite",
                          child: Text(
                            "Супутник",
                          ),
                        ),
                        DropdownMenuItem(
                          value: "terrain",
                          child: Text(
                            "Ландшафт",
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          switch (value) {
                            case 'normal':
                              dialogMapType = MapType.normal;
                              mapTypeValue = value.toString();
                              break;
                            case 'satellite':
                              dialogMapType = MapType.satellite;
                              mapTypeValue = value.toString();
                              break;
                            case 'terrain':
                              dialogMapType = MapType.terrain;
                              mapTypeValue = value.toString();
                              break;
                          }
                        });
                      },
                    ),
                  ),
                ]),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final responsiveAppConfig = ResponsiveAppConfig(context);


    return SizedBox(
      height: widget.height,
      child: GoogleMap(
        mapType: MapType.normal,
        minMaxZoomPreference: zoomPref,
        onMapCreated: onMapCreated,
        initialCameraPosition: widget.cameraPosition,
        zoomGesturesEnabled: false,
        zoomControlsEnabled: false,
        tiltGesturesEnabled: false,
        scrollGesturesEnabled: false,
        compassEnabled: false,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        markers: Set<Marker>.of(widget.markers?.values ?? {}),
        polylines: Set<Polyline>.of(widget.polylines?.values ?? {}),
        onTap: (latLng) {
          openMapDialog(context, responsiveAppConfig);
        },
      ),
    );

  }
}