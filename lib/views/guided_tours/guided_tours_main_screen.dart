import 'package:krtouristic/conf/responsive_app_config.dart';
import 'package:krtouristic/model/helpers/guided_tour_helper.dart';
import 'package:krtouristic/model/helpers/guided_tour_type_helper.dart';
import 'package:krtouristic/views/guided_tours/guided_tour_type_screen.dart';
import 'package:krtouristic/views/guided_tours/top_guided_tour_tile.dart';
import 'package:krtouristic/views/common/app_bar_main.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:krtouristic/views/guided_tours/guided_tour_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;

const double paddingPercentage = 1;

class GuidedToursMainScreen extends StatefulWidget {
  const GuidedToursMainScreen({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  State<GuidedToursMainScreen> createState() => _GuidedToursMainScreenState();
}

class _GuidedToursMainScreenState extends State<GuidedToursMainScreen> {
  var _topGuidedTours = [];
  var _guidedTourTypes = [];

  Future loadData() async {
    final guidedTourTypeHelper = GuidedTourTypeHelper();
    final guidedTourGroupsResult =
        await guidedTourTypeHelper.getGuidedTourTypes();
    guidedTourGroupsResult.fold((l) {}, (r) {
      _guidedTourTypes = r;
      setState(() {});
    });

    final guidedTourHelper = GuidedTourHelper();
    final guidedTourResult = await guidedTourHelper.getGuidedTours(
      top: true,
    );
    guidedTourResult.fold((l) {}, (r) {
      _topGuidedTours = r;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
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
            children: _guidedTourTypes.map((gtt) {
              return TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 213, 0, 1.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GuidedToursTypeScreen(guidedTourType: gtt),
                    ),
                  );
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    gtt['title'],
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

    Widget topGuidedToursSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15.0, top: 5.0),
          child: Text(
            "ТОП ${_topGuidedTours.length} Екскурсій",
            style: font_styles.screenSectionTitle,
          ),
        ),
        GridView.count(
            mainAxisSpacing: responsiveAppConfig.rWidth(4),
            crossAxisSpacing: responsiveAppConfig.rHeight(3),
            shrinkWrap: true,
            crossAxisCount: 2,
            physics: const ScrollPhysics(),
            children: _topGuidedTours.map((topTour) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GuidedTourDetailsScreen(
                          guidedTourId: topTour.firebaseId),
                    ),
                  );
                },
                child: TopGuidedTourTile(tour: topTour),
              );
            }).toList()),
      ],
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
      appBar: etsAppBar(context, globals.cityData['title_main'],
          globals.cityData['menu_item_guided_tours']),
      body: ListView(
        padding: EdgeInsets.only(
          left: responsiveAppConfig.rWidthPadding(paddingPercentage),
          right: responsiveAppConfig.rWidthPadding(paddingPercentage),
          top: responsiveAppConfig.rHeightPadding(paddingPercentage),
          bottom: 60.0,
        ),
        children: [
          filterSection,
          SizedBox(height: responsiveAppConfig.rHeight(2)),
          topGuidedToursSection,
        ],
      ),
    );
  }
}
