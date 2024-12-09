import 'package:dio/dio.dart';
import 'package:movies_app/features/movies_details/data/data_source/movie_details_data_source.dart';
import 'package:movies_app/features/movies_details/data/models/get_movie_details_reponse.dart';
import 'package:movies_app/support/resources/api_info/api_consts.dart';

class MovieDetailsDataSourceImpl extends MovieDetailsDataSource{
  final dio = Dio(BaseOptions(baseUrl: ApiConsts.baseUrl));
  @override
  Future<GetMovieDetailResponse> getMovieDetail(String movieId) async{
    try{
      var response=await dio.get(
        ApiConsts.moviesDetailsEndpoint+movieId,
        options: Options(
          headers: {
            'Authorization': ApiConsts.apiAccessToken,
            'accept': 'application/json',
          },
        ),
      );
      print(response.data);
      return GetMovieDetailResponse.fromJson(response.data);

    }
    catch(e){
      throw e.toString();
    }
  }
}