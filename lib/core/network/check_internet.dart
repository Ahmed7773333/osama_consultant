import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  // Singleton pattern
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivity.onConnectivityChanged;

  Future<List<ConnectivityResult>> checkConnectivity() {
    return _connectivity.checkConnectivity();
  }

  Future<bool> getConnectionStatus() async {
    List<ConnectivityResult> result = await checkConnectivity();
    return (result.first == ConnectivityResult.mobile ||
        result.first == ConnectivityResult.wifi ||
        result.first == ConnectivityResult.other);
  }
}
