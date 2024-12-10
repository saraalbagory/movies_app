import 'package:movies_app/features/movies_details/data/models/get_movie_details_reponse.dart';

abstract class MovieDetailsDataSource {
  Future<GetMovieDetailResponse> getMovieDetail(String movieId);
}