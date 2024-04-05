import 'package:hive_mobile_app/core/dependency_injection/dependency_injection.dart';
import 'package:hive_mobile_app/core/dependency_injection/get_it_feature_interface.dart';
import 'package:hive_mobile_app/feature/community/repository/community_repository.dart';
import 'package:hive_mobile_app/feature/governance/repository/governance_repository.dart';
import 'package:hive_mobile_app/feature/post/repository/post_repository.dart';

class RepositoriesGetIt extends GetItFeature {
  @override
  void featureInit() {
    getIt.registerFactory<PostRepository>(
        () => PostRepository(apiService: getIt.call()));
    getIt.registerFactory<CommunityRepository>(
        () => CommunityRepository(apiService: getIt.call()));
    getIt.registerFactory<GovernanceRepository>(
        () => GovernanceRepository(apiService: getIt.call()));
  }
}
