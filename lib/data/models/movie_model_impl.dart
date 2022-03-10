/*
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/dataagents/movie_data_agent.dart';
import 'package:movie_app/network/dataagents/retrofit_movie_data_agent_impl.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class MovieModelImpl extends MovieModel {

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  MovieDataAgent _dataAgent = RetrofitMovieDataAgentImpl();

  MovieDao movieDao = MovieDao();
  GenreDao genreDao = GenreDao();
  ActorDao actorDao = ActorDao();

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return _dataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies!.map((movie) {
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
      movieDao.saveMovies(nowPlayingMovies);
      //return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    return _dataAgent.getPopularMovies(page).then((movies) async {
      List<MovieVO> popularMovies = movies!.map((movie) {
        movie.isPopular = true;
        movie.isNowPlaying = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
      movieDao.saveMovies(popularMovies);
      //return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    return _dataAgent.getTopRatedMovies(page).then((movies) async {
      List<MovieVO> topRatedMovies = movies!.map((movie) {
        movie.isTopRated = true;
        movie.isNowPlaying = false;
        movie.isPopular = false;
        return movie;
      }).toList();
      movieDao.saveMovies(topRatedMovies);
      //return Future.value(movies);
    });
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return _dataAgent.getGenres().then((genres) async {
      genreDao.saveAllGenres(genres!);
      return Future.value(genres);
    });
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return _dataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return _dataAgent.getActors(page).then((actors) async {
      actorDao.saveAllActors(actors!);
      return Future.value(actors);
    });
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return _dataAgent.getMovieDetails(movieId).then((movie) async {
      movieDao.saveSingleMovie(movie!);
      return Future.value(movie);
    });
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return _dataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<List<MovieVO>?> getTopRatedMoviesFromDatabase() {
    this.getTopRatedMovies(1);
    return movieDao
        .getAllMoviesEventStream()
        .combineLatest(movieDao.getTopRatedMoviesStream(),
            (event, movieList) => movieList as List<MovieVO>)
        .first;
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    this.getNowPlayingMovies(1);
    return movieDao
        .getAllMoviesEventStream()
        .combineLatest(movieDao.getNowPlayingMoviesStream(),
            (event, movieList) => movieList as List<MovieVO>)
        .first;
  }

  @override
  Future<List<MovieVO>?> getPopularMoviesFromDatabase() {
    this.getPopularMovies(1);
    return movieDao
        .getAllMoviesEventStream()
        .combineLatest(movieDao.getPopularMoviesStream(),
            (event, movieList) => movieList as List<MovieVO>)
        .first;
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future<List<GenreVO>>.value(genreDao.getAllGenres());
  }

  @override
  Future<List<ActorVO>?> getAllActorsFromDatabase() {
    return Future.value(actorDao.getAllActors());
  }

  @override
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(movieDao.getMovieById(movieId));
  }

}*/

