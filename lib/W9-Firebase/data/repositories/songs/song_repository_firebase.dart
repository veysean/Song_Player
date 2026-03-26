import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  static final baseURL = Uri.http(
    'fir-b72ad-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  static final Uri songsURL = baseURL.replace(path: '/songs.json');
  static final Uri artistsURL = baseURL.replace(path: '/artists.json');

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsURL);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);
      List<Song> result = [];

      for (var iteration in songJson.entries) {
        result.add(SongDto.fromJson(iteration.key, iteration.value));
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
