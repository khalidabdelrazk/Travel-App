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

import '../../presentation/authentication/Data/Data%20Sources/remote/auth_remote_data_source.dart'
    as _i293;
import '../../presentation/authentication/Data/Data%20Sources/remote/impl/auth_remote_data_source_impl.dart'
    as _i1054;
import '../../presentation/authentication/Data/Repository/auth_repository_impl.dart'
    as _i659;
import '../../presentation/authentication/Domain/Repository/auth_repository.dart'
    as _i471;
import '../../presentation/authentication/Domain/Use%20Case/auth_use_case.dart'
    as _i105;
import '../../presentation/authentication/ui/cubit/authentication/auth_view_model.dart'
    as _i212;
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
import '../../presentation/explore%20details/data/Data%20Sources/impl/trip_details_remote_data_source_impl.dart'
    as _i799;
import '../../presentation/explore%20details/data/Data%20Sources/trip_details_remote_data_source.dart'
    as _i720;
import '../../presentation/explore%20details/data/Repository/trip_details_repository_impl.dart'
    as _i929;
import '../../presentation/explore%20details/domain/Repository/trip_details_repository.dart'
    as _i91;
import '../../presentation/explore%20details/domain/Use%20Case/trip_details_use_case.dart'
    as _i536;
import '../../presentation/explore%20details/ui/cubit/trip_details_view_model.dart'
    as _i719;
import '../../presentation/home/data/Data%20Sources/trips/home_trips_remote_data_source.dart'
    as _i569;
import '../../presentation/home/data/Data%20Sources/trips/impl/home_trips_remote_data_source_impl.dart'
    as _i863;
import '../../presentation/home/data/Repository/home_trips_repository_impl.dart'
    as _i1011;
import '../../presentation/home/domain/Repository/home_repository.dart'
    as _i583;
import '../../presentation/home/domain/Use%20Case/home_trips_use_case.dart'
    as _i241;
import '../../presentation/home/ui/cubit/home_view_model.dart' as _i46;
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
    gh.factory<_i720.TripDetailsRemoteDataSource>(
      () => _i799.TripDetailsRemoteDataSourceImpl(
        apiManager: gh<_i949.ApiManager>(),
      ),
    );
    gh.factory<_i293.AuthRemoteDataSource>(
      () => _i1054.AuthRemoteDataSourceImpl(apiManager: gh<_i949.ApiManager>()),
    );
    gh.factory<_i623.ChatbotDataSource>(
      () => _i336.ChatbotDataSourceImpl(apiManager: gh<_i949.ApiManager>()),
    );
    gh.factory<_i765.ChatbotRepository>(
      () => _i62.ChatbotRepositoryImpl(gh<_i623.ChatbotDataSource>()),
    );
    gh.factory<_i569.HomeTripsRemoteDataSource>(
      () => _i863.HomeTripsRemoteDataSourceImpl(
        apiManager: gh<_i949.ApiManager>(),
      ),
    );
    gh.factory<_i694.HotelsRemoteDataSource>(
      () =>
          _i634.HotelsRemoteDataSourceImpl(apiManager: gh<_i949.ApiManager>()),
    );
    gh.factory<_i583.HomeTripsRepository>(
      () =>
          _i1011.HomeTripsRepositoryImpl(gh<_i569.HomeTripsRemoteDataSource>()),
    );
    gh.factory<_i241.HomeTripsUseCase>(
      () => _i241.HomeTripsUseCase(
        homeTripsRepository: gh<_i583.HomeTripsRepository>(),
      ),
    );
    gh.factory<_i91.TripDetailsRepository>(
      () => _i929.TripDetailsRepositoryImpl(
        gh<_i720.TripDetailsRemoteDataSource>(),
      ),
    );
    gh.factory<_i536.TripDetailsUseCase>(
      () => _i536.TripDetailsUseCase(
        tripDetailsRepository: gh<_i91.TripDetailsRepository>(),
      ),
    );
    gh.factory<_i1012.ExploreRepository>(
      () => _i1011.ExploreRepositoryImpl(
        gh<_i694.HotelsRemoteDataSource>(),
        gh<_i682.TripsRemoteDataSource>(),
      ),
    );
    gh.factory<_i471.AuthRepository>(
      () => _i659.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i293.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i46.HomeViewModel>(
      () => _i46.HomeViewModel(homeTripsUseCase: gh<_i241.HomeTripsUseCase>()),
    );
    gh.factory<_i959.ChatbotUseCases>(
      () => _i959.ChatbotUseCases(
        chatbotRepository: gh<_i765.ChatbotRepository>(),
      ),
    );
    gh.factory<_i719.TripDetailsViewModel>(
      () => _i719.TripDetailsViewModel(
        tripDetailsUseCase: gh<_i536.TripDetailsUseCase>(),
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
    gh.factory<_i105.AuthUseCase>(
      () => _i105.AuthUseCase(authRepository: gh<_i471.AuthRepository>()),
    );
    gh.factory<_i821.ExploreViewModel>(
      () => _i821.ExploreViewModel(
        hotelsUseCase: gh<_i514.HotelsUseCase>(),
        tripsUseCase: gh<_i940.TripsUseCase>(),
      ),
    );
    gh.factory<_i212.AuthViewModel>(
      () => _i212.AuthViewModel(authUseCase: gh<_i105.AuthUseCase>()),
    );
    return this;
  }
}
