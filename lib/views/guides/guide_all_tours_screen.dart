import 'package:krtouristic/model/core/guided_tour.dart';
import 'package:krtouristic/views/common/app_bar_main.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;

class GuideAllToursScreen extends StatefulWidget {
  const GuideAllToursScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<GuideAllToursScreen> createState() => _GuideAllToursScreenState();
}

class _GuideAllToursScreenState extends State<GuideAllToursScreen> {
  late var tours = [];

  Widget _buildGuideTourTile(GuidedTour tour) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
      appBar: etsAppBar(context, globals.cityData['title_main'],
          globals.cityData['menu_item_guides']),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 10.0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: tours.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildGuideTourTile(tours[index]);
        },
      ),
    );
  }
}
