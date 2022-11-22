library krtouristic.menu;

import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:flutter/material.dart';

class MenuItem {
  const MenuItem(
    this.iconData,
    this.text,
  );

  final IconData iconData;
  final String text;

  static List<MenuItem> get elements => [
        MenuItem(
          Icons.home_outlined,
          globals.cityData['menu_item_main'],
        ),
        MenuItem(
          Icons.castle_outlined,
          globals.cityData['menu_item_sights'],
        ),
        MenuItem(
          Icons.route_outlined,
          globals.cityData['menu_item_guided_tours'],
        ),
        MenuItem(
          Icons.people_outline,
          globals.cityData['menu_item_guides'],
        ),
        MenuItem(
          Icons.info_outlined,
          globals.cityData['menu_item_city_info'],
        ),
      ];
}
