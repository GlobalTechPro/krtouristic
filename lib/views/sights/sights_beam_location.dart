import 'package:beamer/beamer.dart';
import 'package:krtouristic/views/sights/sights_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/globals.dart' as globals;

class SightsBeamLocation extends BeamLocation<BeamState> {
  SightsBeamLocation(super.routeInformation);

  @override
  List<String> get pathPatterns =>
      ['/*', '/sights/category/:categoryId', '/sights/:sightId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: const ValueKey('sights'),
          child: SightsMainScreen(title: globals.cityData['title_sights']),
        ),
        // if (state.pathParameters.containsKey('categoryId'))
        //   BeamPage(
        //     key: ValueKey(
        //         'sights-category-${state.pathParameters['categoryId']}'),
        //     child: SightsCategoryScreen(
        // @TODO should be re-made by changing the categoryId to String
        //         categoryId: state.pathParameters['categoryId']!),
        //   ),
        // if (state.pathParameters.containsKey('sightId'))
        //   BeamPage(
        //     key: ValueKey('sight-${state.pathParameters['sightId']}'),
        //     child:
        //         SightDetailsScreen(sightId: state.pathParameters['sightId']!),
        //   ),
      ];
}
