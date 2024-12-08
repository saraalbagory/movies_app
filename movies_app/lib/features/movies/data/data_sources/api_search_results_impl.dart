import 'package:dio/dio.dart';
import 'package:movies_app/features/movies/data/data_sources/api_search_result.dart';
import 'package:movies_app/features/movies/data/models/SearchReturnModel.dart';
import 'package:movies_app/support/resources/api_info/api_consts.dart';

class ApiSearchResultsImpl extends ApiSearchResult {
  final dio = Dio(BaseOptions(baseUrl: ApiConsts.baseUrl));

  @override
  Future<SearchReturnModel> getSearchResults(String query) async {
    try {
      var response = await dio.get(
        ApiConsts.searchEndpoint,
        queryParameters: {
          'query': query,
          'api_key': ApiConsts.apiKey,
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${ApiConsts.apiAccessToken}', // If required
          },
        ),
      );
      if (response.data == null) {
        throw Exception("No data received from the API.");
      }
      print(response.data);
      return SearchReturnModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
