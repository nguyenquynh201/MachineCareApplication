import 'package:flutter/material.dart';
import 'package:machine_care/constants/app_colors.dart';
import 'package:machine_care/constants/app_images.dart';
import 'package:machine_care/constants/app_text_styles.dart';
import 'package:machine_care/ui/ui.dart';

class WidgetButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final String title;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final bool loading;
  final bool enabled;
  final TypeButton typeButton;
  const WidgetButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.padding = EdgeInsets.zero,
    this.titleStyle,
    this.backgroundColor,
    this.loading = false,
    this.enabled = true,
    this.typeButton = TypeButton.none
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextButton(
        onPressed: (enabled == true) ? onPressed : null,
        style: TextButton.styleFrom(
          backgroundColor: onPressed != null
              ? (backgroundColor ?? AppColor.colorButton).withOpacity((enabled == true) ? 1.0 : 0.25)
              : AppColor.primary   ,
          fixedSize: const Size(double.infinity, 46),
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(5),
          ),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
             Visibility(
               visible: typeButton == TypeButton.none,
               child: Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Text(
                      title,
                      style: AppTextStyles.customTextStyle().copyWith(fontSize: 16 , fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
            ),
             ),
            Visibility(
               visible: typeButton == TypeButton.custom,
               child: Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        child: Text(
                          title,
                          style: AppTextStyles.customTextStyle().copyWith(fontSize: 16 , fontWeight: FontWeight.w600),
                        ),
                      ),
                      const WidgetSvg(path: AppImages.iconLogin , height: 24 , width: 24,)
                    ],
                  ),
                ),
            ),
             ),
          ],
        ),
      ),
    );
  }
}
enum TypeButton {none , custom}
