import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/resources/repository/app_repository.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BottomSheetError extends StatefulWidget {
  const BottomSheetError({Key? key, this.selectedError = const [], this.onUpdateError}) : super(key: key);

  final List<ErrorMachineEntity> selectedError;
  final Function(List<ErrorMachineEntity>)? onUpdateError;
  @override
  State<BottomSheetError> createState() => _BottomSheetErrorState();
}

class _BottomSheetErrorState extends State<BottomSheetError> {
  late RefreshController controller;
  List<ErrorMachineEntity> error = [];
  final List<ErrorMachineEntity> _selectedError = [];

  List<ErrorMachineEntity> get selectedLabels => List.unmodifiable(_selectedError);

  List<String> get selectedLabelIds => _selectedError.map((error) => error.sId!).toList();
  int? total;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedError.addAll(widget.selectedError);
    initData();
  }

  void initData() async {
    controller = RefreshController();
    await getError();
  }

  void onRefresh() async {
    try {
      setState(() {
        isLoading = true;
      });
      total = 0;
      await getError();
      controller.refreshCompleted();
    } catch (e) {
      controller.refreshFailed();
    }
  }

  Future getError() async {
    NetworkState state = await getIt.get<AppRepository>().getErrorMachine();
    if (total != null && error.length == total) {
      setState(() {
        isLoading = false;
      });
      return [];
    }
    if (state.isSuccess && state.data != null) {
      if (total == 0) {
        error.clear();
      }
      error.addAll(state.data);
      total = state.total ?? 0;
      setState(() {
        isLoading = false;
      });
      controller.loadComplete();
      print("nè nè $total");
    } else {
      controller.loadFailed();
    }
  }

  void onPressedItem(ErrorMachineEntity error, bool isMultiPick) {
    if (!isMultiPick) {
      if (_selectedError.isEmpty) {
        _selectedError.add(error);
      } else {
        _selectedError.first = error;
      }
      setState(() {});
      return;
    }
    if (selectedLabelIds.contains(error.sId)) {
      final result = selectedLabelIds.indexWhere((labelId) => error.sId == labelId);
      if (result != EndPoint.NO_ELEMENT) {
        _selectedError.removeAt(result);
      }
    } else {
      _selectedError.add(error);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WidgetHeaderBottomSheet(title: 'error'.tr),
        Expanded(child: _buildBody()),
        WidgetButton(
          title: "Áp dụng",
          typeButton: TypeButton.none,
          enabled: _selectedError.isNotEmpty,
          onPressed: () {
            Get.back();
            widget.onUpdateError?.call(_selectedError);
          },

          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        )
      ],
    );
  }

  Widget _buildBody() {
    return WidgetLoadMoreRefresh(
      controller: controller,
      onLoadMore: getError,
      onRefresh: onRefresh,
      child: isLoading
          ? const WidgetLoading()
          : SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: ListView.separated(
                    itemCount: error.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return WidgetItemSelect(
                        isMultiPick: true,
                        state: error[index].maintenanceContent ?? "",
                        onPressed: () {
                          onPressedItem(error[index], true);
                        },
                        currentState: (selectedLabelIds.contains(error[index].sId)),
                      );
                    },
                    separatorBuilder: (_, index) => const Divider(
                          height: 1,
                          color: AppColor.primary,
                        )),
              ),
            ),
    );
  }
}
