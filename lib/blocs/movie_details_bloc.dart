/*
import 'dart:async';

import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class MovieDetailsBloc {

  StreamController<MovieVO> movieStreamController = StreamController();
  StreamController<List<ActorVO>> actorsStreamController = StreamController();
  StreamController<List<ActorVO>> creatorsStreamController = StreamController();

  MovieModel movieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId) {

    movieModel.getMovieDetails(movieId).then((movie) {
      movieStreamController.sink.add(movie);
    });

    movieModel.getMovieDetailsFromDatabase(movieId).then((movie) {
      movieStreamController.sink.add(movie);
    });

    movieModel.getCreditsByMovie(movieId).then((actorList) {
      actorsStreamController.sink.add(actorList.first ?? []);
      creatorsStreamController.sink.add(actorList[1] ?? []);
    });

  }

  void dispose() {
    movieStreamController.close();
    actorsStreamController.close();
    creatorsStreamController.close();
  }


}*/

import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class MovieDetailsBloc extends ChangeNotifier{

  MovieVO? mMovie;
  List<ActorVO>? castList;
  List<ActorVO>? crewList;

  MovieModel movieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId) {

    movieModel.getMovieDetails(movieId).then((movie) {
      mMovie = movie;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    movieModel.getMovieDetailsFromDatabase(movieId).then((movie) {
      mMovie = movie;
      notifyListeners();
    });

    movieModel.getCreditsByMovie(movieId).then((actorList) {
      castList = actorList.first ?? [];
      crewList = actorList[1] ?? [];
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

  }

}