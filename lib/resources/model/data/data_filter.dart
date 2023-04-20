import '../../../ui/ui.dart';

class DataFilter {
  static reset() {
    return banners.clear();
  }
  static RxList banners = [].obs;
  static RxList<StatusEntity> status = <StatusEntity>[].obs;
}
