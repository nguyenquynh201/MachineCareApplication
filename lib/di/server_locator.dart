import 'package:get_it/get_it.dart';
import 'package:machine_care/resources/path/path.dart';
import 'package:machine_care/resources/provider/app_client.dart';
import 'package:machine_care/resources/repository/app_repository.dart';
import 'package:machine_care/resources/repository/repository.dart';

GetIt getIt = GetIt.instance;
Future<void> setupLocator() async {
  final AppClients appClients = AppClients(baseUrl: PathMachine.baseUrl);
  final path = PathMachine();
  getIt.registerLazySingleton(() {
    return AppRepository(
      authRepository: AuthRepository(appClients, path),
      productRepository: ProductRepository(appClients , path),
      maintenanceScheduleRepository: MaintenanceScheduleRepository(appClients , path),
      notificationRepository: NotificationRepository(appClients , path)
    );
  });


}
