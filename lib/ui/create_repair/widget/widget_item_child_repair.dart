import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';

import '../../ui.dart';
class WidgetItemChildRepair extends StatelessWidget {
  const WidgetItemChildRepair({Key? key, required this.title, required this.child, this.des})
      : super(key: key);
  final String title;
  final String? des;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        _buildTitle(title: title, des: des),
        const SizedBox(
          height: 10,
        ),
        child,
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildTitle({required String title, String? des}) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.customTextStyle().copyWith(
              fontFamily: Fonts.Quicksand.name,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.black),
        ),
        const SizedBox(
          width: 13,
        ),
        if (des != null)
          Text(
            des,
            style: AppTextStyles.customTextStyle().copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.primary,
                fontStyle: FontStyle.italic,
                fontFamily: Fonts.Quicksand.name),
          )
      ],
    );
  }
}

