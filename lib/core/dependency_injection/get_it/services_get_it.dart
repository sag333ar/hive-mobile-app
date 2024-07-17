import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/dependency_injection/get_it_feature_interface.dart';
import 'package:hive_mobile_app/core/services/data_service/api_service.dart';
import 'package:hive_mobile_app/core/services/local_service.dart';

class ServicesGetIt extends GetItFeature{

  @override
  void featureInit() {
    getIt.registerLazySingleton<ApiService>(() => ApiService());
    getIt.registerLazySingleton<LocalService>(() => LocalService(storage: getIt.call()));
  }
}