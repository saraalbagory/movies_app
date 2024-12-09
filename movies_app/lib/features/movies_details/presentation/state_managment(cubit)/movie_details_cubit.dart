import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movies_details/domain/repositry/movies_details_repositry.dart';
import 'package:movies_app/features/movies_details/presentation/state_managment(cubit)/movie_details_cubit_states.dart';
import 'package:movies_app/support/resources/locators/api_locator.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsCubitStates>{
  late MoviesDetailsRepositry moviesDetailsRepositry;
  MovieDetailsCubit():super(IntialState()){
    moviesDetailsRepositry=ApiLocator.moviesDetailsRepositry;
  }

  void getMovieDetails(String movieId)async{
    emit(LoadingMovieDetailsState());
    try{
      var response= await moviesDetailsRepositry.fetchMovieDetails(movieId);
      emit(SucessfulfetchingMovieDetailsState(movieDetailsModel: response));
    }
    catch(e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }


}