
/*
class HomeBloc {

  /// Reactive Streams
  StreamController<List<MovieVO>> mNowPlayingMoviesStreamController = StreamController();
  StreamController<List<MovieVO>> mPopularMoviesStreamController = StreamController();
  StreamController<List<GenreVO>> mGenreListStreamController = StreamController();
  StreamController<List<ActorVO>> mActorsListStreamController = StreamController();
  StreamController<List<MovieVO>> mTopRatedMoviesStreamController = StreamController();
  StreamController<List<MovieVO>> mMoviesByGenreStreamController = StreamController();

  MovieModel movieModel = MovieModelImpl();

  HomeBloc() {

    movieModel.getNowPlayingMoviesFromDatabase().then((movieList) {
      mNowPlayingMoviesStreamController.sink.add(movieList);
    }).catchError((error) {});

    movieModel.getPopularMoviesFromDatabase().then((movieList) {
      mPopularMoviesStreamController.sink.add(movieList);
    }).catchError((error) {});

    movieModel.getGenres().then((genreList) {
      mGenreListStreamController.sink.add(genreList);

      getMoviesByGenreAndRefresh(genreList.first.id ?? 0);
    }).catchError((error) {});

    movieModel.getGenresFromDatabase().then((genreList) {
      mGenreListStreamController.sink.add(genreList);

      getMoviesByGenreAndRefresh(genreList.first.id ?? 0);
  }).catchError((error) {});

    movieModel.getTopRatedMoviesFromDatabase().then((movieList) {
      mTopRatedMoviesStreamController.sink.add(movieList);
    }).catchError((error) {});

    movieModel.getActors(1).then((actorList) {
      mActorsListStreamController.sink.add(actorList);
    }).catchError((error) {});

    movieModel.getAllActorsFromDatabase().then((actorList) {
      mActorsListStreamController.sink.add(actorList);
    }).catchError((error) {});

  }

  void onTapGenre(int genreId) {
    getMoviesByGenreAndRefresh(genreId);
  }

  void getMoviesByGenreAndRefresh(int genreId) {
    movieModel.getMoviesByGenre(genreId).then((moviesByGenre) {
      mMoviesByGenreStreamController.sink.add(moviesByGenre);
    }).catchError((error) {});
  }

  void dispose() {
    mNowPlayingMoviesStreamController.close();
    mPopularMoviesStreamController.close();
    mGenreListStreamController.close();
    mActorsListStreamController.close();
    mTopRatedMoviesStreamController.close();
    mMoviesByGenreStreamController.close();
  }

}*/

import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class HomeBloc extends ChangeNotifier {

  /// States
  late List<MovieVO> nowPlayingMovies;
  late List<MovieVO> popularMovies;
  late List<MovieVO> topRatedMovies;
  late List<MovieVO> moviesByGenre;
  late List<GenreVO> mGenreList;
  late List<ActorVO> actors;

  MovieModel movieModel = MovieModelImpl();

  HomeBloc() {

    movieModel.getNowPlayingMoviesFromDatabase().then((movieList) {
      nowPlayingMovies = movieList;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    movieModel.getPopularMoviesFromDatabase().then((movieList) {
      popularMovies = movieList;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    movieModel.getGenresFromDatabase().then((genreList) {
      mGenreList = genreList;

      getMoviesByGenreAndRefresh(mGenreList.first.id ?? 0);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    movieModel.getGenresFromDatabase().then((genreList) {
      mGenreList = genreList;

      getMoviesByGenreAndRefresh(mGenreList.first.id ?? 0);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    movieModel.getTopRatedMoviesFromDatabase().then((movieList) {
      topRatedMovies = movieList;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    movieModel.getActors(1).then((actorList) {
      actors = actorList;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    movieModel.getAllActorsFromDatabase().then((actorList) {
      actors = actorList;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

  }

  void onTapGenre(int genreId) {
    getMoviesByGenreAndRefresh(genreId);
  }

  void getMoviesByGenreAndRefresh(int genreId) {
    movieModel.getMoviesByGenre(genreId).then((moviesByGenre) {
     this.moviesByGenre = moviesByGenre;
     notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

}
