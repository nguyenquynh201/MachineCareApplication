import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/model.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/utils/utils.dart';
import 'repository.dart';

class AppRepository {
  final AuthRepository authRepository;
  final ProductRepository productRepository;
  final MaintenanceScheduleRepository maintenanceScheduleRepository;

  AppRepository({
    required this.authRepository,
    required this.productRepository,
    required this.maintenanceScheduleRepository,
  });

  Future<NetworkState<AuthEntity>> login(String phone, String password) async {
    return await authRepository.login(phone, password);
  }

  Future<NetworkState<UserEntity>> getMyProfile() async {
    return await authRepository.getMyProfile();
  }

  Future<NetworkState<List<BannerEntity>>> getBanner() async {
    return await authRepository.getBanner();
  }

  Future<NetworkState<dynamic>> getProduct() async {
    return await productRepository.getProduct();
  }

  Future<NetworkState<List<MaintenanceScheduleEntity>>> getMaintenanceSchedule() async {
    return await maintenanceScheduleRepository.getMaintenanceSchedule();
  }

  Future<NetworkState<List<ErrorMachineEntity>>> getErrorMachine() async {
    return await maintenanceScheduleRepository.getErrorMachine();
  }

  Future<NetworkState<List<StatusEntity>>> getStatus() async {
    return await maintenanceScheduleRepository.getStatus();
  }

  Future<NetworkState<MaintenanceScheduleEntity>> createRepair(
      {required MaintenanceScheduleEntity entity}) async {
    return await maintenanceScheduleRepository.createRepair(entity: entity);
  }

  Future<NetworkState<List<ProvinceEntity>>> getProvince(
      {String search = EndPoint.EMPTY_STRING}) async {
    return await maintenanceScheduleRepository.getProvince(search: search);
  }

  Future<NetworkState<List<DistrictEntity>>> getDistrict(
      {required String idProvince, String search = EndPoint.EMPTY_STRING}) async {
    return await maintenanceScheduleRepository.getDistrict(idProvince: idProvince, search: search);
  }

  Future<NetworkState<UserAddress>> addAddress({required UserAddress entity}) async {
    return await maintenanceScheduleRepository.createAddress(entity: entity);
  } Future<NetworkState<List<UserAddress>>> getAddress() async {
    return await maintenanceScheduleRepository.getAddress();
  }

  Future<bool> isUserLoggedIn() async {
    try {
      if (AppPref.token.accessToken == null || AppPref.token.accessToken!.isEmpty) return false;

      /// get new token
      final state = await authRepository.refreshToken(
        accessToken: AppPref.token.accessToken!,
        refreshToken: AppPref.token.refreshToken!,
      );
      if (state.isSuccess && state.data != null) {
        AppPref.token = state.data;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
