import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/resources/model/model.dart';
import 'package:machine_care/resources/network_state.dart';
import 'package:machine_care/utils/utils.dart';
import '../../ui/ui.dart';
import 'repository.dart';

class AppRepository {
  final AuthRepository authRepository;
  final ProductRepository productRepository;
  final MaintenanceScheduleRepository maintenanceScheduleRepository;
  final NotificationRepository notificationRepository;
  AppRepository( {
    required this.authRepository,
    required this.productRepository,
    required this.maintenanceScheduleRepository,
    required this.notificationRepository,
  });

  Future<NetworkState<AuthEntity>> login(String phone, String password) async {
    return await authRepository.login(phone, password);
  }

  Future<NetworkState<UserEntity>> getMyProfile() async {
    return await authRepository.getMyProfile();
  }

  Future<NetworkState<dynamic>> resetPassword(
      {required String id, required String currentPassword, required String newPassword}) async {
    return await authRepository.resetPassword(
        id: id, currentPassword: currentPassword, newPassword: newPassword);
  }

  Future<NetworkState<List<BannerEntity>>> getBanner() async {
    return await authRepository.getBanner();
  }

  Future<NetworkState<dynamic>> getProduct() async {
    return await productRepository.getProduct();
  }

  Future<NetworkState<List<MaintenanceScheduleEntity>>> getMaintenanceSchedule({
    required int offset,
    required int limit,
    DateTime? from,
    DateTime? to,
  }) async {
    return await maintenanceScheduleRepository.getMaintenanceSchedule(
      offset: offset,
      limit: limit,
      from: DateTimeUtils.getCurrentDate(from),
      to: DateTimeUtils.getCurrentDate(to),
    );
  }

  Future<NetworkState<MaintenanceScheduleEntity>> getMaintenanceScheduleById(
      {required String id}) async {
    return await maintenanceScheduleRepository.getMaintenanceScheduleById(id: id);
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
  Future<NetworkState<MaintenanceScheduleEntity>> updateRepair(
      {required String id,required MaintenanceScheduleEntity entity}) async {
    return await maintenanceScheduleRepository.updateRepair( id: id,entity: entity);
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
  }
  Future<NetworkState<RatingEntity>> updateRating({required RatingEntity entity}) async {
    return await maintenanceScheduleRepository.updateRating(entity: entity);
  }

  Future<NetworkState<List<UserAddress>>> getAddress() async {
    return await maintenanceScheduleRepository.getAddress();
  }

  Future<NetworkState<dynamic>> updateToken({required String token}) async {
    return await authRepository.updateToken(token: token);
  }
  Future<NetworkState<List<HistoryRepairEntity>>> getHistory({required String id}) async {
    return await maintenanceScheduleRepository.getHistory(id: id);
  }

  Future<NetworkState<List<NotificationEntity>>> getNotification({
    required int offset,
    required int limit
  }) async {
    return await notificationRepository.getNotification(
      offset: offset,
      limit: limit,
    );
  }
  Future<NetworkState<NotificationEntity>> getNotificationById({required String id}) async {
    return await notificationRepository.getNotificationById(id: id);
  }

  Future<NetworkState<dynamic>> readNotification({required String id}) async {
    return notificationRepository.readNotification(id: id);
  }
  Future<NetworkState<dynamic>> updateRequestReceived({required String id , required String idAdmin , required Map<String , dynamic> data}) async {
    return notificationRepository.updateRequestReceived(id: id, idAdmin: idAdmin, data: data);
  }
  Future<NetworkState<dynamic>> uploadImage({required String idUser, required File file}) async {
    return authRepository.uploadImage(idUser: idUser, file: file);
  }

  Future<NetworkState<UserEntity>> updateInfo({required String id , required UserEntity entity}) async {
    return authRepository.updateInfo(id: id, entity: entity);
  }
  Future<NetworkState<List<CommentEntity>>> getComment({required String id}) async {
    return maintenanceScheduleRepository.getComment(id: id);
  }

  Future<NetworkState<dynamic>> updateStatus(
      {required StatusEnum status, required String id}) async {
    return maintenanceScheduleRepository.updateStatus(status: status, id: id);
  }
  Future<NetworkState<CommentEntity>> addComment(
      {required CommentEntity entity}) async {
    return maintenanceScheduleRepository.addComment(entity: entity);
  }
  Future<NetworkState<dynamic>> updateBug(
      {required List<BugEntity> entity , required String id}) async {
    return maintenanceScheduleRepository.updateBug(entity: entity , id: id);
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
