import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/vos/collection_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/production_company_vo.dart';
import 'package:movie_app/data/vos/production_country_vo.dart';
import 'package:movie_app/data/vos/spoken_language_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO, adapterName: "MovieVOAdapter")
class MovieVO {

  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "backdrop_path")
  @HiveField(1)
  String? backdropPath;

  @JsonKey(name: "genre_ids")
  @HiveField(2)
  List<int>? genreIds;

  @JsonKey(name: "id")
  @HiveField(3)
  int? id;

  @JsonKey(name: "original_language")
  @HiveField(4)
  String? originalLanguage;

  @JsonKey(name: "original_title")
  @HiveField(5)
  String? originalTitle;

  @JsonKey(name: "overview")
  @HiveField(6)
  String? overview;

  @JsonKey(name: "popularity")
  @HiveField(7)
  double? popularity;

  @JsonKey(name: "poster_path")
  @HiveField(8)
  String? posterPath;

  @JsonKey(name: "release_date")
  @HiveField(9)
  String? releaseDate;

  @JsonKey(name: "title")
  @HiveField(10)
  String? title;

  @JsonKey(name: "video")
  @HiveField(11)
  bool? video;

  @JsonKey(name: "vote_average")
  @HiveField(12)
  double? voteAverage;

  @JsonKey(name: "vote_count")
  @HiveField(13)
  int? voteCount;

  @JsonKey(name: "belongs_to_collection")
  @HiveField(14)
  CollectionVO? belongsToCollection;

  @JsonKey(name: "budget")
  @HiveField(15)
  int? budget;

  @JsonKey(name: "genres")
  @HiveField(16)
  List<GenreVO>? genres;

  @JsonKey(name: "homepage")
  @HiveField(17)
  String? homePage;

  @JsonKey(name: "imdb_id")
  @HiveField(18)
  String? imdbId;

  @JsonKey(name: "production_companies")
  @HiveField(19)
  List<ProductionCompanyVO>? productionCompanies;

  @JsonKey(name: "production_countries")
  @HiveField(20)
  List<ProductionCountryVO>? productionCountries;

  @JsonKey(name: "revenue")
  @HiveField(21)
  int? revenue;

  @JsonKey(name: "runtime")
  @HiveField(22)
  int? runtime;

  @JsonKey(name: "spoken_languages")
  @HiveField(23)
  List<SpokenLanguageVO>? spokenLanguages;

  @JsonKey(name: "status")
  @HiveField(24)
  String? status;

  @JsonKey(name: "tagline")
  @HiveField(25)
  String? tagline;

  @HiveField(26)
  bool? isNowPlaying;

  @HiveField(27)
  bool? isPopular;

  @HiveField(28)
  bool? isTopRated;

  MovieVO(
      this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homePage,
      this.imdbId,
      this.productionCompanies,
      this.productionCountries,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.isNowPlaying,
      this.isPopular,
      this.isTopRated);

  //convert from network data(json) to datatype
  factory MovieVO.fromJson(Map<String, dynamic> json) => _$MovieVOFromJson(json);

  //convert from datatype to json
  Map<String, dynamic> toJson() => _$MovieVOToJson(this);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieVO &&
          runtimeType == other.runtimeType &&
          adult == other.adult &&
          backdropPath == other.backdropPath &&
          const ListEquality().equals(genreIds, other.genreIds) &&
          id == other.id &&
          originalLanguage == other.originalLanguage &&
          originalTitle == other.originalTitle &&
          overview == other.overview &&
          popularity == other.popularity &&
          posterPath == other.posterPath &&
          releaseDate == other.releaseDate &&
          title == other.title &&
          video == other.video &&
          voteAverage == other.voteAverage &&
          voteCount == other.voteCount &&
          belongsToCollection == other.belongsToCollection &&
          budget == other.budget &&
          genres == other.genres &&
          homePage == other.homePage &&
          imdbId == other.imdbId &&
          const ListEquality().equals(productionCompanies, other.productionCompanies) &&
          const ListEquality().equals(productionCountries, other.productionCountries) &&
          revenue == other.revenue &&
          runtime == other.runtime &&
          const ListEquality().equals(spokenLanguages, other.spokenLanguages) &&
          status == other.status &&
          tagline == other.tagline &&
          isNowPlaying == other.isNowPlaying &&
          isPopular == other.isPopular &&
          isTopRated == other.isTopRated;

  @override
  int get hashCode =>
      adult.hashCode ^
      backdropPath.hashCode ^
      genreIds.hashCode ^
      id.hashCode ^
      originalLanguage.hashCode ^
      originalTitle.hashCode ^
      overview.hashCode ^
      popularity.hashCode ^
      posterPath.hashCode ^
      releaseDate.hashCode ^
      title.hashCode ^
      video.hashCode ^
      voteAverage.hashCode ^
      voteCount.hashCode ^
      belongsToCollection.hashCode ^
      budget.hashCode ^
      genres.hashCode ^
      homePage.hashCode ^
      imdbId.hashCode ^
      productionCompanies.hashCode ^
      productionCountries.hashCode ^
      revenue.hashCode ^
      runtime.hashCode ^
      spokenLanguages.hashCode ^
      status.hashCode ^
      tagline.hashCode ^
      isNowPlaying.hashCode ^
      isPopular.hashCode ^
      isTopRated.hashCode;

  List<String> getGenreListAsStringList() {
    return genres?.map((genre) => genre.name ?? "").toList() ?? [];
  }

  String getGenreListAsCommaSeparatedString() {
    return getGenreListAsStringList().join(",");
  }

  String getProductionCountriesAsCommaSeparatedString() {
    return productionCountries
        ?.map((country) => country.name ?? "")
        .toList()
        .join(",") ?? "";
  }

  @override
  String toString() {
    return 'MovieVO{adult: $adult, backdropPath: $backdropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount, belongsToCollection: $belongsToCollection, budget: $budget, genres: $genres, homePage: $homePage, imdbId: $imdbId, productionCompanies: $productionCompanies, productionCountries: $productionCountries, revenue: $revenue, runtime: $runtime, spokenLanguages: $spokenLanguages, status: $status, tagline: $tagline, isNowPlaying: $isNowPlaying, isPopular: $isPopular, isTopRated: $isTopRated}';
  }
}