import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
class WidgetTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hint;
  const WidgetTextField({
    Key? key,
    required this.controller, required this.onChanged, required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(left: 18, bottom: 10, right: 10),
      child: TextField(
          autocorrect: false,
          enableSuggestions: false,
          controller: controller,
          maxLength: 280,
          maxLines: 4,
          decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              counterStyle: AppTextStyles.medium().copyWith(color: AppColor.colorTitleHome)),
          style: AppTextStyles.medium(),
          onChanged: onChanged
      ),
    );
  }
}
