// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coffee_maker/core/network/api_client.dart' as _i956;
import 'package:coffee_maker/core/network/http_client_provider.dart' as _i502;
import 'package:coffee_maker/network/cubit/connectivity_cubit.dart' as _i433;
import 'package:coffee_maker/network/cubit/internet_prober.dart' as _i888;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i502.HttpClientProvider>(
      () => _i502.HttpClientProvider(),
    );
    gh.lazySingleton<_i956.ApiClient>(() => _i956.ApiClient());
    gh.lazySingleton<_i888.InternetProber>(
      () => _i888.InternetProber(gh<_i502.HttpClientProvider>()),
    );
    gh.factory<_i433.ConnectivityCubit>(
      () => _i433.ConnectivityCubit(gh<_i888.InternetProber>()),
    );
    return this;
  }
}
