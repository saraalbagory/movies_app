import 'package:movies_app/features/browse/data/data_sources/api_search_result.dart';
import 'package:movies_app/features/browse/data/models/SearchReturnModel.dart';
import 'package:movies_app/features/browse/domain/repositoy/search_movies_repo.dart';

class SearchMoviesRepoImpl extends SearchMoviesRepo {
  final ApiSearchResult apiSearchResult;
  SearchMoviesRepoImpl(this.apiSearchResult);
  @override
  Future<List<SearchResults>> getSearchMovies(String query) async {
    try {
      var response = await apiSearchResult.getSearchResults(query);

      if (response.results == null) {
        throw Exception("No results found.");
      }

      return response.results!;
    } catch (e) {
      print("Error in searchMovies: $e");
      throw Exception("Failed to fetch search results.");
    }
  }
}
