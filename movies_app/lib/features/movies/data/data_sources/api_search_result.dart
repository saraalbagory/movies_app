import 'package:movies_app/features/movies/data/models/SearchReturnModel.dart';

abstract class ApiSearchResult {
  Future<SearchReturnModel> getSearchResults(String query);
}
