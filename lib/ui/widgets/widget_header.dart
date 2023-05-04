import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/enum/validate.dart';

import '../ui.dart';

class WidgetHeader extends StatelessWidget {
  const WidgetHeader(
      {Key? key,
      this.actions,
      this.address,
      required this.title,
      this.centerTitle = false,
      this.widgetTitle,
      this.leading,
      this.isBackground = false,
      this.isWebView = false,
      this.textStyle,
      this.color,
      this.colorIcon})
      : super(key: key);
  final List<Widget>? actions;
  final String title;
  final String? address;
  final bool centerTitle;
  final Widget? widgetTitle;
  final Widget? leading;
  final bool isBackground;
  final bool isWebView;
  final TextStyle? textStyle;
  final Color? color;
  final Color? colorIcon;

  @override
  Widget build(BuildContext context) {
    var gradient = AppColor.getGradientPrimary;
    var titleColor = AppColor.white;
    if (isBackground) {
      titleColor = AppColor.white;
    } else {
      titleColor = AppColor.colorButton;
    }
    return Container(
      height: AppValues.headerHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: Get.mediaQuery.viewPadding.top, left: 17, right: 17),
      decoration: isBackground
          ? BoxDecoration(gradient: gradient)
          : BoxDecoration(color: color ?? AppColor.white),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading ??
                  WidgetButtonBack(
                    color: colorIcon,
                  ),
              Expanded(
                child: Align(
                  alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
                  child: widgetTitle ??
                      Column(
                        children: [
                          _buildTitle(titleColor),
                          Visibility(
                            visible: address != null,
                            child: _buildAddress(titleColor),
                          )
                        ],
                      ),
                ),
              ),
              ...(actions ?? [])
            ],
          ),
          Visibility(
              visible: isBackground,
              child: const Positioned(
                  right: -80,
                  top: -140,
                  child: Opacity(
                    opacity: 0.5,
                    child: WidgetImageAsset(
                      url: AppImages.icCoffeBg,
                      fit: BoxFit.contain,
                      height: 195,
                      width: 195,
                    ),
                  )))
        ],
      ),
    );
  }

  _buildTitle(Color? titleColor) {
    var titleText = title;
    if (isWebView == true) {
      var unescape = HtmlUnescape();
      titleText = unescape.convert(title);
    }
    return Text(
      titleText,
      style: textStyle ??
          AppTextStyles.superLargeBold()
              .copyWith(color: titleColor ?? Colors.white, fontFamily: Fonts.Quicksand.name),
      maxLines: centerTitle ? 1 : 1000,
      overflow: TextOverflow.ellipsis,
    );
  }

  _buildAddress(Color? titleColor) {
    var titleText = address;
    if (isWebView == true) {
      var unescape = HtmlUnescape();
      titleText = unescape.convert(address ?? "");
    }
    return Text(
      titleText ?? "",
      style: textStyle ??
          AppTextStyles.largeBold()
              .copyWith(color: titleColor ?? Colors.white, fontFamily: Fonts.Quicksand.name),
      maxLines: centerTitle ? 1 : 1000,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class WidgetButtonBack extends StatelessWidget {
  final Color? color;
  final VoidCallback? onBack;
  final double? size;
  final EdgeInsets? padding;
  final Color? highlightColor;
  final Widget? icon;

  const WidgetButtonBack({
    Key? key,
    this.color,
    this.onBack,
    this.size,
    this.padding,
    this.highlightColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: padding ?? const EdgeInsets.all(0),
      highlightColor: highlightColor ?? Colors.transparent,
      color: color ?? Colors.transparent,
      onPressed: onBack ?? () => Get.back(),
      icon: icon ??
          WidgetSvg(path: AppImages.icBack, height: 17, width: 10, color: color ?? AppColor.white),
    );
  }
}
