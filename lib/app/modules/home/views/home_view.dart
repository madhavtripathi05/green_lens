import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final hc = HomeController.to;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: PageTransitionSwitcher(
            transitionBuilder: (child, animation, secondaryAnimation) =>
                FadeThroughTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                ),
            child: hc.views[hc.index.value]),
        bottomNavigationBar: BottomNavigationBar(
          onTap: hc.changeIndex,
          currentIndex: hc.index.value,
          items: [
            BottomNavigationBarItem(
                icon: Icon(FlutterIcons.cards_mco), label: "Dashboard"),
            BottomNavigationBarItem(
                icon: Icon(Icons.people_alt), label: "Community"),
            BottomNavigationBarItem(
                icon: Icon(FlutterIcons.user_astronaut_faw5s),
                label: "Profile"),
          ],
        ),
      ),
    );
  }
}
