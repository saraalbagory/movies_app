import 'package:dio/dio.dart';
import 'package:movies_app/features/movies/data/data_sources/api_movies_by_genre.dart';
import 'package:movies_app/features/movies/data/models/GenresModel.dart';
import 'package:movies_app/features/movies/data/models/moviesByGenre.dart';
import 'package:movies_app/support/resources/api_info/api_consts.dart';

class ApiMoviesByGenreImpl extends ApiMoviesByGenre {
  final dio = Dio(BaseOptions(baseUrl: ApiConsts.baseUrl));
  @override
  Future<MoviesByGenre> getMoviesByGenre(Genre genre) async {
    try {
      var response = await dio.get(
        ApiConsts.getAllGenres,
        queryParameters: {'api_key': ApiConsts.apiKey, 'with_genres': genre.id},
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
      return MoviesByGenre.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
