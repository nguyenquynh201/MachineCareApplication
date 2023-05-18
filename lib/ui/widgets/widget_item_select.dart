import 'package:flutter/material.dart';
import 'package:machine_care/constants/app_colors.dart';
import 'package:machine_care/constants/app_text_styles.dart';
import 'package:machine_care/ui/ui.dart';

class WidgetItemSelect extends StatelessWidget {
  const WidgetItemSelect(
      {Key? key,
      required this.state,
      this.currentState = false,
      this.color,
      this.onPressed,
      required this.isMultiPick})
      : super(key: key);
  final String state;
  final bool currentState;
  final Color? color;
  final VoidCallback? onPressed;
  final bool isMultiPick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                state,
                style: AppTextStyles.customTextStyle().copyWith(
                  fontSize: 15,
                  color: color ?? AppColor.colorButton,
                  fontFamily: Fonts.Quicksand.name
                ),
              ),
            ),
            UIIconButton(
              child: (isMultiPick)
                  ? UICheckboxButton(
                      selected: currentState,
                      size: 24,
                      borderRadius: 6,

                    )
                  : UIRadioButton(
                      selected: currentState,
                      size: 24,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
