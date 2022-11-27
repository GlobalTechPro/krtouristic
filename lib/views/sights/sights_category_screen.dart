import 'package:krtouristic/conf/responsive_app_config.dart';
import 'package:krtouristic/model/helpers/location_helper.dart';
import 'package:krtouristic/views/common/app_bar_main.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:krtouristic/views/common/map/map_helper.dart';
import 'package:krtouristic/views/common/map/map_widget.dart';
import 'package:krtouristic/views/sights/sight_details_screen.dart';
import 'package:krtouristic/views/sights/top_sights_tile.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;

const double paddingPercentage = 1;

class SightsCategoryScreen extends StatefulWidget {
  const SightsCategoryScreen({Key? key, required this.category})
      : super(key: key);
  final dynamic category;

  @override
  State<SightsCategoryScreen> createState() => _SightsCategoryScreenState();
}

class _SightsCategoryScreenState extends State<SightsCategoryScreen> {
  var _sights = [];
  Widget mapWidget = Container();

  Future<void> processData(context) async {
    final locationHelper = LocationHelper();
    locationHelper
        .getLocations(
      sightGroup: widget.category['name'],
    )
        .then((value) => value.fold((l) {}, (r) async {
      _sights = r;

      if (_sights.isNotEmpty) {
        var markers = await MapHelper.createLinkedMarkers(_sights, context);
        setState(() {
          mapWidget = Padding(
            padding: const EdgeInsets.all(4),
            child: MapWidget(
              height: 300,
              markers: markers,
            ),
          );
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    processData(context);
    final responsiveAppConfig = ResponsiveAppConfig(context);
    Widget sightsSection = Container();

    Widget divider = const Divider(
      height: 5.0,
      thickness: 0,
      indent: 20.0,
      endIndent: 20.0,
    );

    Widget bodySection = Container(
      height: responsiveAppConfig.rHeight(10),
      alignment: Alignment.center,
      child: Text(
        "Немає визначних місць\nу цій категорії",
        style: font_styles.emptySightsCategory,
        textAlign: TextAlign.center,
      ),
    );

    if (_sights.isNotEmpty) {
      sightsSection = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Container(
        //   margin: const EdgeInsets.only(
        //       bottom: 10.0),
        //   alignment: Alignment.center,
        //   child: Text(
        //     widget.category['subtitle'],
        //     style: font_styles.screenSectionTitle,
        //   ),
        // ),
        Column(
          children: _sights.map((sight) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SightDetailsScreen(sightId: sight.firebaseId),
                  ),
                );
              },
              child: TopSightTile(location: sight),
            );
          }).toList(),
        ),
      ]);

      bodySection = ListView(
        padding: EdgeInsets.symmetric(
          horizontal: responsiveAppConfig.rWidthPadding(3 * paddingPercentage),
          vertical: responsiveAppConfig.rHeightPadding(paddingPercentage),
        ),
        children: [
          sightsSection,
          divider,
          mapWidget,
        ],
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
      appBar: etsAppBar(context, globals.cityData['title_main'],
          "${widget.category['title']} ${globals.cityData['menu_item_sights']}"),
      body: bodySection,
    );
  }
}
