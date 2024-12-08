import 'package:movies_app/features/browse/data/models/SearchReturnModel.dart';
import 'package:movies_app/features/browse/domain/repositoy/search_movies_repo.dart';

class SearchByName {
  SearchMoviesRepo searchMoviesRepo;
  //String query;
  SearchByName(this.searchMoviesRepo);
  Future<List<SearchResults>> call(String query) =>
      searchMoviesRepo.getSearchMovies(query);
}
