import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';

class WidgetHeaderBottomSheet extends StatelessWidget {
  const WidgetHeaderBottomSheet({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildTitleService(),
        const Divider(height: 1, color: AppColor.colorButton,)
      ],
    );
  }
  Widget _buildHeader() {
    return Container(
      height: 4,
      width: 40,
      margin: const EdgeInsets.only(top: 17),
      decoration: BoxDecoration(
        color: AppColor.lineColor,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildTitleService() {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 18, left: 30, right: 29),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: AppTextStyles.customTextStyle().copyWith(
            fontWeight: FontWeight.w600, fontSize: 16, height: 1.0, color: AppColor.black),
      ),
    );
  }
}
