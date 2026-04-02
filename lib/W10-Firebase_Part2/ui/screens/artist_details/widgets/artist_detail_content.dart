import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/songs/song.dart';
import '../../../../model/comment/comment.dart';
import '../../../theme/theme.dart';
import '../../../utils/async_value.dart';
import '../view_model/artist_detail_view_model.dart';
import 'comment_tile.dart';
import 'comment_form.dart';

class ArtistDetailContent extends StatelessWidget {
  final String artistId;
  const ArtistDetailContent({super.key, required this.artistId});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ArtistDetailViewModel>();

    final artistValue = vm.artistValue;
    final songsValue = vm.songsValue;
    final commentsValue = vm.commentsValue;

    Widget artistHeader;
    switch (artistValue.state) {
      case AsyncValueState.loading:
        artistHeader = const Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        artistHeader = Text(
          'error = ${artistValue.error!}',
          style: const TextStyle(color: Colors.red),
        );
        break;
      case AsyncValueState.success:
        final artist = artistValue.data!;
        artistHeader = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(artist.name, style: AppTextStyles.heading),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.blue),
              onPressed: () async {
                vm.fetchArtist(artistId);
                vm.fetchSongs(artistId);
                vm.fetchComments(artistId);
              },
            ),
          ],
        );
        break;
    }

    Widget songsSection;
    switch (songsValue.state) {
      case AsyncValueState.loading:
        songsSection = const Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        songsSection = Text(
          'error = ${songsValue.error!}',
          style: const TextStyle(color: Colors.red),
        );
        break;
      case AsyncValueState.success:
        final songs = songsValue.data!;
        songsSection = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Songs", style: AppTextStyles.body),
            const SizedBox(height: 8),
            if (songs.isEmpty)
              const Text("No songs available")
            else
              ...songs.map(
                (Song song) => ListTile(
                  leading: const Icon(Icons.music_note),
                  title: Text(song.title),
                  subtitle: Text('${song.duration.inMinutes} min'),
                ),
              ),
          ],
        );
        break;
    }

    Widget commentsSection;
    switch (commentsValue.state) {
      case AsyncValueState.loading:
        commentsSection = const Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        commentsSection = Text(
          'error = ${commentsValue.error!}',
          style: const TextStyle(color: Colors.red),
        );
        break;
      case AsyncValueState.success:
        final comments = commentsValue.data!;
        commentsSection = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Comments", style: AppTextStyles.body),
            const SizedBox(height: 8),
            if (comments.isEmpty)
              const Text("No comments yet")
            else
              ...comments.map((Comment c) => CommentTile(comment: c)),
          ],
        );
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          artistHeader,
          const SizedBox(height: 30),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                vm.fetchArtist(artistId);
                vm.fetchSongs(artistId);
                vm.fetchComments(artistId);
              },
              child: ListView(
                children: [
                  songsSection,
                  const SizedBox(height: 20),
                  commentsSection,
                ],
              ),
            ),
          ),
          CommentForm(onSubmit: (text) => vm.postComment(artistId, text)),
        ],
      ),
    );
  }
}
