import 'user_history_repository.dart';

class UserHistoryRepositoryMock implements UserHistoryRepository {
  final List<String> _recentSongIds = [
    '101', 
    '102', 
  ];

  @override
  List<String> fetchRecentSongIds() {
    return _recentSongIds;
  }
}
