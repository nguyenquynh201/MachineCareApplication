import 'package:flutter/material.dart';

import '../ui.dart';

class WidgetLoadingFullScreen<T extends BaseController> extends StatelessWidget {
  final Widget child;
  final Color? colorBackground;
  final Color? colorLoading;

  const WidgetLoadingFullScreen(
      {Key? key, required this.child, this.colorBackground, this.colorLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<T>(builder: (_) {
      return Stack(
        children: <Widget>[
          child,
          _.loading.value
              ? LoadingWidget(background: colorBackground, colorLoading: colorLoading)
              : Container(),
        ],
      );
    });
  }
}

class LoadingWidget extends StatelessWidget {
  final Color? background;
  final Color? colorLoading;

  const LoadingWidget({Key? key, this.background, this.colorLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background ?? Colors.black38,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: WidgetLoadingCircle(
            color: colorLoading,
          ),
        ),
      ),
    );
  }
}
