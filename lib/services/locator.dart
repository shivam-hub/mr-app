import 'package:get_it/get_it.dart';
import 'package:nurene_app/utils/const.dart';
import '../services/api_services.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ApiService(Constants.baseurl));
}
