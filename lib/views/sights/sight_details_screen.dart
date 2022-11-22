import 'package:after_layout/after_layout.dart';
import 'package:krtouristic/conf/responsive_app_config.dart';
import 'package:krtouristic/model/core/location.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/model/helpers/location_helper.dart';
import 'package:krtouristic/views/common/app_bar_main.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:krtouristic/views/common/error_tile.dart';
import 'package:krtouristic/views/sights/sight_details_tile.dart';
import 'package:flutter/material.dart';

const double paddingPercentage = 1;

class SightDetailsScreen extends StatefulWidget {
  const SightDetailsScreen({Key? key, required this.sightId}) : super(key: key);
  final String sightId;

  @override
  State<SightDetailsScreen> createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen>
    with AfterLayoutMixin {
  String title = globals.cityData['menu_item_sights'];
  static const String _errorMessage = 'Resource Unavailable';
  Widget uiBlock = Container();
  late Future<dynamic> _result;

  Future<dynamic> getSightDetails(sightId) async {
    final locationHelper = LocationHelper();
    dynamic result;

    final locationResult = await locationHelper.getLocation(
      id: sightId,
    );
    locationResult.fold((l) {
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
    _result = getSightDetails(widget.sightId);
  }

  @override
  void afterFirstLayout(BuildContext context) async {}

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
              future: _result,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                Widget child = Container();
                var data = snapshot.data;
                if (data is Location) {
                  child = SightDetailsTile(
                    sight: data,
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
