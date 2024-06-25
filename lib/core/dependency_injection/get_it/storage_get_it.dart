import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/dependency_injection/get_it_feature_interface.dart';

class StorageGetIt extends GetItFeature {

  @override
  void featureInit() {
    getIt.registerLazySingleton(() => GetStorage());
    getIt.registerLazySingleton(() => const FlutterSecureStorage());
  }
}
