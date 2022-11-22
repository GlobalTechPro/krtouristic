import 'package:beamer/beamer.dart';
import 'package:krtouristic/views/guides/guides_screen.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/globals.dart' as globals;

class GuidesBeamLocation extends BeamLocation<BeamState> {
  GuidesBeamLocation(super.routeInformation);

  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        // if (state.uri.pathSegments.contains('guides'))
        BeamPage(
          key: const ValueKey('guides'),
          type: BeamPageType.fadeTransition,
          child: GuidesScreen(title: globals.cityData['menu_item_guides']),
        ),
      ];
}
