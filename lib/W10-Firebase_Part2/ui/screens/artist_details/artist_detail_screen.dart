import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/artist/artist_repository.dart';
import 'view_model/artist_detail_view_model.dart';
import 'widgets/artist_detail_content.dart';

class ArtistDetailScreen extends StatelessWidget {
  final String artistId;

  const ArtistDetailScreen({super.key, required this.artistId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final vm = ArtistDetailViewModel(
          artistRepository: context.read<ArtistRepository>(),
        );
        vm.fetchArtist(artistId);
        vm.fetchSongs(artistId);
        vm.fetchComments(artistId);
        return vm;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Artist Details")),
        body: ArtistDetailContent(artistId: artistId),
      ),
    );
  }
}
