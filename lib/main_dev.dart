import 'package:practice/data/repositories/Setting/appSetting_repository_mock.dart';
// import 'package:practice/data/repositories/Setting/appSettings_repository.dart';
import 'package:provider/provider.dart';
import 'package:nested/nested.dart';

import 'main_common.dart';
import 'data/repositories/songs/song_repository.dart';
import 'data/repositories/songs/song_repository_mock.dart';
import 'ui/states/player_state.dart';
import 'ui/states/settings_state.dart';

/// Configure provider dependencies for dev environment
List<SingleChildWidget> get devProviders {
  return [
    // 1 - Inject the song repository
    Provider<SongRepository>(create: (_) => SongRepositoryMock()),

    // 2 - Inject the player state
    ChangeNotifierProvider<PlayerState>(create: (_) => PlayerState()),
    
    // 4 - Inject App Settings Repository
    Provider<AppSettingsRepositoryMock>(create: (_)=>AppSettingsRepositoryMock()),

    // 3 - Inject the  app setting state
    ChangeNotifierProvider<AppSettingsState>(create: (context) => AppSettingsState(context.read<AppSettingsRepositoryMock>())),

  ];
}

void main() {
  mainCommon(devProviders);
}
