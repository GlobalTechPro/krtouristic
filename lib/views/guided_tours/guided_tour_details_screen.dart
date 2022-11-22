import 'package:krtouristic/conf/responsive_app_config.dart';
import 'package:krtouristic/model/core/guided_tour.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/model/helpers/guided_tour_helper.dart';
import 'package:krtouristic/views/guided_tours/guided_tour_details_tile.dart';
import 'package:krtouristic/views/common/app_bar_main.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:krtouristic/views/common/error_tile.dart';
import 'package:flutter/material.dart';

const double paddingPercentage = 1;

class GuidedTourDetailsScreen extends StatefulWidget {
  const GuidedTourDetailsScreen({Key? key, required this.guidedTourId})
      : super(key: key);
  final String guidedTourId;

  @override
  State<GuidedTourDetailsScreen> createState() =>
      _GuidedTourDetailsScreenState();
}

class _GuidedTourDetailsScreenState extends State<GuidedTourDetailsScreen> {
  String title = globals.cityData['menu_item_guided_tours'];
  static const String _errorMessage = 'Resource Unavailable';
  Widget uiBlock = Container();
  late Future<GuidedTour> _tour;

  Future<GuidedTour> getGuidedTourDetails(guidedTourId) async {
    final guidedTourHelper = GuidedTourHelper();
    dynamic result;

    final guidedTourResult = await guidedTourHelper.getTourById(
      id: guidedTourId,
    );
    guidedTourResult.fold((l) {
      result = l;
    }, (r) {
      result = r;
      setState(() {
        title = r.title;
      });
    });
    return result;
  }

  @override
  void initState() {
    super.initState();
    _tour = getGuidedTourDetails(widget.guidedTourId);
  }

  @override
  Widget build(BuildContext context) {
    final responsiveAppConfig = ResponsiveAppConfig(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
      appBar: etsAppBar(context, globals.cityData['title_main'], title),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: responsiveAppConfig.rWidthPadding(paddingPercentage),
          vertical: responsiveAppConfig.rHeightPadding(paddingPercentage),
        ),
        children: [
          FutureBuilder(
              future: _tour,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                Widget child = Container();
                var data = snapshot.data;
                if (data is GuidedTour) {
                  child = GuidedTourDetailsTile(
                    tour: data,
                  );
                } else if (data is Glitch) {
                  child = const ErrorTile(errorMessage: _errorMessage);
                }
                return child;
              })
        ],
      ),
    );
  }
}
