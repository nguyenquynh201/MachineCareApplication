import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/ui/ui.dart';
class WidgetEmptyData extends StatelessWidget {
  const WidgetEmptyData({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
            child: WidgetEmpty(
              image: AppImages.emptyViewNew,
              title: title,
            )),
      ],
    );  }
}
