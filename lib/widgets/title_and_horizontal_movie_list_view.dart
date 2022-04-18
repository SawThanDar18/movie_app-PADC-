import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/smart_list_view.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/viewitems/movie_view.dart';
import 'package:movie_app/widgets/title_text.dart';

class TitleAndHorizontalMovieListView extends StatelessWidget {
  final String title;
  final Function(int?) onTapMovie;
  final List<MovieVO>? nowPlayingMovies;
  final Function onListEndReached;

  TitleAndHorizontalMovieListView(
      {required this.title,
      required this.onTapMovie,
      required this.nowPlayingMovies,
      required this.onListEndReached});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(title),
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        HorizontalMovieListView(
          onTapMovie: (movieId) {
            this.onTapMovie(movieId);
          },
          movieLists: nowPlayingMovies,
          onListEndReached: () {
            this.onListEndReached();
          },
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieLists;
  final Function onListEndReached;

  HorizontalMovieListView(
      {required this.onTapMovie,
      required this.movieLists,
      required this.onListEndReached});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (movieLists != null)
          ? /*ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
        itemCount: movieLists?.length,
        itemBuilder: (BuildContext context, int index) {
          return MovieView(
              onTapMovie: () {
                this.onTapMovie(
                  movieLists?[index].id,
                );
              },
              movie: movieLists?[index]);
        },
      )*/
          SmartHorizontalListView(
              itemCount: movieLists?.length ?? 0,
              padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
              itemBuilder: (BuildContext context, int index) {
                return MovieView(
                    onTapMovie: () {
                      this.onTapMovie(
                        movieLists?[index].id,
                      );
                    },
                    movie: movieLists?[index]);
              },
              onListEndReached: () {
                this.onListEndReached();
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
