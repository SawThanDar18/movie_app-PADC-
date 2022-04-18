
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
  List<MovieVO> nowPlayingMovies = [];
  List<MovieVO> popularMovies = [];
  List<MovieVO> topRatedMovies = [];
  List<MovieVO> moviesByGenre = [];
  List<GenreVO> mGenreList = [];
  List<ActorVO> actors = [];

  int pageForNowPlayingMovies = 1;

  MovieModel movieModel = MovieModelImpl();

  HomeBloc([MovieModel? mMovieModel]) {

    if (mMovieModel != null) {
      this.movieModel = mMovieModel;
    }

    movieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      nowPlayingMovies = movieList;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    movieModel.getPopularMoviesFromDatabase().listen((movieList) {
      popularMovies = movieList;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    movieModel.getGenres().then((genreList) {
      mGenreList = genreList;

      if (mGenreList.isNotEmpty) {
        getMoviesByGenreAndRefresh(mGenreList.first.id ?? 0);
      }
    }).catchError((error) {
      debugPrint(error.toString());
    });

    movieModel.getGenresFromDatabase().listen((genreList) {
      mGenreList = genreList;

      if (mGenreList.isNotEmpty) {
        getMoviesByGenreAndRefresh(mGenreList.first.id ?? 0);
      }
    }).onError((error) {
      debugPrint(error.toString());
    });

    movieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
      topRatedMovies = movieList;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    movieModel.getActors(1).then((actorList) {
      actors = actorList;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    movieModel.getAllActorsFromDatabase().listen((actorList) {
      actors = actorList;
      notifyListeners();
    }).onError((error) {
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

  void nowPlayingMovieListEndReached() {
    this.pageForNowPlayingMovies += 1;
    movieModel.getNowPlayingMovies(pageForNowPlayingMovies);
  }

}
/*
if (nowPlayingMovies.isNotEmpty) {
nowPlayingMovies.sort((a, b) => a.id ?? 0 - b.id);
}*/
