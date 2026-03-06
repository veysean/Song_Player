import 'package:flutter/material.dart';
import 'package:practice/W7-Homework/data/repositories/songs/user_history_repository.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';
import 'view_model/library_view_model.dart';
import 'widgets/library_content.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final songRepository = context.read<SongRepository>();
    final playerState = context.read<PlayerState>();
    final userHistoryRepository = context.read<UserHistoryRepository>();

    return ChangeNotifierProvider(
      create: (_) {
        final vm = LibraryViewModel(
          songRepository: songRepository,
          userHistoryRepository : userHistoryRepository,
          playerState: playerState,
        );
        vm.init();
        return vm;
      },
      child: const LibraryContent(),
    );
  }
}
