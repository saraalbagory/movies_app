import 'package:movies_app/features/watchList/data/models/watchlist_model.dart';

abstract class WatchlistRepository {
  Future<void> addWatchlistItem(WatchlistModel movie);
  Future<void> removeWatchlistItem(String id);
  Stream<List<WatchlistModel>> fetchWatchlistItems();
}
