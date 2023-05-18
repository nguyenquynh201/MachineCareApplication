import 'package:flutter/material.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/string_utils.dart';

class BottomSheetStatus extends StatelessWidget {
  const BottomSheetStatus({Key? key, required this.status, required this.onUpdate})
      : super(key: key);
  final StatusEnum status;
  final Function(StatusEnum) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WidgetHeaderBottomSheet(title: 'status'.tr),

        Expanded(
          child: ListView(
            children: [
              Visibility(
                visible: StatusEnum.Received == status,
                child: WidgetItemSelect(
                  state: StringUtils.statusValueOf(StatusEnum.Received),
                  isMultiPick: false,
                  onPressed: () {
                    Get.back();
                    onUpdate.call(StatusEnum.Received);
                  },
                  color: StringUtils.statusTypeColor(StatusEnum.Received),
                  currentState: StatusEnum.Received == status,
                ),
              ),
              WidgetItemSelect(
                state: StringUtils.statusValueOf(StatusEnum.Coming),
                isMultiPick: false,
                onPressed: () {
                  Get.back();
                  onUpdate.call(StatusEnum.Coming);
                },
                color: StringUtils.statusTypeColor(StatusEnum.Coming),
                currentState: StatusEnum.Coming == status,
              ),
              WidgetItemSelect(
                state: StringUtils.statusValueOf(StatusEnum.Done),
                isMultiPick: false,
                onPressed: () {
                  Get.back();
                  onUpdate.call(StatusEnum.Done);
                },
                color: StringUtils.statusTypeColor(StatusEnum.Done),
                currentState: StatusEnum.Done == status,
              ),
              WidgetItemSelect(
                state: StringUtils.statusValueOf(StatusEnum.Cancel),
                isMultiPick: false,
                onPressed: () {
                  Get.back();
                  onUpdate.call(StatusEnum.Cancel);
                },
                color: StringUtils.statusTypeColor(StatusEnum.Cancel),
                currentState: StatusEnum.Cancel == status,
              ),
            ],
          ),
        )
      ],
    );
  }
}
