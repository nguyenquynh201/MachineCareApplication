import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/utils/string_utils.dart';

import '../../ui.dart';

class BottomSheetService extends StatelessWidget {
  const BottomSheetService({Key? key, required this.updateTarget}) : super(key: key);
  final Function(TargetMachine) updateTarget;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
       WidgetHeaderBottomSheet(title: 'service'.tr),
        _buildItemTarget(StringUtils.targetMachineType(targetMachine: TargetMachine.frequent),
            isLine: true, onPressed: () {
          Get.back(result: true);
          updateTarget.call(TargetMachine.frequent);
        }),
        _buildItemTarget(StringUtils.targetMachineType(targetMachine: TargetMachine.maintenance),
            onPressed: () {
          Get.back(result: true);
          updateTarget.call(TargetMachine.maintenance);
        })
      ],
    );
  }

  Widget _buildItemTarget(String title, {bool isLine = false, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
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
