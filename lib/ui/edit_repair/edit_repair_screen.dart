import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/product_entity.dart';
import 'package:machine_care/ui/create_repair/widget/widget.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/currency_formatter.dart';
import 'package:machine_care/utils/string_utils.dart';

class EditRepairScreen extends BaseScreen<EditRepairController> {
  EditRepairScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetLoadingFullScreen<EditRepairController>(
      child: Scaffold(
        backgroundColor: AppColor.colorBanner,
        body: Column(
          children: [
            WidgetHeader(
              title: 'edit_repair'.tr,
              isBackground: true,
            ),
            Obx(() => Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(color: AppColor.white, boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 4),
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
                              StringUtils.targetMachineType(targetMachine: controller.target.value),
                              style: AppTextStyles.customTextStyle().copyWith(
                                  fontFamily: Fonts.Quicksand.name,
                                  fontSize: 10,
                                  color: AppColor.colorButton,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
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
                          des: 'no_edit'.tr,
                          child: Obx(() => WidgetItemService(
                                title: 'standard_maintenance'.tr,
                                money: controller.moneyService.value.toString(),
                                selected: controller.target.value == TargetMachine.frequent,
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
                    des: 'no_edit'.tr,
                    child: ValueListenableBuilder(
                      valueListenable: controller.selected,
                      builder: (_, product, __) {
                        ProductEntity entity = product.productId ?? ProductEntity();
                        return WidgetItemService(
                          title: "${entity.nameMaintenance}",
                          url:
                          (entity.imageMachine!.isNotEmpty && entity.imageMachine != null)
                              ? entity.imageMachine?.first.url
                              : null,
                          selected: entity.sId != null,
                          onPressed: () {
                            // controller.updateProduct(element);
                          },
                        );
                      })
                ),
                WidgetItemChildRepair(
                  title: 'appointment_time'.tr,
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildDateInput(
                            title: 'day'.tr,
                            des: "(Bắt buộc)",
                            controller: controller.startDateController,
                            context: context,
                            selectedDate: controller.starTime ?? DateTime.now(),
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
                Visibility(
                    visible: controller.target.value != TargetMachine.frequent,
                    child: WidgetItemChildRepair(
                        title: 'error'.tr, des: "(Bắt buộc)", child: _buildError())),
                WidgetItemChildRepair(
                    title: 'address'.tr, des: "(Bắt buộc)", child: _buildAddress()),
                _buildStatus(entity: controller.statusEnum),
                WidgetItemChildRepair(
                    title: 'error_other'.tr,
                    child: WidgetTextField(
                      controller: controller.noteTextController,
                      hint: 'input_text'.tr,
                      onChanged: (value) {
                        controller.message.value = value;
                      },
                    )),
                WidgetButton(
                  title: 'edit_repair'.tr,
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
  Widget _buildAddress() {
    return Obx(() => Column(
          children: [
            Visibility(
                visible: controller.address.value.id == null,
                child: GestureDetector(
                  onTap: () async {
                    Get.bottomSheet(
                        BottomSheetAddress(
                            selectedAddress: controller.address.value,
                            onUpdateAddress: (address) {
                              controller.updateAddress(address);
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
                          'list_address'.tr,
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
              visible: controller.address.value.id != null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetAddress( isHide: true,entity: controller.address.value, onPressed: () {
                    Get.bottomSheet(
                        BottomSheetAddress(
                            selectedAddress: controller.address.value,
                            onUpdateAddress: (address) {
                              controller.updateAddress(address);
                            }),
                        backgroundColor: AppColor.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                        enterBottomSheetDuration: const Duration(milliseconds: 500),
                        barrierColor: Colors.black.withOpacity(0.3));
                  }, ),

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
          enable: false,
          onRightIconPressed: () async {
            final DateTime? result = await pickDate(context, selectedDate);
            if (result == null) return;
            controller.text = DateFormat('dd-MM-yyyy').format(result);
            onUpdate?.call(result);
          },
          iconRight: Container(
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
          enable: false,
          onRightIconPressed: () async {
            final TimeOfDay? result = await showTime(context, selectedTime);
            if (result == null) return;
            final formattedTimeOfDay = CurrencyFormatter.formatTimeOfDay(timeOfDay: result);
            controller.text = formattedTimeOfDay;
            onUpdate?.call(result);
          },
          iconRight: Container(
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

  Widget _buildStatus({required StatusEnum entity}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(
        top: 17,
        left: 16,
        right: 16,
        bottom: 17,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.white,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'status'.tr,
                style: AppTextStyles.customTextStyle().copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColor.colorTitleHome,
                    fontFamily: Fonts.Quicksand.name),
              ),
            ),
            Text(
              StringUtils.statusValueOf(entity),
              style: AppTextStyles.customTextStyle().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: StringUtils.statusTypeColor(entity),
                  fontFamily: Fonts.Quicksand.name),
            )
          ],
        )
      ),
    );
  }
}



