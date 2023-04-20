import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/product_entity.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/ui/widgets/bottom_sheet/bottom_sheet_error.dart';
import 'package:machine_care/utils/currency_formatter.dart';
import 'package:machine_care/utils/string_utils.dart';

class CreateRepairScreen extends BaseScreen<CreateRepairController> {
  CreateRepairScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetLoadingFullScreen<CreateRepairController>(
      child: Scaffold(
        backgroundColor: AppColor.colorBanner,
        body:  Column(
          children: [
            WidgetHeader(
              title: 'create_repair'.tr,
              isBackground: true,
              actions: [
                GestureDetector(
                  onTap: () {

                  },
                  child: const WidgetSvg(
                    path: AppImages.iconEdit,
                    fit: BoxFit.contain,
                    height: 24,
                    width: 24,
                  ),
                )
              ],
            ),
            ValueListenableBuilder(
                valueListenable: controller.target,
                builder: (_, target, __) {
                  return Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(color: AppColor.white, boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 10,
                          color: AppColor.black.withOpacity(0.1))
                    ]),
                    child: Row(
                      children: [
                        Container(
                          width: 37,
                          height: 37,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColor.colorTitleHome),
                          child: const Center(
                            child: WidgetSvg(
                              path: AppImages.iconMenuRepair,
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'service'.tr,
                                style: AppTextStyles.customTextStyle().copyWith(
                                    fontFamily: Fonts.Quicksand.name,
                                    fontSize: 10,
                                    color: AppColor.colorTitleHome,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                StringUtils.targetMachineType(targetMachine: target),
                                style: AppTextStyles.customTextStyle().copyWith(
                                    fontFamily: Fonts.Quicksand.name,
                                    fontSize: 10,
                                    color: AppColor.colorButton,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(BottomSheetService(updateTarget: (value) {
                              controller.updateTarget(state: value);
                            }),
                                backgroundColor: AppColor.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                                enterBottomSheetDuration: const Duration(milliseconds: 500),
                                barrierColor: Colors.black.withOpacity(0.3));
                          },
                          child: const RotatedBox(
                            quarterTurns: 1,
                            child: WidgetSvg(
                              path: AppImages.icNext,
                              color: AppColor.colorTitleHome,
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
            Expanded(child: _buildInformation(context: context))

          ],
        ),
      ),
    );
  }
  Widget _buildInformation({required BuildContext context}) {
    return Obx(() => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: controller.target.value == TargetMachine.frequent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetItemChildRepair(
                          title: 'maintenance_service'.tr,
                          child: Obx(() => WidgetItemService(
                                title: 'standard_maintenance'.tr,
                                money: controller.moneyService.value.toString(),
                                selected: controller.selectedService.value,
                                onPressed: () {
                                  controller
                                      .updateSelectedService(!controller.selectedService.value);
                                },
                              )))
                    ],
                  ),
                ),
                WidgetItemChildRepair(
                  title: 'product'.tr,
                  des: "(Bắt buộc)",
                  child: Row(
                    children: [
                      ...controller.productList.map((element) {
                        ProductEntity entity = element.productId as ProductEntity;
                        return ValueListenableBuilder(
                            valueListenable: controller.selected,
                            builder: (_, product, __) {
                              return WidgetItemService(
                                title: "${entity.nameMaintenance}",
                                url:
                                    (entity.imageMachine!.isNotEmpty && entity.imageMachine != null)
                                        ? entity.imageMachine?.first.url
                                        : null,
                                selected: (product.productId != null &&
                                    product.productId == element.productId),
                                onPressed: () {
                                  controller.updateProduct(element);
                                },
                              );
                            });
                      })
                    ],
                  ),
                ),
                WidgetItemChildRepair(
                  title: 'appointment_time'.tr,
                  child: Row(
                    children: [
                      Expanded(
                        child: ValueListenableBuilder(
                            valueListenable: controller.starTime,
                            builder: (_, startTime, __) {
                              return _buildDateInput(
                                  title: 'day'.tr,
                                  des: "(Bắt buộc)",
                                  controller: controller.startDateController,
                                  context: context,
                                  selectedDate: startTime,
                                  errorMessage: StringUtils.toErrorTimeString(
                                      controller.timeValidateState.value),
                                  onUpdate: (dateTime) {
                                    String towDigits(int n) => n.toString().padLeft(2, '0');
                                    String? index = towDigits(DateTime.now().minute);
                                    controller.timeOfDayStartController.text =
                                        "${DateTime.now().hour} : $index";
                                    controller.updateStartDate(dateTime);
                                    controller.updateStartTimeOfDay(TimeOfDay(
                                        hour: DateTime.now().hour, minute: DateTime.now().minute));
                                  });
                            }),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: ValueListenableBuilder(
                        valueListenable: controller.timeOfDayStart,
                        builder: (_, timeOfDay, __) {
                          return _buildTimeInput(
                            context: context,
                            title: 'hour'.tr,
                            des: "(Bắt buộc)",
                            controller: controller.timeOfDayStartController,
                            onUpdate: (dateTime) {},
                            errorMessage: StringUtils.toErrorTimeString(
                                controller.timeOfDayValidateState.value),
                            selectedTime: timeOfDay,
                          );
                        },
                      ))
                    ],
                  ),
                ),
                WidgetItemChildRepair(title: 'error'.tr ,  des: "(Bắt buộc)", child: _buildError()),
                WidgetItemChildRepair(
                    title: 'error_other'.tr,
                    child: _WidgetTexField(
                      controller: controller,
                    )),
                WidgetButton(
                  title: 'create_repair'.tr,
                  enabled: controller.enable.value,
                  onPressed: () {
                    controller.createRepair();
                  },
                  typeButton: TypeButton.none,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildError() {
    return Obx(() => Column(
          children: [
            Visibility(
                visible: controller.error.isEmpty,
                child: GestureDetector(
                  onTap: () async {
                    Get.bottomSheet(
                        BottomSheetError(
                            selectedError: controller.error,
                            onUpdateError: (error) {
                              controller.updateError(error);
                            }),
                        backgroundColor: AppColor.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                        enterBottomSheetDuration: const Duration(milliseconds: 500),
                        barrierColor: Colors.black.withOpacity(0.3));
                  },
                  child: Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 20),
                    decoration: BoxDecoration(
                        color: AppColor.colorBanner,
                        border: Border.all(color: AppColor.colorTitleHome, width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Danh sách lỗi',
                          style: AppTextStyles.customTextStyle().copyWith(
                              fontFamily: Fonts.Quicksand.name,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.colorButton),
                        )),
                        const RotatedBox(
                            quarterTurns: 1,
                            child: WidgetSvg(
                              path: AppImages.icNext,
                              height: 24,
                              width: 24,
                              color: AppColor.colorButton,
                              fit: BoxFit.contain,
                            ))
                      ],
                    ),
                  ),
                )),
            Visibility(
              visible: controller.error.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 130,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.error.length,
                          itemBuilder: (_, index) {
                            final entity = controller.error.elementAt(index);
                            return WidgetItemService(
                              title: entity.maintenanceContent ?? "",
                              onPressed: () {},
                              onClean: () {
                                controller.removeError(entity);
                              },
                              showIconClean: true,
                              money: CurrencyFormatter.encoded(price: entity.price.toString()),
                            );
                          })),
                  const SizedBox(
                    height: 5,
                  ),
                  _buildAddButton(() {
                    Get.bottomSheet(
                        BottomSheetError(
                            selectedError: controller.error,
                            onUpdateError: (error) {
                              controller.updateError(error);
                            }),
                        backgroundColor: AppColor.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                        enterBottomSheetDuration: const Duration(milliseconds: 500),
                        barrierColor: Colors.black.withOpacity(0.3));
                  })
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildDateInput(
      {required String title,
      required TextEditingController controller,
      required BuildContext context,
      Function(DateTime)? onUpdate,
      DateTime? selectedDate,
      String? errorMessage,
      String? des}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppTextStyles.customTextStyle().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.colorTitleHome,
                  fontFamily: Fonts.Quicksand.name),
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
        ),
        const SizedBox(height: 8),
        WidgetInput(
          hint: "dd-MM-yyyy",
          keyboardType: TextInputType.text,
          controller: controller,
          typeInput: TypeInput.custom,
          errorMessage: errorMessage,
          onRightIconPressed: () async {
            final DateTime? result = await pickDate(context, selectedDate);
            if (result == null) return;
            controller.text = DateFormat('dd-MM-yyyy').format(result);
            onUpdate?.call(result);
          },
          iconRight: Container(
            color: AppColor.white,
            padding: const EdgeInsets.all(10),
            child: const WidgetSvg(
              path: AppImages.icCalendar,
              width: 18,
              height: 18,
              color: AppColor.colorTitleHome,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Future<DateTime?> pickDate(BuildContext context, DateTime? selectedDate) async {
    return showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: EndPoint.TWO_MONTH)),
      lastDate: DateTime.now().add(const Duration(days: EndPoint.TWO_MONTH)),
    ).then((DateTime? value) {
      if (value == null) return null;
      return value;
    });
  }

  Widget _buildTimeInput(
      {required String title,
      required TextEditingController controller,
      required BuildContext context,
      Function(TimeOfDay)? onUpdate,
      TimeOfDay? selectedTime,
      String? errorMessage,
      String? des}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppTextStyles.customTextStyle().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.colorTitleHome,
                  fontFamily: Fonts.Quicksand.name),
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
        ),
        const SizedBox(height: 8),
        WidgetInput(
          hint: "HH-mm",
          keyboardType: TextInputType.text,
          controller: controller,
          typeInput: TypeInput.custom,
          onRightIconPressed: () async {
            final TimeOfDay? result = await showTime(context, selectedTime);
            if (result == null) return;
            final formattedTimeOfDay = CurrencyFormatter.formatTimeOfDay(timeOfDay: result);
            controller.text = formattedTimeOfDay;
            onUpdate?.call(result);
          },
          iconRight: Container(
            color: AppColor.white,
            padding: const EdgeInsets.all(10),
            child: const WidgetSvg(
              path: AppImages.iconAlarm,
              width: 18,
              height: 18,
              color: AppColor.colorTitleHome,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Future<TimeOfDay?> showTime(BuildContext context, TimeOfDay? selectedTime) {
    return showTimePicker(context: context, initialTime: selectedTime ?? TimeOfDay.now())
        .then((value) {
      if (value == null) return null;
      print(value);
      controller.updateTime(value);
      return value;
    });
  }

  Widget _buildAddButton(VoidCallback onPressed) {
    return Material(
      color: AppColor.colorBanner,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColor.colorTitleHome, width: 1)),
          child: Row(
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: UIDottedButton(
                  borderType: BorderType.RRect,
                  strokeWidth: 1,
                  radius: const Radius.circular(8),
                  child: Container(
                    alignment: Alignment.center,
                    child: const WidgetSvg(
                      path: AppImages.iconPlus,
                      fit: BoxFit.contain,
                      width: 16,
                      height: 16,
                      color: AppColor.colorTitleHome,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  child: Text(
                    'add_error'.tr,
                    style: AppTextStyles.customTextStyle().copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: AppColor.colorTitleHome,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetItemService extends StatelessWidget {
  const WidgetItemService(
      {Key? key,
      this.url,
      required this.title,
      this.money,
      this.selected = false,
      this.onPressed,
      this.onClean,
      this.showIconClean = false})
      : super(key: key);
  final String? url;
  final String title;
  final String? money;
  final bool selected;
  final VoidCallback? onPressed;
  final VoidCallback? onClean;
  final bool showIconClean;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: AppColor.black.withOpacity(0.25),
                      offset: const Offset(-1, 1),
                      blurRadius: 11,
                      spreadRadius: -4)
                ],
                border: selected
                    ? Border.all(color: AppColor.colorFeedback, width: 1)
                    : Border.all(color: AppColor.white)),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, gradient: AppColor.getGradientPrimary),
                    ),
                    Visibility(
                        visible: url != null,
                        child: WidgetImageNetwork(
                          url: url ?? "",
                          height: 80,
                          width: 80,
                          fit: BoxFit.contain,
                        )),
                    Visibility(
                        visible: url == null,
                        child: const WidgetImageAsset(
                          url: AppImages.iconMachine,
                          height: 80,
                          width: 80,
                          fit: BoxFit.contain,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.customTextStyle().copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      color: AppColor.colorButton,
                      fontFamily: Fonts.Quicksand.name),
                ),
                const SizedBox(
                  height: 4,
                ),
                Visibility(
                  visible: money != null,
                  child: Text(
                    "${CurrencyFormatter.encoded(price: money ?? "0")}đ",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.customTextStyle().copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 8,
                        color: AppColor.colorTitleHome,
                        fontFamily: Fonts.Quicksand.name),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 2,
            right: 2,
            child: Visibility(
              visible: showIconClean,
              child: GestureDetector(
                onTap: onClean,
                child: const WidgetSvg(
                  path: AppImages.iconClean,
                  width: 14,
                  height: 14,
                  fit: BoxFit.contain,
                  color: AppColor.colorButton,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

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
        _buildTitle(title: title , des: des),
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

  Widget _buildTitle({required String title , String? des}) {
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

class _WidgetTexField extends StatelessWidget {
  final CreateRepairController controller;

  const _WidgetTexField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(left: 18, bottom: 10, right: 10),
      child: TextField(
        autocorrect: false,
        enableSuggestions: false,
        controller: controller.noteTextController,
        maxLength: 280,
        maxLines: 4,
        decoration: InputDecoration(
            hintText: 'input_text'.tr,
            border: InputBorder.none,
            counterStyle: AppTextStyles.medium().copyWith(color: AppColor.colorTitleHome)),
        style: AppTextStyles.medium(),
        onChanged: (text) {
          controller.message.value = text;
        },
      ),
    );
  }
}
