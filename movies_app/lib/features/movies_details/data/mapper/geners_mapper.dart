import 'package:movies_app/features/movies_details/data/models/get_movie_details_reponse.dart';
import 'package:movies_app/features/movies_details/domain/entites/genre_model.dart';

extension GenersMapper on Genres{
  GenreModel genresToGenreModel()=>GenreModel(id: id,name: name);
}