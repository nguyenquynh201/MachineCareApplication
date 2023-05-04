import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/resources/repository/app_repository.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BottomSheetAddress extends StatefulWidget {
  const BottomSheetAddress({Key? key, this.selectedAddress, this.onUpdateAddress})
      : super(key: key);

  final UserAddress? selectedAddress;
  final Function(UserAddress)? onUpdateAddress;

  @override
  State<BottomSheetAddress> createState() => _BottomSheetAddressState();
}

class _BottomSheetAddressState extends State<BottomSheetAddress> {
  late RefreshController controller;
  List<UserAddress> address = [];
  late UserAddress? _selectedAddress;

  int? total;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedAddress = widget.selectedAddress;
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
    NetworkState state = await getIt.get<AppRepository>().getAddress();
    if (total != null && address.length == total) {
      setState(() {
        isLoading = false;
      });
      return [];
    }
    if (state.isSuccess && state.data != null) {
      if (total == 0) {
        address.clear();
      }
      address.addAll(state.data);
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

  void onPressedItem(UserAddress address, bool isMultiPick) {
    if (!isMultiPick) {
      if (_selectedAddress != null) {
        _selectedAddress = address;
      }
      setState(() {});
      return;
    }
    if (!(_selectedAddress?.id?.contains(address.id!) ?? false)) {
      _selectedAddress = address;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WidgetHeaderBottomSheet(title: 'list_address'.tr),
        Expanded(child: _buildBody()),
        WidgetButton(
          title: "Áp dụng",
          typeButton: TypeButton.none,
          enabled: _selectedAddress != null,
          onPressed: () {
            Get.back();
            if (_selectedAddress != null) {
              widget.onUpdateAddress?.call(_selectedAddress!);
            }
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
                    itemCount: address.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return WidgetItemSelect(
                        isMultiPick: true,
                        state:
                            "${address[index].addressUser} - ${address[index].addressDistrict} - ${address[index].addressProvince}",
                        onPressed: () {
                          onPressedItem(address[index], true);
                        },
                        currentState: (_selectedAddress?.id?.contains(address[index].id!) ?? false),
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
