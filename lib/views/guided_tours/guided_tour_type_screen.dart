import 'package:krtouristic/conf/responsive_app_config.dart';
import 'package:krtouristic/model/helpers/guided_tour_helper.dart';
import 'package:krtouristic/views/guided_tours/category_guided_tour_tile.dart';
import 'package:krtouristic/views/guided_tours/guided_tour_details_screen.dart';
import 'package:krtouristic/views/common/app_bar_main.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;

const double paddingPercentage = 1;

class GuidedToursTypeScreen extends StatefulWidget {
  const GuidedToursTypeScreen({Key? key, required this.guidedTourType})
      : super(key: key);
  final dynamic guidedTourType;

  @override
  State<GuidedToursTypeScreen> createState() => _GuidedToursTypeScreenState();
}

class _GuidedToursTypeScreenState extends State<GuidedToursTypeScreen> {
  var _guidedTours = [];

  Future loadData() async {
    final guidedTourHelper = GuidedTourHelper();
    final guidedTourResult = await guidedTourHelper.getGuidedTours(
      guidedTourTypeName: widget.guidedTourType['name'],
    );
    guidedTourResult.fold((l) {}, (r) {
      _guidedTours = r;
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
    Widget guidedToursSection = Container(
      height: responsiveAppConfig.rHeight(10),
      alignment: Alignment.center,
      child: Text(
        "Немає екскурсій у цій категорії",
        style: font_styles.emptyGuidedToursCategory,
        textAlign: TextAlign.center,
      ),
    );

    if (_guidedTours.isNotEmpty) {
      guidedToursSection = Padding(
        padding: EdgeInsets.only(
            bottom: responsiveAppConfig.rHeight(paddingPercentage)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Container(
          //   margin: const EdgeInsets.only(
          //       bottom: 5.0, top: 5.0, left: 10.0),
          //   child: Text(
          //     widget.guidedTourType['title'],
          //     style: font_styles.screenSectionTitle,
          //   ),
          // ),
          Column(
            children: _guidedTours.map((tour) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GuidedTourDetailsScreen(
                          guidedTourId: tour.firebaseId),
                    ),
                  );
                },
                child: CategoryGuidedTourTile(tour: tour),
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
          "${widget.guidedTourType['title']} ${globals.cityData['menu_item_guided_tours']}"),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: responsiveAppConfig.rWidthPadding(paddingPercentage),
          vertical: responsiveAppConfig.rHeightPadding(paddingPercentage),
        ),
        children: [
          guidedToursSection,
        ],
      ),
    );
  }
}
