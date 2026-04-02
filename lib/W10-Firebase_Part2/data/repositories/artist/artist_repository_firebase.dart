import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/artist/artist.dart';
import '../../../model/comment/comment.dart';
import '../../../model/songs/song.dart';
import '../../dtos/artist_dto.dart';
import '../../dtos/song_dto.dart';
import '../../dtos/comment_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase implements ArtistRepository {
  final String baseUrl =
      'fir-b72ad-default-rtdb.asia-southeast1.firebasedatabase.app';

  List<Artist>? _cachedArtists;

  Uri _buildUri(String path) => Uri.https(baseUrl, path);

  @override
  Future<List<Artist>> fetchArtists({bool forceFetch = false}) async {
    if (!forceFetch && _cachedArtists != null) {
      return _cachedArtists!;
    }

    final response = await http.get(_buildUri('/artists.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> artistJson = json.decode(response.body);
      final result = artistJson.entries
          .map((entry) => ArtistDto.fromJson(entry.key, entry.value))
          .toList();

      _cachedArtists = result;
      return result;
    } else {
      throw Exception('Failed to load artists');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    final response = await http.get(_buildUri('/artists/$id.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic>? artistJson = json.decode(response.body);
      if (artistJson == null) return null;
      return ArtistDto.fromJson(id, artistJson);
    } else {
      throw Exception('Failed to load artist $id');
    }
  }

  @override
  Future<List<Song>> fetchArtistSongs(String artistId) async {
    final response = await http.get(_buildUri('/songs.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> songsJson = json.decode(response.body);
      return songsJson.entries
          .where((entry) => entry.value['artistId'] == artistId)
          .map((entry) => SongDto.fromJson(entry.key, entry.value))
          .toList();
    } else {
      throw Exception('Failed to load songs for artist $artistId');
    }
  }

  @override
  Future<List<Comment>> fetchArtistComments(String artistId) async {
    final response = await http.get(_buildUri('/comments.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> commentsJson = json.decode(response.body);
      return commentsJson.entries
          .where((entry) => entry.value['artistId'] == artistId)
          .map((entry) => CommentDto.fromJson(entry.key, entry.value))
          .toList();
    } else {
      throw Exception('Failed to load comments for artist $artistId');
    }
  }

  @override
  Future<void> postComment(String artistId, String text) async {
    final newComment = Comment(
      id: '',
      artistId: artistId,
      text: text,
    );

    final response = await http.post(
      _buildUri('/comments.json'),
      body: json.encode(CommentDto().toJson(newComment)),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to post comment');
    }
  }
}
