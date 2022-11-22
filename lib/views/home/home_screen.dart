import 'package:after_layout/after_layout.dart';
import 'package:krtouristic/conf/responsive_app_config.dart';
import 'package:krtouristic/model/core/location.dart';
import 'package:krtouristic/model/helpers/location_helper.dart';
import 'package:krtouristic/model/helpers/sight_group_helper.dart';
import 'package:krtouristic/model/helpers/ui_blocks_helper.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/views/guided_tours/guided_tours_main_screen.dart';
import 'package:krtouristic/views/home/home_block_tile.dart';
import 'package:krtouristic/views/common/error_tile.dart';
import 'package:krtouristic/views/common/app_bar_main.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:krtouristic/views/sights/sights_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/providers/google_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AfterLayoutMixin {
  int tabIndex = 0;
  late var _homeBlocks = [];
  late var _sightGroups = [];
  Glitch? _errorGlitch;
  MapType dialogMapType = MapType.normal;
  String mapTypeValue = 'normal';
  var googleServiceProvider = GoogleProvider();

  void addMarkers(locations) async {
    googleServiceProvider.markers.clear();
    final BitmapDescriptor markerBitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/location-icon.png',
    );
    for (final Location location in locations) {
      final markerId = location.firebaseId ?? location.title;
      /*
      // adding markers with the network images
      Uint8List bytes = (await NetworkAssetBundle(Uri.parse(location.headImage.url))
          .load(location.headImage.url))
          .buffer
          .asUint8List();
       */
      final marker = Marker(
        markerId: MarkerId(markerId),
        position: LatLng(location.lat, location.lng),
        icon: markerBitmap,
        // icon: BitmapDescriptor.fromBytes(bytes),
        infoWindow: InfoWindow(
          title: location.title,
          snippet: location.address,
        ),
      );
      googleServiceProvider.markers[markerId] = marker;
    }
    setState(() {});
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    final uiBlocksHelper = UiBlocksHelper();
    final uiBlocksResult = await uiBlocksHelper.getHomePageBlocks();
    uiBlocksResult.fold((l) {
      _errorGlitch = l;
    }, (r) {
      _homeBlocks = r;
    });

    final sightGroupHelper = SightGroupHelper();
    final sightGroupResult = await sightGroupHelper.getSightGroups();
    sightGroupResult.fold((l) {}, (r) {
      _sightGroups = r;
    });
    setState(() {});

    final locationHelper = LocationHelper();
    var locationsResult = await locationHelper.getLocations(
      sightGroup: 'featured',
    );
    locationsResult.fold((l) {}, (r) {
      addMarkers(r);
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsiveAppConfig = ResponsiveAppConfig(context);

    Future<void> openMapDialog(BuildContext context) async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
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
                      height: responsiveAppConfig.rHeight(80),
                      width: responsiveAppConfig.rWidth(80),
                      child: GoogleMap(
                        mapType: dialogMapType,
                        minMaxZoomPreference: googleServiceProvider.zoomPref,
                        onMapCreated: googleServiceProvider.onMapCreated,
                        initialCameraPosition:
                            googleServiceProvider.currentCityPosition,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        tiltGesturesEnabled: true,
                        scrollGesturesEnabled: true,
                        compassEnabled: true,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        markers: googleServiceProvider.markers.values.toSet(),
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

    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
      appBar: etsAppBar(context, "Вас вітає", globals.cityData['title_main']),
      // backgroundColor: const Color.fromRGBO(40, 9, 0, 1.0),
      body: ListView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          Column(
              children: _homeBlocks.isNotEmpty
                  ? _homeBlocks.map((hb) {
                      return InkWell(
                        child: HomeBlockTile(homeBlock: hb),
                        onTap: () {
                          switch (hb['name']) {
                            case 'home_guided_tours':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GuidedToursMainScreen(
                                      title: globals
                                          .cityData['title_guided_tours']),
                                ),
                              );
                              break;
                            case 'home_monumental_arts':
                              final sightGroup = _sightGroups.firstWhere(
                                  (element) => element['name'] == 'art');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SightsCategoryScreen(
                                    categoryId: sightGroup,
                                  ),
                                ),
                              );
                              break;
                            case 'home_industrial_heritage':
                              final sightGroup = _sightGroups.firstWhere(
                                  (element) => element['name'] == 'industrial');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SightsCategoryScreen(
                                      categoryId: sightGroup),
                                ),
                              );
                              break;
                            case 'home_history_architecture':
                              final sightGroup = _sightGroups.firstWhere(
                                  (element) => element['name'] == 'historical');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SightsCategoryScreen(
                                      categoryId: sightGroup),
                                ),
                              );
                              break;
                          }
                        },
                      );
                    }).toList()
                  : []),
          Column(
              children: _errorGlitch != null
                  ? [
                      ErrorTile(
                        errorMessage: _errorGlitch!.message,
                      )
                    ]
                  : []),
          SizedBox(
            height: 350,
            child: GoogleMap(
              mapType: MapType.normal,
              minMaxZoomPreference: googleServiceProvider.zoomPref,
              onMapCreated: googleServiceProvider.onMapCreated,
              initialCameraPosition: googleServiceProvider.currentCityPosition,
              zoomGesturesEnabled: false,
              zoomControlsEnabled: false,
              tiltGesturesEnabled: false,
              scrollGesturesEnabled: false,
              compassEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              markers: googleServiceProvider.markers.values.toSet(),
              onTap: (latLng) {
                openMapDialog(context);
              },
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     _insertData();
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
