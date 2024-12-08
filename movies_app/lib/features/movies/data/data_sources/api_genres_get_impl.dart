import 'package:movies_app/features/movies/data/data_sources/api_genres_get.dart';
import 'package:movies_app/features/movies/data/models/GenresModel.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/support/resources/api_info/api_consts.dart';

class ApiGenresGetImpl extends ApiGenresGet {
  final dio = Dio(BaseOptions(baseUrl: ApiConsts.baseUrl));
  @override
  Future<Genres> getAllGenres() async {
    // TODO: implement getAllGenres
    try {
      var response = await dio.get(
        ApiConsts.getAllGenres,
        queryParameters: {
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
      return Genres.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
