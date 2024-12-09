import 'package:bloc/bloc.dart';
import 'package:movies_app/features/browse/domain/usecases/search_by_name.dart';
import 'package:movies_app/features/browse/presentation/bloc/search/search_cubit_states.dart';

class SearchCubit extends Cubit<SearchState> {
  //final SearchMoviesRepo searchRepository;
  final SearchByName searchByNameUseCase;
  SearchCubit(this.searchByNameUseCase) : super(SearchInitial());

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    try {
      final results = await searchByNameUseCase.call(query);
      emit(SearchLoaded(results));
    } catch (e) {
      emit(SearchError("An error occurred while searching: $e"));
    }
  }
}
