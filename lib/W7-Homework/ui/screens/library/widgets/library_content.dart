import 'package:flutter/material.dart';
import 'package:practice/W7-Homework/ui/states/settings_state.dart';
import 'package:practice/W7-Homework/ui/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../../../model/songs/song.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsState = context.watch<AppSettingsState>();
    final viewModel = context.watch<LibraryViewModel>();
    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your recent songs", style: AppTextStyles.body),
                  ...viewModel.recentSongs.map(
                    (song) => SongTile(
                      song: song,
                      isPlaying: viewModel.currentSong == song,
                      onPlay: () => viewModel.play(song),
                      onStop: () => viewModel.stop(),
                    ),
                  ),

                  const SizedBox(height: 24),
                  Text("All songs", style: AppTextStyles.body),
                  ...viewModel.songs.map(
                    (song) => SongTile(
                      song: song,
                      isPlaying: viewModel.currentSong == song,
                      onPlay: () => viewModel.play(song),
                      onStop: () => viewModel.stop(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onPlay,
    required this.onStop,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onPlay;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(song.title),
      trailing: isPlaying
          ? TextButton(
              onPressed: onStop,
              child: const Text("STOP", style: TextStyle(color: Colors.red)),
            )
          : TextButton(
              onPressed: onPlay,
              child: const Text("Play", style: TextStyle(color: Colors.green)),
            ),
    );
  }
}
