import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';
import 'package:network/src/cubit/internet_prober.dart';

/// Represents the different states of device connectivity.
/// Used to track both network availability and internet access.
enum ConnectivityStatus {
  /// Device has network connectivity and can access the internet.
  online,

  /// Device has network connectivity but cannot access the internet.
  offline,

  /// Device has no network connectivity at all.
  noNetwork,
}

/// A Cubit that manages and monitors device connectivity status.
/// Tracks both network availability and actual internet access.
class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  /// Creates a [ConnectivityCubit] with the given [InternetProber] and
  /// optional [Connectivity].
  ConnectivityCubit(this._internetProber, [Connectivity? connectivity])
    : _connectivity = connectivity ?? Connectivity(),
      super(ConnectivityStatus.online);

  final InternetProber _internetProber;
  late final Logger _logger = Logger('ConnectivityCubit');
  final Connectivity _connectivity;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _recheckTimer;

  /// Initializes the connectivity monitoring by setting up listeners
  /// and performing an initial connectivity check.
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

  /// Manually triggers a connectivity check.
  /// This can be called to force a re-evaluation of the current
  /// connectivity status.
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
