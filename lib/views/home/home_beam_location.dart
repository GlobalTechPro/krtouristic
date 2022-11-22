import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/views/home/home_screen.dart';
import 'package:krtouristic/conf/globals.dart' as globals;

class HomeBeamLocation extends BeamLocation<BeamState> {
  HomeBeamLocation(super.routeInformation);

  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: const ValueKey('home'),
          child: HomeScreen(title: globals.cityData['title_main']),
        ),
      ];
}
