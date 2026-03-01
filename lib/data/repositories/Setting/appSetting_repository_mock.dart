import 'package:practice/model/settings/app_settings.dart';

import 'appSettings_repository.dart';

class AppSettingsRepositoryMock implements AppsettingsRepository {
  AppSettings _settings;

  AppSettingsRepositoryMock({ThemeColor initialColor = ThemeColor.blue})
      : _settings = AppSettings(themeColor: initialColor);

  @override
  Future<AppSettings> load() async {
    return _settings;
  }

  @override
  Future<void> save(AppSettings settings) async {
    _settings = settings;
  }
}
