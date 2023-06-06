import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/product_entity.dart';
import 'package:machine_care/routers/app_routes.dart';
import 'package:machine_care/ui/create_repair/widget/widget.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/utils.dart';

class RepairDetailScreen extends BaseScreen<RepairDetailController> {
  RepairDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetLoadingFullScreen<RepairDetailController>(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.colorBanner,
        body: Stack(
          children: [
            Column(
              children: [
                WidgetHeader(
                  title: 'repair_detail'.tr,
                  actions: [
                    GestureDetector(
                      onTap: () {
                        _buildMoreSetting(
                            isStatus: controller.entity.value.status == StatusEnum.Waiting);
                      },
                      child: const WidgetSvg(
                        path: AppImages.iconSetting,
                        height: 4,
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                  isBackground: true,
                ),
                Expanded(child: _buildBody())
              ],
            ),
            _buildContentComment(),
          ],
        ),
      ),
    ));
  }

  Widget _buildBody() {
    return Obx(() => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 24, bottom: 24, left: 15, right: 15),
            child: Column(
              children: [
                _buildTitle(title: 'information'.tr),
                _buildRepairInfo(entity: controller.entity.value),
                Visibility(visible: controller.bugEntity.isNotEmpty, child: _buildBug()),
                _buildAddress(controller.entity.value.address),
                _buildProduct(entity: controller.entity.value.products),
                _buildError(entities: controller.entity.value.errorMachine),
                _buildStaff(entity: controller.entity.value.relateStaffs),
                Visibility(
                    visible: controller.entity.value.status == StatusEnum.Done,
                    child: _buildRating(entity: controller.ratingEntity.value)),
                _buildComment()
              ],
            ),
          ),
        ));
  }

  Widget _buildBug() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildTitle(title: 'bug_other'.tr), _buildItemBug()],
    );
  }

  Widget _buildItemBug() {
    return Obx(
      () => Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.white,
          ),
          child: Column(
            children: [
              ...List.generate(controller.bugEntity.length, (index) {
                final entity = controller.bugEntity.elementAt(index);
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: AppColor.colorBanner, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${'name_bug'.tr}: ${entity.nameBug}",
                        style: AppTextStyles.customTextStyle().copyWith(
                          fontFamily: Fonts.Quicksand.name,
                          fontSize: 18,
                          color: AppColor.colorButton,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${'price_bug'.tr}: ${CurrencyFormatter.encoded(price: entity.priceBug.toString())} VND",
                        style: AppTextStyles.customTextStyle().copyWith(
                          fontFamily: Fonts.Quicksand.name,
                          fontSize: 14,
                          color: AppColor.borderError,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Visibility(
                visible: (controller.entity.value.status != StatusEnum.Done &&
                    AppPref.user.role != null &&
                    AppPref.user.role == 'staff'),
                child: _buildAddButton(() {
                  Get.bottomSheet(BottomSheetBug(
                    updateBug: (entity) {
                      controller.updateBug(entity: entity);
                    },
                  ),
                      backgroundColor: AppColor.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                      enterBottomSheetDuration: const Duration(milliseconds: 500),
                      barrierColor: Colors.black.withOpacity(0.3));
                }),
              )
            ],
          )),
    );
  }

  Widget _buildAddButton(VoidCallback onPressed) {
    return Material(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(5),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          decoration: BoxDecoration(
              color: AppColor.colorBanner,
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
                    'add_bug_other'.tr,
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

  Widget _buildComment() {
    return Obx(() => Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.only(
            top: 17,
            bottom: 17,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(title: 'comment'.tr),
              const SizedBox(
                height: 16,
              ),
              Visibility(visible: controller.comments.isNotEmpty, child: _buildListComment()),
            ],
          ),
        ));
  }

  Widget _buildContentComment() {
    return Obx(() => Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            decoration: const BoxDecoration(color: AppColor.white),
            child: Row(
              children: [
                WidgetThumbnail(url: AppPref.user.avatar),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: _buildInput(
                      hint: 'postComment'.tr,
                      controller: controller.commentController.value,
                      onFocus: controller.onFocusContent,
                      onChanged: controller.onChangedContent,
                      iconRight: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: controller.comment.value.isNotEmpty
                              ? _buildIconComment(color: AppColor.colorSupport)
                              : _buildIconComment(color: AppColor.lineColor)),
                      onRightIconPressed: () {
                        if (controller.comment.value.isNotEmpty) {
                          FocusScope.of(Get.context!).unfocus();
                          controller.addComment();
                          controller.comment.value = "";
                          controller.commentController.value.clear();
                        }
                      }),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildIconComment({required Color color}) {
    return SizedBox(
      width: 35,
      height: 35,
      child: Center(
        child: WidgetSvg(
          path: AppImages.iconSend,
          fit: BoxFit.contain,
          color: color,
        ),
      ),
    );
  }

  Widget _buildListComment() {
    return GetX<RepairDetailController>(builder: (_) {
      return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 40),
          itemBuilder: (context, index) {
            if (_.comments.isEmpty) {
              return Container();
            } else {
              return WidgetComment(
                  comment: _.comments.elementAt(index), controller: controller, index: index);
            }
          },
          separatorBuilder: (_, index) {
            return const Divider(
              thickness: 1,
              color: AppColor.lineColor,
            );
          },
          itemCount: _.comments.length);
    });
  }

  Widget _buildStaff({List<UserEntity>? entity}) {
    if (entity == null || entity.isEmpty) {
      return Container();
    }
    return _buildItemStaff(entity: entity.elementAt(0));
  }

  Widget _buildItemStaff({required UserEntity entity}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildTitle(title: 'staff'.tr), WidgetPerson(entity: entity, onPressed: () {})],
      ),
    );
  }

  Widget _buildRating({RatingEntity? entity}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: entity?.id != null,
            child: _buildIsNotEmptyRating(entity: entity ?? RatingEntity())),
        Visibility(
            visible:
                (entity?.id == null && AppPref.user.role != null && AppPref.user.role == "user"),
            child: _buildIsEmptyRating())
      ],
    );
  }

  Widget _buildIsEmptyRating() {
    return Obx(() => Container(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(title: 'rating'.tr),
              RatingBar.builder(
                  itemPadding: const EdgeInsets.all(5),
                  itemBuilder: (_, __) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                  initialRating: controller.rating.value,
                  minRating: 1,
                  maxRating: 5,
                  allowHalfRating: true,
                  direction: Axis.horizontal,
                  onRatingUpdate: (rating) {
                    controller.updateRating(rating);
                  }),
              const SizedBox(
                height: 10,
              ),
              WidgetTextField(
                controller: controller.commentRatingController,
                hint: 'comment_feedback'.tr,
                onChanged: (value) {
                  controller.comment.value = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              WidgetButton(
                title: 'rating'.tr,
                onPressed: () {
                  controller.feedBackRating();
                },
                typeButton: TypeButton.none,
                enabled: controller.enable.value,
                backgroundColor: AppColor.colorButton,
              )
            ],
          ),
        ));
  }

  Widget _buildIsNotEmptyRating({required RatingEntity entity}) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(title: 'rating'.tr),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration:
                BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingBar.builder(
                    itemBuilder: (_, __) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    initialRating: entity.rating?.toDouble() ?? 0,
                    ignoreGestures: true,
                    allowHalfRating: true,
                    direction: Axis.horizontal,
                    onRatingUpdate: (rating) {}),
                const SizedBox(
                  height: 10,
                ),
                _buildDes(des: entity.comment ?? "")
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRepairInfo({required MaintenanceScheduleEntity entity}) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.white,
      ),
      child: Column(
        children: [
          _buildUnitInfos(
              title: 'service'.tr,
              des: StringUtils.targetMachineType(targetMachine: entity.target)),
          _buildUnitInfos(
              title: 'money'.tr,
              des: "${CurrencyFormatter.encoded(price: entity.totalMoney.toString())}VND"),
          _buildUnitInfos(
              title: 'appointment_time'.tr,
              des:
                  "${DateFormat('dd/MM/yyyy').format(controller.entity.value.startDate?.toLocal() ?? DateTime.now().toLocal())} ${CurrencyFormatter.formatDateToTimeOfDay(timeOfDay: controller.entity.value.startDate?.toLocal() ?? DateTime.now().toLocal())}"),
          _buildStatus(entity: entity),
        ],
      ),
    );
  }

  Widget _buildProduct({ProductEntity? entity}) {
    if (entity == null) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(title: 'product'.tr),
        const SizedBox(
          height: 10,
        ),
        WidgetItemProduct(entity: entity)
      ],
    );
  }

  Widget _buildError({List<ErrorMachineEntity>? entities}) {
    if (entities == null || entities.isEmpty) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(title: 'error'.tr),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              height: 130,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: entities.length,
                  itemBuilder: (_, index) {
                    final entity = entities.elementAt(index);
                    return WidgetItemService(
                      title: entity.maintenanceContent ?? "",
                      onPressed: () {},
                      money: CurrencyFormatter.encoded(price: entity.price.toString()),
                    );
                  })),
        ],
      ),
    );
  }

  Widget _buildAddress(UserAddress? address) {
    if (address == null) {
      return Container();
    }
    return Column(
      children: [
        _buildTitle(title: 'address'.tr),
        const SizedBox(
          height: 10,
        ),
        WidgetAddress(
          entity: address,
          isHide: true,
        )
      ],
    );
  }

  Widget _buildStatus({required MaintenanceScheduleEntity entity}) {
    return ValueListenableBuilder(
        valueListenable: controller.status,
        builder: (_, status, __) {
          return Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColor.white,
            ),
            child: Center(
              child: _buildInfoSelect(
                  title: 'status'.tr,
                  info: status,
                  onPressed: () {
                    Get.bottomSheet(
                        BottomSheetStatus(
                            onUpdate: (value) {
                              if (value == status) {
                                return;
                              } else {
                                controller.updateComment(status: value);
                              }
                            },
                            status: status),
                        backgroundColor: AppColor.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                        enterBottomSheetDuration: const Duration(milliseconds: 500),
                        barrierColor: Colors.black.withOpacity(0.3));
                  }),
            ),
          );
        });
  }

  Widget _buildDateTime({
    required String title,
    required String textDate,
    required String textTimeDate,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                color: AppColor.white,
                padding: const EdgeInsets.all(10),
                child: const WidgetSvg(
                  path: AppImages.icCalendar,
                  color: AppColor.lineColor,
                  width: 18,
                ),
              ),
              _buildTitleDate("$textDate $textTimeDate")
            ],
          ),
          const Divider(
            color: AppColor.lineColor,
            thickness: 1,
            endIndent: 10,
          )
        ],
      ),
    );
  }

  Widget _buildTitle({required String title, String? des}) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.customTextStyle().copyWith(
              fontFamily: Fonts.Quicksand.name,
              fontSize: 18,
              fontWeight: FontWeight.w800,
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

  Widget _buildInfoSelect(
      {required String title, required StatusEnum info, VoidCallback? onPressed}) {
    bool isRole = AppPref.user.role != null &&
        AppPref.user.role == 'staff' &&
        !(info == StatusEnum.Done || info == StatusEnum.Cancel);
    return GestureDetector(
      onTap: () {
        if (isRole) {
          onPressed?.call();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _buildTitleInput(title: title)),
            Row(
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: Text(
                    StringUtils.statusValueOf(info),
                    style: AppTextStyles.customTextStyle().copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: StringUtils.statusTypeColor(info),
                        fontFamily: Fonts.Quicksand.name),
                  ),
                ),
                Visibility(
                  visible: isRole,
                  child: const WidgetSvg(
                    path: AppImages.icNext,
                    color: AppColor.description,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUnitInfos({required String title, required String des, String? focus}) {
    return Container(
        padding: const EdgeInsets.only(
          top: 8,
          left: 16,
          right: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColor.white,
        ),
        child: _buildTextInfor(title: title, des: des, focus: focus));
  }

  Widget _buildTextInfor({required String title, required String des, String? focus}) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildTitleInput(title: title, focus: focus), _buildDes(des: des)],
      ),
    );
  }

  Widget _buildDes({required String des}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 4,
          ),
          child: Text(
            des,
            style: AppTextStyles.customTextStyle().copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColor.colorTitleHome,
                fontFamily: Fonts.Quicksand.name),
          ),
        ),
        const Divider(
          thickness: 1,
          color: AppColor.lineColor,
        )
      ],
    );
  }

  Widget _buildTitleInput({required String title, String? focus}) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.customTextStyle().copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColor.colorTitleHome,
              fontFamily: Fonts.Quicksand.name),
        ),
        const SizedBox(
          width: 8,
        ),
        if (!StringUtils.isEmpty(focus))
          Text(
            focus!,
            style: AppTextStyles.customTextStyle().copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColor.borderError,
                fontFamily: Fonts.Quicksand.name),
          ),
      ],
    );
  }

  Widget _buildTitleDate(String title) {
    return Text(
      title,
      style: AppTextStyles.customTextStyle().copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColor.colorTitleHome,
          fontFamily: Fonts.Quicksand.name),
      maxLines: 2,
    );
  }

  Future _buildMoreSetting({required bool isStatus}) {
    return Get.bottomSheet(
        BottomSheetSetting(
            isStatus: isStatus,
            actionEdit: () async {
              var _ = await Get.toNamed(Routes.repairEdit, arguments: controller.entity.value);
              if (_ != null && _) {
                controller.getMaintenanceSchedule(
                    id: (Get.arguments as MaintenanceScheduleEntity).sId.toString());
              }
            },
            actionHistory: () {
              Get.toNamed(Routes.repairHistory, arguments: controller.entity.value);
            }),
        backgroundColor: AppColor.white,
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        enterBottomSheetDuration: const Duration(milliseconds: 500),
        barrierColor: Colors.black.withOpacity(0.3));
  }

  Widget _buildInput({
    required TextEditingController controller,
    String? errorMessage,
    String? hint,
    Function(String)? onChanged,
    Function()? onFocus,
    TextInputType textInputType = TextInputType.text,
    VoidCallback? onRightIconPressed,
    Widget? iconRight,
  }) {
    return UIInputComment(
      controller: controller,
      errorMessage: errorMessage,
      onChanged: onChanged,
      onFocus: onFocus,
      hint: hint,
      keyboardType: textInputType,
      onRightIconPressed: onRightIconPressed,
      iconRight: iconRight,
    );
  }
}
