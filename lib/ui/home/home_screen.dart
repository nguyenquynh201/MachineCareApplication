import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/enum/validate.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/app_pref.dart';

class HomeScreen extends BaseScreen<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          WidgetHeaderHome(user: AppPref.user),
          Expanded(
              child: WidgetLoadMoreRefresh(
                controller: controller.refreshController,
                onRefresh: () {},
                onLoadMore: () {},
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      WidgetSliderBanner(),
                      WidgetNews(),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class WidgetNews extends StatelessWidget {
  const WidgetNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = (Get.width / 2) - 27;
    return Container(
      padding: const EdgeInsets.only(top: 21, left: 26, right: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'news'.tr,
            style: AppTextStyles.customTextStyle().copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.colorButton,
                fontSize: 16,
                fontFamily: Fonts.Quicksand.name),
          ),
          GridView.builder(
              itemCount: 8,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 12),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.89,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (_, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: AppColor.primary, borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const WidgetImageAsset(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                        url: AppImages.icNews,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                        child: Column(
                          children: [
                            Text(
                              "Chia sẽ cách sử dụng máy pha cà phê",
                              style: AppTextStyles.customTextStyle().copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.colorButton,
                                  fontSize: 12,
                                  fontFamily: Fonts.Quicksand.name),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const WidgetSvg(
                                  path: AppImages.icCalendar,
                                  fit: BoxFit.contain,
                                  color: AppColor.colorTitleHome,
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                  style: AppTextStyles.customTextStyle().copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.colorTitleHome,
                                      fontSize: 12,
                                      fontFamily: Fonts.Quicksand.name),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
