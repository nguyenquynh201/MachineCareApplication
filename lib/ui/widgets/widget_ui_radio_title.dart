import 'package:flutter/material.dart';
import 'package:machine_care/constants/app_colors.dart';
import 'package:machine_care/ui/ui.dart';

typedef OnRadioChanged = Function(dynamic);

class UIRadioTitle extends StatelessWidget {
  final String title;
  final dynamic value;
  final dynamic groupValue;
  final OnRadioChanged? onChanged;
  final bool? isSelected;
  final String icon;
  const UIRadioTitle(
      {Key? key,
      required this.title,
      required this.value,
      required this.groupValue,
      this.onChanged,
      this.isSelected,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColor.primary , width: 1)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UIIconButton(
              child: UIRadioButton(
                size: 20,
                selected: (value == groupValue),
              ),
              onPressed: () {
                onChanged?.call(value);
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  child: Text(
                    title,
                    style:  TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.colorTitleHome,
                      fontFamily: Fonts.Quicksand.name
                    ),
                  ),
                ),
              ),
            ),
            WidgetSvg(
              path: icon,
              width: 24,
              height: 24,
              isColor: true,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
