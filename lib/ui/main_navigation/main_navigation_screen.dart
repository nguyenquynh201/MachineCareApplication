import 'dart:io';

import 'package:flutter_svg/svg.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/utils/utils.dart';

import '../ui.dart';
import 'package:flutter/material.dart';

class MainNavigationScreen extends BaseScreen<MainNavigationController> {
  MainNavigationScreen({Key? key}) : super(key: key);
  static List<String> tabs = [
    'home'.tr,
    'history'.tr,
    'repair'.tr,
    'product'.tr,
    'personal'.tr
  ];
  static List<Widget> pages  = const[
    _HomeScreen(),
    _HistoryScreen(),
    _RepairScreen(),
    _ProductScreen(),
    _ProfileScreen()
  ];
  @override
  Widget buildUi({required BuildContext context}) {
    return WillPopScope(
      onWillPop: () async {
        if (DateTime.now().millisecondsSinceEpoch - controller.lastClickBack < 1000 * 3) {
          exit(0);
        } else {
          controller.lastClickBack = DateTime.now().millisecondsSinceEpoch;
          AppUtils.showToast('msg_info_back_to_close_app'.tr);
        }
        return false;
      },
      child: Scaffold(
        body: GetX<MainNavigationController>(
          builder: (_) {
            return Column(
              children: [
                Expanded(child: IndexedStack(
                  index: controller.currentPage.value,
                  children: pages,
                ),),
                Container(
                  height: AppValues.footerHeight,
                  padding: EdgeInsets.only(bottom: Get.mediaQuery.viewPadding.bottom),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, -1),
                        blurRadius: 1,
                        spreadRadius: 0.1,
                      )
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      _TabView(
                          index: 0,
                          title: tabs[0],
                          controller: controller),
                      _TabView(
                          index: 1,
                          title: tabs[1],
                          controller: controller),
                      _TabView(
                          index: 2,
                          title: tabs[2],
                          controller: controller),
                      _TabView(
                          index: 3,
                          title: tabs[3],
                          controller: controller),
                      _TabView(
                          index: 4,
                          title: tabs[4],
                          controller: controller),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
class _TabView extends StatelessWidget {
  final int index;
  final String title;
  final MainNavigationController controller;

  const _TabView({Key? key, required this.index, required this.title, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool selected = index == controller.currentPage.value;
    SvgPicture svgPicture = SvgPicture.asset(
      controller.imagesSelect[index],
      fit: BoxFit.cover,
      color: selected ? AppColor.colorButton : AppColor.primary,
    );
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          controller.changePage(index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32, width: 32, child: svgPicture),
            const SizedBox(height: 2),
            if (title != "")
              Text(
                title,
                style: AppTextStyles.verySmall()
                    .copyWith(color: selected ? AppColor.colorButton : AppColor.primary),
              )
          ],
        ),
      ),
    );
  }
}
class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

class _HistoryScreen extends StatelessWidget {
  const _HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HistoryScreen();
  }
}

class _RepairScreen extends StatelessWidget {
  const _RepairScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepairScreen();
  }
}

class _ProductScreen extends StatelessWidget {
  const _ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductScreen();
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileScreen();
  }
}
