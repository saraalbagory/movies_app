import 'package:bloc/bloc.dart';
import 'package:movies_app/features/watchList/data/models/watchlist_model.dart';
import 'package:movies_app/features/watchList/domain/usecases/add_to_watchlist_use_case.dart';
import 'package:movies_app/features/watchList/presentation/cubit/watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final AddToWatchlistUseCase addToWatchlist;
  final RemoveFromWatchlistUseCase removeFromWatchlist;
  final GetWatchlistItemsUseCase getWatchlistItems;

  WatchlistCubit({
    required this.addToWatchlist,
    required this.removeFromWatchlist,
    required this.getWatchlistItems,
  }) : super(WatchlistInitial());

  void loadWatchlist() {
    emit(WatchlistLoading());
    getWatchlistItems().listen(
      (items) {
        emit(WatchlistLoaded(items));
      },
      onError: (error) {
        emit(WatchlistError(error.toString()));
      },
    );
  }

  Future<void> addItem(WatchlistModel item) async {
    try {
      await addToWatchlist(item);
    } catch (error) {
      emit(WatchlistError(error.toString()));
    }
  }

  Future<void> removeItem(String id) async {
    try {
      await removeFromWatchlist(id);
    } catch (error) {
      emit(WatchlistError(error.toString()));
    }
  }
}
