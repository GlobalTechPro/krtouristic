import 'package:after_layout/after_layout.dart';
import 'package:krtouristic/conf/responsive_app_config.dart';
import 'package:krtouristic/model/helpers/location_helper.dart';
import 'package:krtouristic/model/helpers/sight_group_helper.dart';
import 'package:krtouristic/views/common/app_bar_main.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:krtouristic/views/sights/featured_sight_tile.dart';
import 'package:krtouristic/views/sights/sight_details_screen.dart';
import 'package:krtouristic/views/sights/sights_category_screen.dart';
import 'package:krtouristic/views/sights/top_sights_tile.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;

const double paddingPercentage = 1;

class SightsMainScreen extends StatefulWidget {
  const SightsMainScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SightsMainScreen> createState() => _SightsMainScreenState();
}

class _SightsMainScreenState extends State<SightsMainScreen>
    with AfterLayoutMixin {
  var _featuredSights = [];
  var _topSights = [];
  var _sightGroups = [];

  @override
  void afterFirstLayout(BuildContext context) async {
    final locationHelper = LocationHelper();
    final sightGroupHelper = SightGroupHelper();

    final featuredLocationsResult = await locationHelper.getLocations(
      sightGroup: 'featured',
    );
    featuredLocationsResult.fold((l) {}, (r) {
      _featuredSights = r;
    });

    final topLocationsResult = await locationHelper.getLocations(
      top: true,
    );
    topLocationsResult.fold((l) {}, (r) {
      _topSights = r;
    });

    final sightGroupResult = await sightGroupHelper.getSightGroups();
    sightGroupResult.fold((l) {}, (r) {
      _sightGroups = r;
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final responsiveAppConfig = ResponsiveAppConfig(context);

    Widget filterSection = Padding(
      padding: EdgeInsets.only(
          bottom: responsiveAppConfig.rHeight(paddingPercentage)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15.0, top: 5.0),
          child: Text(
            "Категорії",
            style: font_styles.screenSectionTitle,
          ),
        ),
        GridView.count(
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1 / 0.4,
            shrinkWrap: true,
            crossAxisCount: 3,
            physics: const ScrollPhysics(),
            children: _sightGroups.map((sg) {
              return TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 213, 0, 1.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SightsCategoryScreen(category: sg),
                    ),
                  );
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    sg['title'],
                    style: font_styles.categoryButtonTitle,
                    textScaleFactor: MediaQuery.of(context).size.width /
                        MediaQuery.of(context).size.height,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList()),
      ]),
    );

    Widget topSightsSection = Padding(
      padding: EdgeInsets.only(
          bottom: responsiveAppConfig.rHeight(paddingPercentage)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15.0, top: 5.0),
          child: Text(
            "ТОП ${_topSights.length} Визначних Місць",
            style: font_styles.screenSectionTitle,
          ),
        ),
        Column(
          children: _topSights.map((ts) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SightDetailsScreen(sightId: ts.firebaseId),
                  ),
                );
              },
              child: TopSightTile(location: ts),
            );
          }).toList(),
        ),
      ]),
    );

    Widget featuredSightsSection = Container(
      margin: EdgeInsets.only(
          bottom: responsiveAppConfig.rHeight(paddingPercentage * 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15.0, top: 5.0),
            child: Text(
              "Візитівки міста",
              style: font_styles.screenSectionTitle,
            ),
          ),
          GridView.count(
              mainAxisSpacing: responsiveAppConfig.rWidth(paddingPercentage),
              crossAxisSpacing: responsiveAppConfig.rHeight(paddingPercentage),
              shrinkWrap: true,
              crossAxisCount: 2,
              physics: const ScrollPhysics(),
              children: _featuredSights.map((fs) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SightDetailsScreen(sightId: fs.firebaseId),
                      ),
                    );
                  },
                  child: FeaturedSightTile(location: fs),
                );
              }).toList()),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
      appBar: etsAppBar(context, globals.cityData['title_main'],
          globals.cityData['menu_item_sights']),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: responsiveAppConfig.rWidthPadding(paddingPercentage),
          vertical: responsiveAppConfig.rHeightPadding(paddingPercentage),
        ),
        children: [
          filterSection,
          SizedBox(height: responsiveAppConfig.rHeight(2)),
          topSightsSection,
          SizedBox(height: responsiveAppConfig.rHeight(2)),
          featuredSightsSection,
        ],
      ),
    );
  }
}
