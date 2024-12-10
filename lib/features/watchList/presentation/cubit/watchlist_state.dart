import 'package:equatable/equatable.dart';
import 'package:movies_app/features/watchList/data/models/watchlist_model.dart';


abstract class WatchlistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<WatchlistModel> items;

  WatchlistLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class WatchlistError extends WatchlistState {
  final String message;

  WatchlistError(this.message);

  @override
  List<Object?> get props => [message];
}
