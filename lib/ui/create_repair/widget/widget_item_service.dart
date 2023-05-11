import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/utils.dart';
class WidgetItemService extends StatelessWidget {
  const WidgetItemService(
      {Key? key,
        this.url,
        required this.title,
        this.money,
        this.selected = false,
        this.onPressed,
        this.onClean,
        this.showIconClean = false})
      : super(key: key);
  final String? url;
  final String title;
  final String? money;
  final bool selected;
  final VoidCallback? onPressed;
  final VoidCallback? onClean;
  final bool showIconClean;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.black.withOpacity(0.25),
                        offset: const Offset(-1, 1),
                        blurRadius: 11,
                        spreadRadius: -4)
                  ],
                  border: selected
                      ? Border.all(color: AppColor.colorFeedback, width: 1)
                      : Border.all(color: AppColor.white)),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, gradient: AppColor.getGradientPrimary),
                      ),
                      Visibility(
                          visible: url != null,
                          child: WidgetImageNetwork(
                            url: url ?? "",
                            height: 80,
                            width: 80,
                            fit: BoxFit.contain,
                          )),
                      Visibility(
                          visible: url == null,
                          child: const WidgetImageAsset(
                            url: AppImages.iconMachine,
                            height: 80,
                            width: 80,
                            fit: BoxFit.contain,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.customTextStyle().copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: AppColor.colorButton,
                          fontFamily: Fonts.Quicksand.name),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Visibility(
                    visible: money != null,
                    child: Text(
                      "${CurrencyFormatter.encoded(price: money ?? "0")}đ",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.customTextStyle().copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 8,
                          color: AppColor.colorTitleHome,
                          fontFamily: Fonts.Quicksand.name),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 2,
              right: 2,
              child: Visibility(
                visible: showIconClean,
                child: GestureDetector(
                  onTap: onClean,
                  child: const WidgetSvg(
                    path: AppImages.iconClean,
                    width: 14,
                    height: 14,
                    fit: BoxFit.contain,
                    color: AppColor.colorButton,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
