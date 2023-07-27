import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  late ConnectivityResult connectivityResult;

  NetworkInfoImpl();

  @override
  Future<bool> get isConnected async =>
      await (Connectivity().checkConnectivity()) != ConnectivityResult.none;
}
