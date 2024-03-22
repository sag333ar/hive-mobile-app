import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/dependency_injection/get_it_feature_interface.dart';
import 'package:hive_mobile_app/feature/feeds/repository/feeds_repository.dart';

class RepositoriesGetIt extends GetItFeature {
  @override
  void featureInit() {
    getIt.registerFactory<FeedsRepository>(
        () => FeedsRepository(apiService: getIt.call()));
  }
}
