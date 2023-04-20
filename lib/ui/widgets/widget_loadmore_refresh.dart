import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../ui.dart';

class WidgetLoadMoreRefresh extends StatefulWidget {
  final Widget? child;
  final RefreshController controller;
  final VoidCallback onLoadMore;
  final VoidCallback? onRefresh;
  final Widget? header;
  final Axis? axis;
  final String? title;
  final bool isNotEmpty;
  const WidgetLoadMoreRefresh(
      {Key? key,
        this.child,
        required this.controller,
        required this.onLoadMore,
        this.header,
        this.isNotEmpty = true,
        this.axis,
        required this.onRefresh,
        this.title})
      : super(key: key);

  @override
  _WidgetLoadMoreRefreshState createState() => _WidgetLoadMoreRefreshState();
}

class _WidgetLoadMoreRefreshState extends State<WidgetLoadMoreRefresh> {
  @override
  Widget build(BuildContext context) {
    Widget child ;
    if(widget.isNotEmpty) {
      child = widget.child!;
    }else {
      child = _buildIsEmpty();
    }
    return SmartRefresher(
      controller: widget.controller,
      enablePullUp: widget.isNotEmpty,
      enablePullDown: true,
      onLoading: widget.onLoadMore,
      onRefresh: widget.onRefresh,
      scrollDirection: widget.axis,
      header: const ClassicHeader(
        failedIcon: RefreshProgressIndicator(
          color: AppColor.primary,
        ),
        refreshingIcon: RefreshProgressIndicator(
          color: AppColor.primary,
        ),
        releaseIcon: RefreshProgressIndicator(
          color: AppColor.primary,
        ),
        completeIcon: Icon(Icons.done, color: AppColor.primary),
        refreshingText: "",
        releaseText: "",
        failedText: "",
        completeText: "",
        idleIcon: RefreshProgressIndicator(
          color: AppColor.primary,
        ),
        idleText: '',
      ),
      footer: CustomFooter(
        builder: (BuildContext? context, LoadStatus? mode) => FooterLayout(
          mode: mode,
        ),
      ),
      child: child,
    );
  }

  Widget _buildIsEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: WidgetEmpty(
              image: AppImages.emptyViewNew,
              title: widget.title,
            )),
      ],
    );
  }
}

class FooterLayout extends StatelessWidget {
  final LoadStatus? mode;

  const FooterLayout({Key? key, this.mode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (mode == LoadStatus.idle) {
      // body = Text('update_fail_please_try_again'.tr);
      body = const SizedBox();
    } else if (mode == LoadStatus.loading) {
      body = const WidgetLoadingCircle();
    } else if (mode == LoadStatus.failed) {
      body = Text('update_fail_please_try_again'.tr);
    } else if (mode == LoadStatus.canLoading) {
      body = const WidgetLoadingCircle();
    } else {
      body = const WidgetEmpty();
    }
    return SizedBox(
      height: 55.0,
      child: Center(child: body),
    );
  }
}
