import 'package:movies_app/features/movies_details/domain/entites/genre_model.dart';

class MovieDetailsModel {
  bool? adult;
  String? backdropPath;
  // BelongsToCollection? belongsToCollection;
  int? budget;
  List<GenreModel>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  // List<ProductionCompanies>? productionCompanies;
  // List<ProductionCountries>? productionCountries;
  String? releaseDate;
  int? revenue;
  int? runtime;
  // List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieDetailsModel(
      {this.adult,
      this.backdropPath,
      //this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originCountry,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      // this.productionCompanies,
      // this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      // this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});
}
