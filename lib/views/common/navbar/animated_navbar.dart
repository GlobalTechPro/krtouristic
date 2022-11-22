import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;
import 'package:krtouristic/views/common/navbar/menu_items.dart' as menu;
import 'package:krtouristic/conf/globals.dart' as globals;

class AnimatedNavBar extends StatefulWidget {
  const AnimatedNavBar({Key? key, required this.onItemTapped})
      : super(key: key);
  final Function(int) onItemTapped;

  @override
  State<AnimatedNavBar> createState() => _AnimatedNavBarState();
}

class _AnimatedNavBarState extends State<AnimatedNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool isHidden = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: 100.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(0, animation.value),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: globals.navbarIndex,
              onTap: (x) {
                widget.onItemTapped(x);
              },
              elevation: 16.0,
              showUnselectedLabels: true,
              unselectedItemColor: const Color.fromRGBO(255, 213, 0, 1.0),
              selectedItemColor: const Color.fromRGBO(255, 255, 255, 1.0),
              backgroundColor: const Color.fromRGBO(2, 51, 103, 1.0),
              unselectedLabelStyle: font_styles.navBarUnselectedLabel,
              selectedLabelStyle: font_styles.navBarSelectedLabel,
              items: menu.MenuItem.elements
                  .map((menu.MenuItem menuItem) => BottomNavigationBarItem(
                        icon: Icon(menuItem.iconData),
                        label: menuItem.text,
                      ))
                  .toList(),
            ),
          );
        });
  }
}
