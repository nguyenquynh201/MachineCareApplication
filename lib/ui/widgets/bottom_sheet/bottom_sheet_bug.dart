import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/utils.dart';

class BottomSheetBug extends StatefulWidget {
  const BottomSheetBug({Key? key, required this.updateBug}) : super(key: key);
  final Function(BugEntity entity) updateBug;

  @override
  State<BottomSheetBug> createState() => _BottomSheetBugState();
}

class _BottomSheetBugState extends State<BottomSheetBug> {
  ValueNotifier<TextEditingController> nameController = ValueNotifier(TextEditingController());
  ValueNotifier<TextEditingController> priceController = ValueNotifier(TextEditingController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WidgetHeaderBottomSheet(title: 'bug_other'),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ValueListenableBuilder(
                      valueListenable: nameController,
                      builder: (_, name, __) {
                        return _buildItemBug(
                            title: 'name_bug'.tr, hint: 'name_bug'.tr, controller: name);
                      }),
                  ValueListenableBuilder(
                      valueListenable: priceController,
                      builder: (_, price, __) {
                        return _buildItemBug(
                            title: 'price_bug'.tr,
                            hint: '123.000VND',
                            controller: price,
                            type: TextInputType.number,
                            onChanged: (value) {
                              price.text = CurrencyFormatter.encoded(price: value.trim());
                              price.selection = TextSelection.fromPosition(
                                  TextPosition(offset: price.text.length));
                            });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  WidgetButton(
                    title: 'apply'.tr,
                    onPressed: () {
                      if(nameController.value.text.isEmpty || priceController.value.text.isEmpty) {
                        AppUtils.showToast('isEmpty'.tr);
                      }else {
                        BugEntity entity = BugEntity(
                            nameBug: nameController.value.text,
                            priceBug: num.parse(CurrencyFormatter.decoded(price: priceController.value.text)));
                        Get.back();
                        widget.updateBug.call(entity);
                      }
                    },
                    backgroundColor: AppColor.colorButton,
                    enabled: true,
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

bool get enable {
    var value =!StringUtils.isEmpty(nameController.value.text) &&
        !StringUtils.isEmpty(priceController.value.text);
    setState(() {
      value = value;
    });
    return value;

  }

  Widget _buildItemBug(
      {required String title,
      required String hint,
      Function(String)? onChanged,
      required TextEditingController controller , TextInputType type = TextInputType.text}) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.customTextStyle().copyWith(
              fontFamily: Fonts.Quicksand.name,
              fontSize: 18,
              color: AppColor.colorButton,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          WidgetInput(
            hint: hint,
            keyboardType: type,
            controller: controller,
            typeInput: TypeInput.custom,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
