import 'package:get_it/get_it.dart';
import 'package:mse_customer/services/api.dart';
import 'package:mse_customer/services/auth_service.dart';
import 'package:mse_customer/services/request_service.dart';
import 'package:mse_customer/services/user_service.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => RequestService());
  //var instance = await LocalStorageService.getInstance();
  //locator.registerSingleton<LocalStorageService>(instance);
}
