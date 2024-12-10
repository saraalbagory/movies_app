import 'package:movies_app/features/browse/data/models/GenresModel.dart';
import 'package:movies_app/features/browse/domain/repositoy/genres_repo.dart';

class ViewGenres {
  GenresRepo genresRepo;
  ViewGenres(this.genresRepo);
  Future<List<Genre>> call() => genresRepo.getAllGenres();
}
