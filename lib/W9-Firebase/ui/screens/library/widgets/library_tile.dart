import 'package:flutter/material.dart';
import '../view_model/song_with_artist.dart';

class SongWithArtistTile extends StatelessWidget {
  final SongWithArtist songWithArtist;
  final bool isPlaying;
  final VoidCallback onTap;

  const SongWithArtistTile({
    super.key,
    required this.songWithArtist,
    required this.isPlaying,
    required this.onTap,
  });

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    return "$minutes mins";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(songWithArtist.song.imageURL.toString()),
          ),
          title: Text(songWithArtist.song.title),

          subtitle: Text("${formatDuration(songWithArtist.song.duration)}  ${songWithArtist.artist.name} - ${songWithArtist.artist.genre}"),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: const TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
