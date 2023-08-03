// ignore_for_file: file_names

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
class NetworkConnectivity {
  static final NetworkConnectivity _singleton = NetworkConnectivity._internal();
  factory NetworkConnectivity() => _singleton;

  NetworkConnectivity._internal() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityStreamController.add(result);
    });
  }

  final Connectivity _connectivity = Connectivity();
  final StreamController<ConnectivityResult> _connectivityStreamController =
      StreamController<ConnectivityResult>.broadcast();

  Stream<ConnectivityResult> get myStream =>
      _connectivityStreamController.stream;

  Future<bool> checkConnectivity() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Future<void> initialise() async {
    await _connectivity.checkConnectivity();
  }

  void dispose() {
    _connectivityStreamController.close();
  }
}
