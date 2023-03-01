import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../ui.dart';
class BaseScreen<T extends BaseController> extends GetView<T> with ResponsiveWidget {
  BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetLoadingFullScreen<T>(
      child: buildUi(context: context),
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildMobile(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildTablet(BuildContext context) {
    return const SizedBox();
  }
}

    abstract class ResponsiveWidget {
  static dynamic valueByWidth(context, value, {desktop, tablet, mobile}) {
    if (MediaQuery.of(context).size.width > 1024) return desktop ?? value;
    if (MediaQuery.of(context).size.width > 600) return tablet ?? value;
    return mobile ?? value;
  }

  static dynamic valueByType(DeviceScreenType type, {desktop, tablet, mobile}) {
    switch (type) {
      case DeviceScreenType.desktop:
        return desktop;
      case DeviceScreenType.tablet:
        return tablet;
      case DeviceScreenType.mobile:
        return mobile;
      default:
        return mobile;
    }
  }

  Widget buildDesktop(BuildContext context);

  Widget buildTablet(BuildContext context);

  Widget buildMobile(BuildContext context);

  Widget buildUi({required BuildContext context}) {
    Widget child = ResponsiveBuilder(builder: (context, sizeInfo) {
      if (sizeInfo.deviceScreenType == DeviceScreenType.desktop) {
        return buildDesktop(context);
      } else if (sizeInfo.deviceScreenType == DeviceScreenType.tablet) {
        return buildTablet(context);
      } else if (sizeInfo.deviceScreenType == DeviceScreenType.mobile) {
        return buildMobile(context);
      }
      return const SizedBox();
    });
    return WidgetKeyboardDismiss(
      // child: (Get.currentRoute != Routes.SPLASH && Get.currentRoute != Routes.AUTH)
      //   ? SafeArea(child: child)
      //   :
        child: child);
  }
}