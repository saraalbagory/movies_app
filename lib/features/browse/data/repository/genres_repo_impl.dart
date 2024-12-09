import 'package:movies_app/features/browse/data/data_sources/api_genres_get.dart';
import 'package:movies_app/features/browse/data/models/GenresModel.dart';
import 'package:movies_app/features/browse/domain/repositoy/genres_repo.dart';

class GenresRepoImpl extends GenresRepo {
  final ApiGenresGet apiGenresGet;

  GenresRepoImpl(this.apiGenresGet);

  @override
  Future<List<Genre>> getAllGenres() async {
    try {
      final genresResponse = await apiGenresGet.getAllGenres();

      if (genresResponse.genres == null) {
        throw Exception("No genres found.");
      }

      return genresResponse.genres!;
    } catch (e) {
      print("Error in genres repository: $e");
      throw Exception("Failed to fetch genres.");
    }
  }
}
