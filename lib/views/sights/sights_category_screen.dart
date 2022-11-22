import 'package:krtouristic/conf/responsive_app_config.dart';
import 'package:krtouristic/model/helpers/location_helper.dart';
import 'package:krtouristic/views/common/app_bar_main.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:krtouristic/views/sights/sight_details_screen.dart';
import 'package:krtouristic/views/sights/top_sights_tile.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;

const double paddingPercentage = 1;

class SightsCategoryScreen extends StatefulWidget {
  const SightsCategoryScreen({Key? key, required this.categoryId})
      : super(key: key);
  final dynamic categoryId;

  @override
  State<SightsCategoryScreen> createState() => _SightsCategoryScreenState();
}

class _SightsCategoryScreenState extends State<SightsCategoryScreen> {
  var _sights = [];

  @override
  void initState() {
    super.initState();

    final locationHelper = LocationHelper();
    locationHelper
        .getLocations(
          sightGroup: widget.categoryId['name'],
        )
        .then((value) => value.fold((l) {}, (r) {
              _sights = r;
              setState(() {});
            }));
  }

  @override
  Widget build(BuildContext context) {
    final responsiveAppConfig = ResponsiveAppConfig(context);
    Widget sightsSection = Container(
      height: responsiveAppConfig.rHeight(10),
      alignment: Alignment.center,
      child: Text(
        "Немає визначних місць\nу цій категорії",
        style: font_styles.emptySightsCategory,
        textAlign: TextAlign.center,
      ),
    );

    if (_sights.isNotEmpty) {
      sightsSection = Padding(
        padding: EdgeInsets.only(
            bottom: responsiveAppConfig.rHeight(paddingPercentage)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Container(
          //   margin: const EdgeInsets.only(
          //       bottom: 5.0, top: 5.0, left: 10.0),
          //   child: Text(
          //     widget.sightGroup['subtitle'],
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
          SizedBox(height: responsiveAppConfig.rHeight(2)),
        ]),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
      appBar: etsAppBar(context, globals.cityData['title_main'],
          "${widget.categoryId['title']} ${globals.cityData['menu_item_sights']}"),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: responsiveAppConfig.rWidthPadding(paddingPercentage),
          vertical: responsiveAppConfig.rHeightPadding(paddingPercentage),
        ),
        children: [
          sightsSection,
        ],
      ),
    );
  }
}
