import 'package:movies_app/features/browse/data/models/SearchReturnModel.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<SearchResults> movies;
  SearchLoaded(this.movies);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
