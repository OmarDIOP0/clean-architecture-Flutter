import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  final InternetConnectionChecker connexionChecker;
  NetworkInfoImpl(this.connexionChecker);

  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => connexionChecker.hasConnection;
}

