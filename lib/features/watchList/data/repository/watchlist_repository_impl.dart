import 'package:movies_app/features/watchList/data/data_sources/watchlist_data_source.dart';
import 'package:movies_app/features/watchList/data/models/watchlist_model.dart';
import 'package:movies_app/features/watchList/domain/repository/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistDataSource remoteDataSource;

  WatchlistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addWatchlistItem(WatchlistModel item) {
    return remoteDataSource.addItemToWatchlist(item);
  }

  @override
  Future<void> removeWatchlistItem(String id) {
    return remoteDataSource.removeItemFromWatchlist(id);
  }

  @override
  Stream<List<WatchlistModel>> fetchWatchlistItems() {
    return remoteDataSource.getWatchlistItems();
  }
}
