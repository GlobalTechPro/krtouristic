import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krtouristic/model/helpers/location_helper.dart';
import 'package:krtouristic/model/helpers/sight_group_helper.dart';
import 'package:krtouristic/model/helpers/ui_blocks_helper.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/views/common/map/map_helper.dart';
import 'package:krtouristic/views/common/map/map_widget.dart';
import 'package:krtouristic/views/guided_tours/guided_tours_main_screen.dart';
import 'package:krtouristic/views/home/home_block_tile.dart';
import 'package:krtouristic/views/common/error_tile.dart';
import 'package:krtouristic/views/common/app_bar_main.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:krtouristic/views/sights/sights_category_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabIndex = 0;
  late var _homeBlocks = [];
  late var _sightGroups = [];
  Glitch? _errorGlitch;
  Widget mapWidget = Container();

  void loadStateData(context) async {
    final uiBlocksHelper = UiBlocksHelper();
    final uiBlocksResult = await uiBlocksHelper.getHomePageBlocks();
    uiBlocksResult.fold((l) {
      _errorGlitch = l;
    }, (r) {
      _homeBlocks = r;
    });

    final sightGroupHelper = SightGroupHelper();
    final sightGroupResult = await sightGroupHelper.getSightGroups();
    sightGroupResult.fold((_) {}, (r) {
      _sightGroups = r;
    });

    final locationHelper = LocationHelper();
    var locationsResult = await locationHelper.getLocations(
      sightGroup: 'featured',
    );
    locationsResult.fold((_) {}, (locations) async {
      Map<MarkerId, Marker> markers = await MapHelper.createLinkedMarkers(locations, context);
      setState(() {
        mapWidget = MapWidget(
          height: 350,
          markers: markers,
        );
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    loadStateData(context);

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
                                    category: sightGroup,
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
                                      category: sightGroup),
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
                                      category: sightGroup),
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
          mapWidget,
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
