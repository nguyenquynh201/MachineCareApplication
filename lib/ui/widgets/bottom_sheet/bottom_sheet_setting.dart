import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';

import '../../ui.dart';

class BottomSheetSetting extends StatefulWidget {
  const BottomSheetSetting(
      {Key? key, required this.isStatus, required this.actionEdit, required this.actionHistory})
      : super(key: key);
  final bool isStatus;
  final VoidCallback actionEdit;
  final VoidCallback actionHistory;

  @override
  State<BottomSheetSetting> createState() => _BottomSheetSettingState();
}

class _BottomSheetSettingState extends State<BottomSheetSetting> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WidgetHeaderBottomSheet(title: 'setting_repair'.tr),
        Visibility(
            visible: widget.isStatus,
            child: _buildItemSetting('edit_repair'.tr, onPressed: () {
              Get.back();
              widget.actionEdit.call();
            }, isLine: true)),
        _buildItemSetting('history_repair'.tr, onPressed: () {
          Get.back();
          widget.actionHistory.call();
        }),
      ],
    );
  }

  Widget _buildItemSetting(String title, {bool isLine = false, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(
              title,
              style: AppTextStyles.customTextStyle().copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColor.colorButton,
                  fontSize: 16,
                  fontFamily: Fonts.Quicksand.name),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
                visible: isLine,
                child: const Divider(
                  height: 1,
                  color: AppColor.primary,
                ))
          ],
        ),
      ),
    );
  }
}
