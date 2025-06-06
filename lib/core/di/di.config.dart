// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../presentation/chatbot/data/data%20source/server/chatbot_data_source.dart'
    as _i623;
import '../../presentation/chatbot/data/data%20source/server/impl/chatbot_data_source_impl.dart'
    as _i336;
import '../../presentation/chatbot/data/repository/chatbot_repository_impl.dart'
    as _i62;
import '../../presentation/chatbot/domain/repository/chatbot_repository.dart'
    as _i765;
import '../../presentation/chatbot/domain/use%20cases/chatbot_use_cases.dart'
    as _i959;
import '../../presentation/chatbot/ui/cubit/chatbot_view_model.dart' as _i1069;
import '../../presentation/trips/data/Data%20Sources/hotels/hotels_remote_data_source.dart'
    as _i694;
import '../../presentation/trips/data/Data%20Sources/hotels/impl/hotels_remote_data_source_impl.dart'
    as _i634;
import '../../presentation/trips/data/Data%20Sources/trips/impl/trips_remote_data_source_impl.dart'
    as _i265;
import '../../presentation/trips/data/Data%20Sources/trips/trips_remote_data_source.dart'
    as _i682;
import '../../presentation/trips/data/Repository/explore_repository_impl.dart'
    as _i1011;
import '../../presentation/trips/domain/Repository/explore_repository.dart'
    as _i1012;
import '../../presentation/trips/domain/Use%20Case/hotels_use_case.dart'
    as _i514;
import '../../presentation/trips/domain/Use%20Case/trips_use_case.dart'
    as _i940;
import '../../presentation/trips/ui/cubit/explore_view_model.dart' as _i821;
import '../api%20manager/api_manager.dart' as _i949;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i949.ApiManager>(() => _i949.ApiManager());
    gh.factory<_i682.TripsRemoteDataSource>(
      () => _i265.TripsRemoteDataSourceImpl(apiManager: gh<_i949.ApiManager>()),
    );
    gh.factory<_i623.ChatbotDataSource>(
      () => _i336.ChatbotDataSourceImpl(apiManager: gh<_i949.ApiManager>()),
    );
    gh.factory<_i765.ChatbotRepository>(
      () => _i62.ChatbotRepositoryImpl(gh<_i623.ChatbotDataSource>()),
    );
    gh.factory<_i694.HotelsRemoteDataSource>(
      () =>
          _i634.HotelsRemoteDataSourceImpl(apiManager: gh<_i949.ApiManager>()),
    );
    gh.factory<_i1012.ExploreRepository>(
      () => _i1011.ExploreRepositoryImpl(
        gh<_i694.HotelsRemoteDataSource>(),
        gh<_i682.TripsRemoteDataSource>(),
      ),
    );
    gh.factory<_i959.ChatbotUseCases>(
      () => _i959.ChatbotUseCases(
        chatbotRepository: gh<_i765.ChatbotRepository>(),
      ),
    );
    gh.factory<_i940.TripsUseCase>(
      () =>
          _i940.TripsUseCase(exploreRepository: gh<_i1012.ExploreRepository>()),
    );
    gh.factory<_i514.HotelsUseCase>(
      () => _i514.HotelsUseCase(
        exploreRepository: gh<_i1012.ExploreRepository>(),
      ),
    );
    gh.factory<_i1069.ChatBotViewModel>(
      () =>
          _i1069.ChatBotViewModel(chatbotUseCases: gh<_i959.ChatbotUseCases>()),
    );
    gh.factory<_i821.ExploreViewModel>(
      () => _i821.ExploreViewModel(
        hotelsUseCase: gh<_i514.HotelsUseCase>(),
        tripsUseCase: gh<_i940.TripsUseCase>(),
      ),
    );
    return this;
  }
}
