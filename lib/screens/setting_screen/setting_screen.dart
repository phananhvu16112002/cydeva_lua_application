import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animations/animations.dart';
import 'package:cydeva_lua_application/common/bases/custom_text.dart';
import 'package:cydeva_lua_application/common/colors/Colors.dart';
import 'package:cydeva_lua_application/models/bottom_model.dart';
import 'package:cydeva_lua_application/screens/post_screen/post_screen.dart';
import 'package:cydeva_lua_application/screens/pratice_screen/practice_screen.dart';
import 'package:cydeva_lua_application/screens/setting_screen/setting_screen_body.dart';
import 'package:cydeva_lua_application/screens/user_screen/user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _bottomNavIndex = 0;

  List<BottomNavModel> listBottomNav = [
    BottomNavModel(title: 'Home', svgPath: 'assets/icons/home.svg'),
    BottomNavModel(title: 'Chat', svgPath: 'assets/icons/home.svg'),
    BottomNavModel(title: 'History', svgPath: 'assets/icons/home.svg'),
    BottomNavModel(title: 'Profile', svgPath: 'assets/icons/user.svg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            height: 65,
            itemCount: listBottomNav.length,
            tabBuilder: (index, isActive) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(listBottomNav[index].svgPath,
                          width: 24,
                          height: 24,
                          color: isActive
                              ? AppColors.colorButton
                              : AppColors.unselectedBottom)),
                  Text(
                    listBottomNav[index].title,
                    style: TextStyle(
                        color: isActive
                            ? AppColors.colorButton
                            : AppColors.unselectedBottom),
                  )
                ],
              );
            },
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.none,
            backgroundColor: AppColors.neutralWhite,
            onTap: onTapHandler),
        backgroundColor: AppColors.neutralWhite,
        body: _buildBody());
  }

  void onTapHandler(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_bottomNavIndex) {
      case 0:
        return _buildPage(const SettingScreenBody());
      case 1:
        return _buildPage(const PracticeScreen());
      case 2:
        return _buildPage(const PostScreen());
      case 3:
        return _buildPage(const UserScreen());
      default:
        return _buildPage(const SettingScreenBody());
    }
  }

  Widget _buildPage(Widget page) {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation, secondaryAnimation) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: page,
    );
  }
}
