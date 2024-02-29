import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isInternetConnected;
}

class NetworkInfoImp implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;
  NetworkInfoImp({required this.internetConnectionChecker});
  @override
  Future<bool> get isInternetConnected async => await internetConnectionChecker.hasConnection;
}
