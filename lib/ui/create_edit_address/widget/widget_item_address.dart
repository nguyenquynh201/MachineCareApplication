import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';

import '../../ui.dart';

class WidgetItemAddress extends StatelessWidget {
  const WidgetItemAddress({Key? key, required this.title, this.des, required this.child})
      : super(key: key);
  final String title;
  final String? des;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(title: title, des: des),
        const SizedBox(
          height: 10,
        ),
        child
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
