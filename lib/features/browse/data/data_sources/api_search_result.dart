import 'package:movies_app/features/browse/data/models/SearchReturnModel.dart';

abstract class ApiSearchResult {
  Future<SearchReturnModel> getSearchResults(String query);
}
