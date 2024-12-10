import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/browse/domain/usecases/view_genres.dart';
import 'package:movies_app/features/browse/presentation/bloc/genres/genres_cubit_states.dart';

class GenresCubit extends Cubit<CategoriesState> {
  //final GenresRepo genresRepository;
  final ViewGenres viewGenresUseCase;
  GenresCubit(this.viewGenresUseCase) : super(CategoriesLoading());

  void fetchCategories() async {
    try {
      final genres = await viewGenresUseCase.call();
      emit(CategoriesLoaded(genres));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}
