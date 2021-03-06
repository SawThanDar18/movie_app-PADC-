import 'package:movie_app/data/vos/movie_vo.dart';

/*class MovieDao {
  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }

  MovieDao._internal();

  void saveMovies(List<MovieVO> movies) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(movies,
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(movieMap);
  }

  void saveSingleMovie(MovieVO movie) async {
    return getMovieBox().put(movie.id, movie);
  }

  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  MovieVO? getMovieById(int movieId) {
    return getMovieBox().get(movieId);
  }

  Stream<void> getAllMoviesEventStream() {
    return getMovieBox().watch();
  }

  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  List<MovieVO> getNowPlayingMovies() {
    if ((getAllMovies().isNotEmpty)) {
      return getAllMovies()
          .where((element) => element.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  Stream<List<MovieVO>> getPopularMoviesStream() {
    return Stream.value(
        getAllMovies().where((element) => element.isPopular ?? false).toList());
  }

  List<MovieVO> getPopularMovies() {
    if ((getAllMovies().isNotEmpty)) {
      return getAllMovies()
          .where((element) => element.isPopular ?? false)
          .toList();
    } else {
      return [];
    }
  }

  Stream<List<MovieVO>> getTopRatedMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isTopRated ?? false)
        .toList());
  }

  List<MovieVO> getTopRatedMovies() {
    if ((getAllMovies().isNotEmpty)) {
      return getAllMovies()
          .where((element) => element.isTopRated ?? false)
          .toList();
    } else {
      return [];
    }
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}*/

abstract class MovieDao {

  void saveMovies(List<MovieVO> movies);

  void saveSingleMovie(MovieVO movie);

  List<MovieVO> getAllMovies();

  MovieVO? getMovieById(int movieId);

  Stream<void> getAllMoviesEventStream();

  Stream<List<MovieVO>> getNowPlayingMoviesStream();

  List<MovieVO> getNowPlayingMovies();

  Stream<List<MovieVO>> getPopularMoviesStream();

  List<MovieVO> getPopularMovies();

  Stream<List<MovieVO>> getTopRatedMoviesStream();

  List<MovieVO> getTopRatedMovies();

}
