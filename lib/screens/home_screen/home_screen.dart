import 'dart:async';

import 'package:cydeva_lua_application/common/bases/custom_text.dart';
import 'package:cydeva_lua_application/common/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late Timer _timer;
  List<String> banner = [
    'assets/images/banner1.png',
    'assets/images/banner1.png',
    'assets/images/banner1.png',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 1000),
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralWhite,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      header(context),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.black,
                        height: MediaQuery.of(context).size.height,
                      )
                    ],
                  ),
                  Positioned(
                    top: 100,
                    left: 18,
                    right: 18,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 250,
                          child: PageView(
                              controller: _pageController,
                              onPageChanged: (int page) {
                                setState(() {
                                  _currentPage = page;
                                });
                              },
                              children: banner.map((e) {
                                return SizedBox(
                                    width: double.infinity,
                                    
                                    child: Image.asset(
                                      width: double.infinity,
                                      'assets/images/banner1.png',
                                    ));
                              }).toList()),
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(banner.length, (index) => Indicator(isActive: _currentPage == index ? true : false))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 270,
      decoration: const BoxDecoration(
          color: AppColors.colorButton,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.neutralWhite),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: SvgPicture.asset('assets/icons/filter.svg'),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            message: 'Xin chào Minh Ngọc',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.neutralWhite),
                        CustomText(
                            message: 'Bạn đã sẵn sàng?',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.neutralWhite),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/search.svg'),
                    const SizedBox(
                      width: 18,
                    ),
                    SvgPicture.asset('assets/icons/bell.svg')
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 22.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
          color: isActive ? AppColors.colorButton : Colors.grey,
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
