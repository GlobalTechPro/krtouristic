import 'package:beamer/beamer.dart';
import 'package:krtouristic/views/city_info/city_info_beam_location.dart';
import 'package:krtouristic/views/guided_tours/guided_tours_beam_location.dart';
import 'package:krtouristic/views/guides/guides_beam_location.dart';
import 'package:krtouristic/views/home/home_beam_location.dart';
import 'package:krtouristic/views/sights/sights_beam_location.dart';
import 'package:krtouristic/views/common/navbar/animated_navbar.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/globals.dart' as globals;

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> fadeAnimation;
  late AnimationController _controller;

  final _routerDelegates = [
    BeamerDelegate(
      initialPath: '/home',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('/home')) {
          return HomeBeamLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
    BeamerDelegate(
      initialPath: '/sights',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('/sights')) {
          return SightsBeamLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
    BeamerDelegate(
      initialPath: '/guided-tours',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('/guided-tours')) {
          return GuidedToursBeamLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
    BeamerDelegate(
      initialPath: '/guides',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('/guides')) {
          return GuidesBeamLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
    BeamerDelegate(
      initialPath: '/city-info',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('/city-info')) {
          return CityInfoBeamLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    fadeAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedBuilder(
        animation: fadeAnimation,
        builder: (context, snapshot) {
          return Scaffold(
            body: IndexedStack(
              index: globals.navbarIndex,
              children: _routerDelegates.map((routerDelegate) {
                return FadeTransition(
                  opacity: fadeAnimation,
                  child: Beamer(
                    routerDelegate: routerDelegate,
                  ),
                );
              }).toList(),
            ),
            bottomNavigationBar: AnimatedNavBar(
              onItemTapped: (x) {
                // if (globals.navbarIndex == x) {
                //   print('same button');
                //   print(context.beamingHistory[context.beamingHistory.length-1].history.last.routeInformation.location);
                //   context.beamingHistory.clear();
                // }
                globals.navbarIndex = x;
                _routerDelegates[globals.navbarIndex].update(rebuild: false);
                _controller.reset();
                _controller.forward();
              },
            ),
          );
        },
      ),
    );
  }
}
