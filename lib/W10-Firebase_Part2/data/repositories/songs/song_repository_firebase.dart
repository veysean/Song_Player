import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https(
    'fir-b72ad-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/songs.json',
  );

  List<Song>? _cachedSongs;

  @override
  Future<List<Song>> fetchSongs({bool forceFetch = false}) async {
    if (!forceFetch && _cachedSongs != null) {
      return _cachedSongs!;
    }

    final response = await http.get(songsUri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> songJson = json.decode(response.body);
      final result = songJson.entries
          .map((entry) => SongDto.fromJson(entry.key, entry.value))
          .toList();

      _cachedSongs = result;
      return result;
    } else {
      throw Exception('Failed to load songs');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}

  @override
  Future<void> likeSong(String songId, int currentLikes) async {
    final Uri songURL = Uri.https(
      'fir-b72ad-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/songs/$songId.json',
    );

    final response = await http.patch(
      songURL,
      body: json.encode({"likes": currentLikes + 1}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to like song $songId");
    }

    if (_cachedSongs != null) {
      final index = _cachedSongs!.indexWhere((s) => s.id == songId);
      if (index != -1) {
        final song = _cachedSongs![index];
        _cachedSongs![index] = Song(
          id: song.id,
          title: song.title,
          artistId: song.artistId,
          duration: song.duration,
          imageUrl: song.imageUrl,
          likes: song.likes + 1,
        );
      }
    }
  }
}
