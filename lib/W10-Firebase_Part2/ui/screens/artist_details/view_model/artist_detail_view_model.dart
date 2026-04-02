import 'package:flutter/material.dart';
import '../../../../data/repositories/artist/artist_repository.dart';
import '../../../../model/artist/artist.dart';
import '../../../../model/songs/song.dart';
import '../../../../model/comment/comment.dart';
import '../../../utils/async_value.dart';

class ArtistDetailViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;

  AsyncValue<Artist?> artistValue = AsyncValue.loading();
  AsyncValue<List<Song>> songsValue = AsyncValue.loading();
  AsyncValue<List<Comment>> commentsValue = AsyncValue.loading();

  ArtistDetailViewModel({required this.artistRepository});

  Future<void> fetchArtist(String artistId) async {
    artistValue = AsyncValue.loading();
    notifyListeners();

    try {
      final artist = await artistRepository.fetchArtistById(artistId);
      artistValue = AsyncValue.success(artist);
    } catch (e) {
      artistValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  /// Fetch songs for this artist
  Future<void> fetchSongs(String artistId) async {
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      final songs = await artistRepository.fetchArtistSongs(artistId);
      songsValue = AsyncValue.success(songs);
    } catch (e) {
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  /// Fetch comments for this artist
  Future<void> fetchComments(String artistId) async {
    commentsValue = AsyncValue.loading();
    notifyListeners();

    try {
      final comments = await artistRepository.fetchArtistComments(artistId);
      commentsValue = AsyncValue.success(comments);
    } catch (e) {
      commentsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  /// Post a new comment
  Future<void> postComment(String artistId, String text) async {
    try {
      await artistRepository.postComment(artistId, text);
      await fetchComments(artistId);
    } catch (e) {
      commentsValue = AsyncValue.error(e);
      notifyListeners();
    }
  }
}
