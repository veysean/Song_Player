import '../../../../model/artists/artist.dart';
import '../../../../model/songs/song.dart';

class SongWithArtist {
  final Song song;
  final Artist artist;

  SongWithArtist({required this.song, required this.artist});
}
