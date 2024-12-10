import 'package:movies_app/features/movies_details/data/data_source/movie_details_data_source.dart';
import 'package:movies_app/features/movies_details/data/mapper/movie_details_mapper.dart';
import 'package:movies_app/features/movies_details/domain/entites/movie_details_model.dart';
import 'package:movies_app/features/movies_details/domain/repositry/movies_details_repositry.dart';

class MovieDetailsRepoImpl extends MoviesDetailsRepositry {
  MovieDetailsDataSource movieDetailsDataSource;
  MovieDetailsRepoImpl(this.movieDetailsDataSource);
  @override
  Future<MovieDetailsModel> fetchMovieDetails(String movieId) async {
    try{
      var response= await movieDetailsDataSource.getMovieDetail(movieId);
     // print(respo)
      return response.movieDetailsResToDetailsModel();
    }
    catch(e){
      throw e.toString();
    }
  }
}
