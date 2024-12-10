import 'package:movies_app/features/browse/data/models/SearchReturnModel.dart';

abstract class SearchMoviesRepo {
  Future<List<SearchResults>> getSearchMovies(String query);
}
