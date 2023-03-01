import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constants/constants.dart';
class WidgetLoading extends StatelessWidget {
  final bool? isLoading;
  final double? size;
  const WidgetLoading({Key? key, this.isLoading = true, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading! ? 1.0 : 0.0,
          child: SpinKitWave(
            color: AppColor.primary,
            size: size ?? 30,
          ),
        ),
      ),
    );
  }
}

class WidgetLoadingCircle extends StatelessWidget {
  final bool? isLoading;
  final double? size;
  final Color? color;
  const WidgetLoadingCircle({Key? key, this.isLoading = true, this.size, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading! ? 1.0 : 0.0,
          child: SpinKitCircle(
            color: color ?? AppColor.primary,
            size: size ?? 45,
          ),
        ),
      ),
    );
  }
}
