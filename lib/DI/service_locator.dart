import 'package:get_it/get_it.dart';
import 'package:retrofit_example/network/dio_client.dart';
import 'package:retrofit_example/network/rest_client.dart';

final getIt = GetIt.instance;

void setUp() {
  final dio = DioClient().instance();
  getIt.registerLazySingleton<RestClient>(() => RestClient(dio));
}
