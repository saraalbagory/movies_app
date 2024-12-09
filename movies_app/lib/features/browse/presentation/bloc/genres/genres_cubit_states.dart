import 'package:movies_app/features/browse/data/models/GenresModel.dart';

abstract class CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<Genre> genres;

  CategoriesLoaded(this.genres);
}

class CategoriesError extends CategoriesState {
  final String message;

  CategoriesError(this.message);
}
