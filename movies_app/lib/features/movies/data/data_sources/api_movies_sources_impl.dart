import 'package:movies_app/features/movies/data/data_sources/api_movies_sources.dart';
import 'package:movies_app/features/movies/data/models/get_movies_response.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/support/resources/api_info/api_consts.dart';

class ApiMoviesSourcesImpl extends ApiMoviesSources {
  final dio = Dio(BaseOptions(baseUrl: ApiConsts.baseUrl));
  
  @override
  Future<GetMoviesResponse> getPopuluaMovies() async {
    var response = await dio.get(
      ApiConsts.popularMoviesEndpoint,
      options: Options(
        headers: {
          'Authorization': ApiConsts.apiAccessToken,
          'accept': 'application/json',
        },
      ),
    );
    print(response.data);
    return GetMoviesResponse.fromJson(response.data);

    // TODO: implement getMovies
  }
}
