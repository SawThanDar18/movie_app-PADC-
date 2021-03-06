/*
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

abstract class MovieModel {

  //Network
  Future<List<MovieVO>?> getNowPlayingMovies(int page);
  Future<List<MovieVO>?> getPopularMovies(int page);
  Future<List<MovieVO>?> getTopRatedMovies(int page);
  Future<List<GenreVO>?> getGenres();
  Future<List<MovieVO>?> getMoviesByGenre(int genreId);
  Future<List<ActorVO>?> getActors(int page);
  Future<MovieVO?> getMovieDetails(int movieId);
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId);

  //Database
  Future<List<MovieVO>?> getTopRatedMoviesFromDatabase();
  Future<List<MovieVO>?> getNowPlayingMoviesFromDatabase();
  Future<List<MovieVO>?> getPopularMoviesFromDatabase();
  Future<List<GenreVO>?> getGenresFromDatabase();
  Future<List<ActorVO>?> getAllActorsFromDatabase();
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId);

}*/

import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class MovieModel extends Model {
  void getNowPlayingMovies(int page);
  void getPopularMovies(int page);
  void getTopRatedMovies(int page);

  Future<List<GenreVO>> getGenres();
  Future<List<MovieVO>> getMoviesByGenre(int genreId);
  Future<List<ActorVO>> getActors(int page);

  Future<MovieVO> getMovieDetails(int movieId);
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId);

  Stream<List<MovieVO>> getTopRatedMoviesFromDatabase();
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase();
  Stream<List<MovieVO>> getPopularMoviesFromDatabase();
  Stream<List<GenreVO>> getGenresFromDatabase();
  Stream<List<ActorVO>> getAllActorsFromDatabase();
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId);
}
