import 'package:movies_app/features/watchList/data/models/watchlist_model.dart';
import 'package:movies_app/features/watchList/domain/repository/watchlist_repository.dart';

class AddToWatchlistUseCase {
  final WatchlistRepository repository;

  AddToWatchlistUseCase(this.repository);

  Future<void> call(WatchlistModel item) {
    return repository.addWatchlistItem(item);
  }
}

class RemoveFromWatchlistUseCase {
  final WatchlistRepository repository;

  RemoveFromWatchlistUseCase(this.repository);

  Future<void> call(String id) {
    return repository.removeWatchlistItem(id);
  }
}

class GetWatchlistItemsUseCase {
  final WatchlistRepository repository;

  GetWatchlistItemsUseCase(this.repository);

  Stream<List<WatchlistModel>> call() {
    return repository.fetchWatchlistItems();
  }
}
