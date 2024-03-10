import 'package:get_it/get_it.dart';
import '/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_services.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ApiService(Constants.baseurl));
  locator.registerSingletonAsync(() => SharedPreferences.getInstance());
}
