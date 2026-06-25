import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

final class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl({required this.connectivity});

  final Connectivity connectivity;

  @override
  Future<bool> get isConnected async {
    final results = await connectivity.checkConnectivity();

    return results.any((result) => result != ConnectivityResult.none);
  }
}
