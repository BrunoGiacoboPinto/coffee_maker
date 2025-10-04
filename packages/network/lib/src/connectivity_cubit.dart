import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:network/src/internet_prober.dart';

enum ConnectivityStatus {
  online,
  offline,
  noNetwork,
}

@injectable
class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  ConnectivityCubit(this._internetProber) : super(ConnectivityStatus.online);

  final InternetProber _internetProber;
  late final Logger _logger = Logger('ConnectivityCubit');
  final Connectivity _connectivity = Connectivity();

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _recheckTimer;

  Future<void> initialize() async {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivityChanged,
      onError: (Object error) {
        _logger.severe('Connectivity stream error: $error');
        emit(ConnectivityStatus.noNetwork);
      },
    );

    await _checkConnectivity();
  }

  Future<void> _onConnectivityChanged(List<ConnectivityResult> results) async {
    _logger.info('Connectivity changed: $results');
    await _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();

      if (results.isEmpty ||
          results.every((result) => result == ConnectivityResult.none)) {
        _stopRecheckTimer();
        emit(ConnectivityStatus.noNetwork);
        return;
      }

      final hasInternet = await _internetProber.checkOnline();

      if (hasInternet) {
        _stopRecheckTimer();
        emit(ConnectivityStatus.online);
      } else {
        emit(ConnectivityStatus.offline);
        _startRecheckTimer();
      }
    } on Exception catch (error, stackTrace) {
      _logger.severe('Error checking connectivity: $error', error, stackTrace);
      emit(ConnectivityStatus.noNetwork);
    }
  }

  void _startRecheckTimer() {
    _stopRecheckTimer();
    _recheckTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _checkConnectivity(),
    );
  }

  void _stopRecheckTimer() {
    _recheckTimer?.cancel();
    _recheckTimer = null;
  }

  Future<void> checkConnectivity() async {
    await _checkConnectivity();
  }

  @override
  Future<void> close() async {
    await _connectivitySubscription?.cancel();
    _stopRecheckTimer();
    return super.close();
  }
}
