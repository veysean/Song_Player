import 'package:flutter/material.dart';

import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  LibraryViewModel({required this.songRepository, required this.playerState});

  List<Song> _songs = [];
  List<Song> get songs => _songs;

  Song? get currentSong => playerState.currentSong;

  void init() {
    _songs = songRepository.fetchSongs();
    // Listen to player state changes
    playerState.addListener(() {
      notifyListeners();
    });
  }

  void play(Song song) {
    playerState.start(song);
    notifyListeners();
  }

  void stop() {
    playerState.stop();
    notifyListeners();
  }
}
