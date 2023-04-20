import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:machine_care/resources/model/model.dart';

class WidgetListenableProfile extends StatelessWidget {
  const WidgetListenableProfile({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final Widget? child;
  final Widget Function(BuildContext context, UserEntity? value, Widget? child) builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: Hive.box('AppPref').listenable(),
    builder: (context, Box? box, _) {
      UserEntity? model;
      final _ = box?.get('user');
      if (_ != null) {
        model = UserEntity.fromJson(jsonDecode(_));
      }
      return builder(context, model, child);
    },
  );
}