import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/dataagents/movie_data_agent.dart';
import 'package:movie_app/network/dataagents/retrofit_movie_data_agent_impl.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class MovieModelImpl extends MovieModel {
  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal() {
    getNowPlayingMoviesFromDatabase();
    getTopRatedMoviesFromDatabase();
    getPopularMoviesFromDatabase();
    getGenres();
    getGenresFromDatabase();
    getActors(1);
    getAllActorsFromDatabase();
  }

  MovieDataAgent _dataAgent = RetrofitMovieDataAgentImpl();

  /// Daos
  MovieDao movieDao = MovieDao();
  GenreDao genreDao = GenreDao();
  ActorDao actorDao = ActorDao();

  /// Home Page State
  List<MovieVO>? mNowPlayingMovies;
  List<MovieVO>? mPopularMovies;
  List<MovieVO>? mTopRatedMovies;
  List<MovieVO>? moviesByGenre;
  List<GenreVO>? genresList;
  List<ActorVO>? actorsList;

  /// Movie Details State
  MovieVO? movieDetails;
  List<ActorVO>? cast;
  List<ActorVO>? crew;

  @override
  void getNowPlayingMovies(int page) {
    _dataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies!.map((movie) {
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
      movieDao.saveMovies(nowPlayingMovies);
      // mNowPlayingMovies = nowPlayingMovies;
      // notifyListeners();
    });
  }

  @override
  void getPopularMovies(int page) {
    _dataAgent.getPopularMovies(page).then((movies) async {
      List<MovieVO> popularMovies = movies!.map((movie) {
        movie.isPopular = true;
        movie.isNowPlaying = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
      movieDao.saveMovies(popularMovies);
      // mPopularMovies = popularMovies;
      // notifyListeners();
    });
  }

  @override
  void getTopRatedMovies(int page) {
    _dataAgent.getTopRatedMovies(page).then((movies) async {
      List<MovieVO> topRatedMovies = movies!.map((movie) {
        movie.isTopRated = true;
        movie.isNowPlaying = false;
        movie.isPopular = false;
        return movie;
      }).toList();
      movieDao.saveMovies(topRatedMovies);
      // mTopRatedMovies = topRatedMovies;
      // notifyListeners();
    });
  }

  @override
  Future<List<GenreVO>> getGenres() {
    return _dataAgent.getGenres().then((genres) async {
      genreDao.saveAllGenres(genres!);
      // genresList = genres;
      // getMoviesByGenre(genres.first.id ?? 0);
      // notifyListeners();
      return Future.value(genres);
    });
  }

  @override
  Future<List<MovieVO>> getMoviesByGenre(int genreId) {
    return _dataAgent.getMoviesByGenre(genreId).then((movieList) {
      // moviesByGenre = movieList;
      // notifyListeners();
      return Future.value(movieList);
    });
  }

  @override
  Future<List<ActorVO>> getActors(int page) {
    return _dataAgent.getActors(page).then((actors) async {
      actorDao.saveAllActors(actors!);
      // actorsList = actors;
      // notifyListeners();
      return Future.value(actors);
    });
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
    return _dataAgent.getMovieDetails(movieId).then((movie) async {
      movieDao.saveSingleMovie(movie!);
      // movieDetails = movie;
      // notifyListeners();
      return Future.value(movie);
    });
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return _dataAgent.getCreditsByMovie(movieId);
    //     .then((creditsList) {
    //     cast = creditsList.first;
    //     crew = creditsList[1];
    //     notifyListeners();
    //     return Future.value(creditsList);
    // });
  }

  @override
  Future<List<MovieVO>> getTopRatedMoviesFromDatabase() {
    this.getTopRatedMovies(1);
    return movieDao
        .getAllMoviesEventStream()
        .startWith(movieDao.getTopRatedMoviesStream())
        .map((event) => movieDao.getTopRatedMovies()).first
        .then((value) {
      // mTopRatedMovies = value;
      // notifyListeners();
      return Future.value(value);
    });
  }

  @override
  Future<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    this.getNowPlayingMovies(1);
    return movieDao
        .getAllMoviesEventStream()
        .startWith(movieDao.getNowPlayingMoviesStream())
        .map((event) => movieDao.getNowPlayingMovies()).first;
    //     .then((value) {
    //   mNowPlayingMovies = value;
    //   notifyListeners();
    //   return Future.value(value);
    // });
  }

  @override
  Future<List<MovieVO>> getPopularMoviesFromDatabase() {
    this.getPopularMovies(1);
    return movieDao
        .getAllMoviesEventStream()
        .startWith(movieDao.getPopularMoviesStream())
        .map((event) => movieDao.getPopularMovies()).first;
    //     .then((value) {
    //   mPopularMovies = value;
    //   notifyListeners();
    //   return Future.value(value);
    // });
  }

  @override
  Future<List<GenreVO>> getGenresFromDatabase() {
    // genresList = genreDao.getAllGenres();
    // notifyListeners();
    return Future.value(genreDao.getAllGenres());
  }

  @override
  Future<List<ActorVO>> getAllActorsFromDatabase() {
    // actorsList = actorDao.getAllActors();
    // notifyListeners();
    return Future.value(actorDao.getAllActors());
  }

  @override
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId) {
    // movieDetails = movieDao.getMovieById(movieId);
    // notifyListeners();
    return Future.value(movieDao.getMovieById(movieId));
  }
}
