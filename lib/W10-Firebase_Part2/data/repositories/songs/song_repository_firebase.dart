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

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> songJson = json.decode(response.body);
      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
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
  }
}
