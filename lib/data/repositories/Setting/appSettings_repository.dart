import 'package:practice/model/settings/app_settings.dart';

abstract class AppsettingsRepository {
  Future<AppSettings> load();
  Future<void> save(AppSettings settings);
}
