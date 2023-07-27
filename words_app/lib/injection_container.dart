import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Cubit
  // Use cases
  // Repository
  // Data sources
  // Network Info
  getIt.registerFactory(() => Client());
}
