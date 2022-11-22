import 'package:beamer/beamer.dart';
import 'package:krtouristic/views/city_info/city_info_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/globals.dart' as globals;

class CityInfoBeamLocation extends BeamLocation<BeamState> {
  CityInfoBeamLocation(super.routeInformation);

  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: const ValueKey('city-info'),
          type: BeamPageType.fadeTransition,
          child: CityInfoMainScreen(title: globals.cityData['title_city_info']),
        ),
      ];
}
