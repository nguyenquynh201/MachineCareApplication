import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:machine_care/constants/constants.dart';

class DialogConfirm extends StatelessWidget {
  final String? title;
  final String? content;
  final VoidCallback? actionConfirm;
  final String? titleConfirm;
  final Gradient? confirmBackgroundColor;
  final VoidCallback? actionCancel;
  final String? titleCancel;
  final bool isConfirm;

  const DialogConfirm(
      {Key? key,
        this.actionConfirm,
        this.title,
        this.content,
        this.titleConfirm,
        this.confirmBackgroundColor,
        this.titleCancel,
        this.isConfirm = false,
        this.actionCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: const Color(0XFF302E36),
      child: Stack(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                        text: title ?? "unblock_message".tr,
                        style:
                        AppTextStyles.largeBold().copyWith(color: AppColor.colorButton)),
                    textAlign: TextAlign.center,
                  ),
                  if (content != null)
                    if (content != null)
                      const SizedBox(
                        height: 15,
                      ),
                  if (content != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.5),
                      child: RichText(
                        text: TextSpan(
                            text: "$content ?",
                            style: AppTextStyles.customTextStyle()
                                .copyWith(color: AppColor.colorTitleHome, height: 1.3)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment:
                isConfirm ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                    visible: isConfirm == false ? true : false,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      child: Container(
                        width: Get.width * 0.22,
                        height: 26.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColor.description,
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero, // Set this
                            padding: EdgeInsets.zero, // and this
                          ),
                          onPressed: actionCancel ??
                                  () {
                                Get.back(result: false);
                              },
                          child: Baseline(
                            baseline: 11,
                            baselineType: TextBaseline.alphabetic,
                            child: Text(
                              titleCancel ?? 'no'.tr,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.customTextStyle()
                                  .copyWith(color: AppColor.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    child: Container(
                      width: Get.width * 0.22,
                      height: 26.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
color: AppColor.colorButton                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero, // Set this
                          padding: EdgeInsets.zero, // and this
                        ),
                        onPressed: actionConfirm ??
                                () {
                              actionConfirm ?? Get.back(result: true);
                            },
                        child: Baseline(
                          baseline: 11,
                          baselineType: TextBaseline.alphabetic,
                          child: Text(
                            titleConfirm ?? 'yes'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.customTextStyle().copyWith(color: AppColor.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ]),
    );
  }
}
