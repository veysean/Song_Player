import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase extends ArtistRepository {
  static final baseURL = Uri.http(
    'fir-b72ad-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  static final Uri artistsURL = baseURL.replace(path: '/artists.json');

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsURL);

    if (response.statusCode == 200) {
      Map<String, dynamic> artistJson = json.decode(response.body);
      List<Artist> result = [];

      for (var iteration in artistJson.entries) {
        result.add(ArtistDto.fromJson(iteration.key, iteration.value));
      }
      return result;
    } else {
      throw Exception('Failed to load artists');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    final Uri artistURL = baseURL.replace(path: '/artists/$id.json');
    final http.Response response = await http.get(artistURL);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? jsonData = json.decode(response.body);
      if (jsonData != null) {
        return ArtistDto.fromJson(id, jsonData);
      }
      return null;
    } else {
      throw Exception('Failed to load artist with id $id');
    }
  }
}