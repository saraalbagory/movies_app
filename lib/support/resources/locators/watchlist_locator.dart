import 'package:get_it/get_it.dart';
import 'package:movies_app/features/watchList/data/data_sources/watchlist_data_source.dart';
import 'package:movies_app/features/watchList/data/repository/watchlist_repository_impl.dart';
import 'package:movies_app/features/watchList/domain/repository/watchlist_repository.dart';
import 'package:movies_app/features/watchList/domain/usecases/add_to_watchlist_use_case.dart';
import 'package:movies_app/features/watchList/presentation/cubit/watchlist_cubit.dart';

final wl = GetIt.instance;
void watchlistLocator() {
  WatchlistDataSource watchlistdatasource = WatchlistDataSource();
  WatchlistRepository watchlistRepository =
      WatchlistRepositoryImpl(remoteDataSource: watchlistdatasource);

  // wl.registerLazySingleton(() => WatchlistDataSource());
  // wl.registerLazySingleton(
  //     () => WatchlistRepositoryImpl(remoteDataSource: watchlistdatasource));

  wl.registerFactory<AddToWatchlistUseCase>(
      () => AddToWatchlistUseCase(watchlistRepository));
  wl.registerFactory<RemoveFromWatchlistUseCase>(
      () => RemoveFromWatchlistUseCase(watchlistRepository));
  wl.registerFactory<GetWatchlistItemsUseCase>(
      () => GetWatchlistItemsUseCase(watchlistRepository));

  wl.registerFactory(() => WatchlistCubit(
      addToWatchlist: wl<AddToWatchlistUseCase>(),
      removeFromWatchlist: wl<RemoveFromWatchlistUseCase>(),
      getWatchlistItems: wl<GetWatchlistItemsUseCase>()));
}
