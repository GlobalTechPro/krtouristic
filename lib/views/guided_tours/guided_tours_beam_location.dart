import 'package:beamer/beamer.dart';
import 'package:krtouristic/views/guided_tours/guided_tours_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/globals.dart' as globals;

class GuidedToursBeamLocation extends BeamLocation<BeamState> {
  GuidedToursBeamLocation(super.routeInformation);

  @override
  List<String> get pathPatterns => [
        '/guided-tours',
        '/guided-tours/type/:tourTypeId',
        '/guided-tours/:tourId'
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: const ValueKey('guided-tours'),
          child: GuidedToursMainScreen(
              title: globals.cityData['title_guided_tours']),
        ),
        // if (state.pathParameters.containsKey('tourTypeId'))
        //   BeamPage(
        //     key: ValueKey(
        //         'guided-tours-type-${state.pathParameters['tourTypeId']}'),
        //     child: GuidedToursTypeScreen(
        // should be adjusted by also changing tourTypeId to String
        //         guidedTourType: state.pathParameters['tourTypeId']!),
        //   ),
        // if (state.pathParameters.containsKey('tourId'))
        //   BeamPage(
        //     key: ValueKey('guided-tours-${state.pathParameters['tourId']}'),
        //     child: GuidedTourDetailsScreen(
        //         guidedTourId: state.pathParameters['tourId'].toString()),
        //   ),
      ];
}
