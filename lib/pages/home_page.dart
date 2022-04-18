import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/blocs/home_bloc.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/pages/movie_details_page.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/viewitems/banner_view.dart';
import 'package:movie_app/viewitems/movie_view.dart';
import 'package:movie_app/viewitems/showcase_view.dart';
import 'package:movie_app/widgets/actor_and_creators_section_view.dart';
import 'package:movie_app/widgets/text_see_more.dart';
import 'package:movie_app/widgets/title_and_horizontal_movie_list_view.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HOME_SCREEN_BACKGROUND_COLOR,
          title: Text(
            MAIN_SCREEN_APP_BAR_TITLE,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: Icon(
            Icons.menu,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 0, bottom: 0, left: 0, right: MARGIN_MEDIUM_2),
              child: Icon(Icons.search),
            ),
          ],
        ),
        body: Container(
          color: HOME_SCREEN_BACKGROUND_COLOR,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ScopedModelDescendant<MovieModelImpl>(builder: (BuildContext context, Widget child, MovieModelImpl model) {
                //   return  BannerSectionView(
                //     movieList: model.mPopularMovies,
                //   );
                // },),
                // StreamBuilder(
                //   stream: homeBloc.mPopularMoviesStreamController.stream,
                //   builder: (BuildContext context,
                //       AsyncSnapshot<List<MovieVO>> snapShot) {
                //     return BannerSectionView(
                //       movieList: snapShot.data?.take(8).toList(),
                //     );
                //   },
                // ),
                // Consumer<HomeBloc>(
                //   builder: (context, bloc, child) => BannerSectionView(
                //     movieList: bloc.popularMovies?.take(8).toList(),
                //   ),
                // ),
                Selector<HomeBloc, List<MovieVO>>(
                    selector: (context, bloc) => bloc.popularMovies,
                    builder: (context, popularMovieList, child) => BannerSectionView(
                      movieList: popularMovieList.take(8).toList(),
                    ),
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                // ScopedModelDescendant<MovieModelImpl>(builder: (BuildContext context, Widget child, MovieModelImpl model) {
                //   return BestPopularMoviesAndSerialsSectionView(
                //     onTapMovie: (movieId) => _navigateToMovieDetailsScreen(context, movieId),
                //     nowPlayingMovies: model.mNowPlayingMovies,
                //   );
                // },),
                // StreamBuilder(
                //   stream: homeBloc.mNowPlayingMoviesStreamController.stream,
                //   builder: (BuildContext context,
                //       AsyncSnapshot<List<MovieVO>> snapShot) {
                //     return BestPopularMoviesAndSerialsSectionView(
                //       onTapMovie: (movieId) =>
                //           _navigateToMovieDetailsScreen(context, movieId),
                //       nowPlayingMovies: snapShot.data,
                //     );
                //   },
                // ),
                // Consumer<HomeBloc>(
                //   builder: (context, bloc, child) => BestPopularMoviesAndSerialsSectionView(
                //     onTapMovie: (movieId) =>
                //         _navigateToMovieDetailsScreen(context, movieId),
                //     nowPlayingMovies: bloc.nowPlayingMovies,
                //   ),
                // ),
                Selector<HomeBloc, List<MovieVO>>(
                  selector: (context, bloc) => bloc.nowPlayingMovies,
                  builder: (context, nowPlayingMovieList, child) => TitleAndHorizontalMovieListView(
                    title: MAIN_SCREEN_BEST_POPULAR_MOVIES_AND_SERIALS,
                    onTapMovie: (movieId) =>
                        _navigateToMovieDetailsScreen(context, movieId),
                    nowPlayingMovies: nowPlayingMovieList,
                    onListEndReached: () {
                      HomeBloc homeBloc = Provider.of(context, listen: false);
                      homeBloc.nowPlayingMovieListEndReached();
                    },
                  ),
                ),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                CheckMovieShowTimesSectionView(),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                // ScopedModelDescendant<MovieModelImpl>(builder: (BuildContext context, Widget child, MovieModelImpl model) {
                //   return GenreSectionView(
                //     genreList: model.genresList,
                //     moviesByGenre: model.moviesByGenre,
                //     onChooseGenre: (genreId) {
                //       if (genreId != null) {
                //         model.getMoviesByGenre(genreId);
                //       }
                //     },
                //     onTapMovie: (movieId) =>
                //         _navigateToMovieDetailsScreen(context, movieId, model),
                //   );
                // },),
                // StreamBuilder(
                //   stream: homeBloc.mGenreListStreamController.stream,
                //   builder: (BuildContext context,
                //       AsyncSnapshot<List<GenreVO>> genreSnapShot) {
                //     return StreamBuilder(
                //       stream: homeBloc.mMoviesByGenreStreamController.stream,
                //       builder: (BuildContext context,
                //           AsyncSnapshot<List<MovieVO>> moviesByGenreSnapShot) {
                //         return GenreSectionView(
                //           genreList: genreSnapShot.data,
                //           moviesByGenre: moviesByGenreSnapShot.data,
                //           onChooseGenre: (genreId) {
                //             if (genreId != null) {
                //               homeBloc.getMoviesByGenreAndRefresh(genreId);
                //             }
                //           },
                //           onTapMovie: (movieId) =>
                //               _navigateToMovieDetailsScreen(context, movieId),
                //         );
                //       },
                //     );
                //   },
                // ),
                // Consumer<HomeBloc>(
                //   builder: (context, bloc, child) => GenreSectionView(
                //     genreList: bloc.mGenreList,
                //     moviesByGenre: bloc.moviesByGenre,
                //     onChooseGenre: (genreId) {
                //       if (genreId != null) {
                //         bloc.onTapGenre(genreId);
                //       }
                //     },
                //     onTapMovie: (movieId) =>
                //         _navigateToMovieDetailsScreen(context, movieId),
                //   ),
                // ),
                Selector<HomeBloc, List<GenreVO>>(
                  selector: (context, bloc) => bloc.mGenreList,
                  builder: (context, genreList, child) =>
                      Selector<HomeBloc, List<MovieVO>>(
                          selector: (context, bloc) => bloc.moviesByGenre,
                          builder: (context, movieByGenreList, child) =>  GenreSectionView(
                            genreList: genreList,
                            moviesByGenre: movieByGenreList,
                            onChooseGenre: (genreId) {
                              if (genreId != null) {
                                HomeBloc homeBloc = Provider.of<HomeBloc>(context, listen: false);
                                homeBloc.onTapGenre(genreId);
                              }
                            },
                            onTapMovie: (movieId) =>
                                _navigateToMovieDetailsScreen(context, movieId),
                          ),
                      ),
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                // ScopedModelDescendant<MovieModelImpl>(builder: (BuildContext context, Widget child, MovieModelImpl model) {
                //   return ShowCasesSection(
                //     topRatedMovies: model.mTopRatedMovies,
                //   );
                // },),
                // StreamBuilder(
                //   stream: homeBloc.mTopRatedMoviesStreamController.stream,
                //   builder: (BuildContext context,
                //       AsyncSnapshot<List<MovieVO>> snapShot) {
                //     return ShowCasesSection(
                //       topRatedMovies: snapShot.data,
                //     );
                //   },
                // ),
                // Consumer<HomeBloc>(
                //   builder: (context, bloc, child) => ShowCasesSection(
                //     topRatedMovies: bloc.topRatedMovies,
                //   ),
                // ),
                Selector<HomeBloc, List<MovieVO>>(
                  selector: (context, bloc) => bloc.topRatedMovies,
                  builder: (context, topRatedMovieList, child) => ShowCasesSection(
                    topRatedMovies: topRatedMovieList,
                  ),
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                // ScopedModelDescendant<MovieModelImpl>(builder: (BuildContext context, Widget child, MovieModelImpl model) {
                //   return ActorAndCreatorsSectionView(
                //     BEST_ACTOR_TITLE,
                //     BEST_ACTOR_SEE_MORE,
                //     actorsList: model.actorsList,
                //   );
                // },),
                // StreamBuilder(
                //   stream: homeBloc.mActorsListStreamController.stream,
                //   builder: (BuildContext context,
                //       AsyncSnapshot<List<ActorVO>> snapShot) {
                //     return ActorAndCreatorsSectionView(
                //       BEST_ACTOR_TITLE,
                //       BEST_ACTOR_SEE_MORE,
                //       actorsList: snapShot.data,
                //     );
                //   },
                // ),
                // Consumer<HomeBloc>(
                //   builder: (context, bloc, child) => ActorAndCreatorsSectionView(
                //     BEST_ACTOR_TITLE,
                //     BEST_ACTOR_SEE_MORE,
                //     actorsList: bloc.actors,
                //   ),
                // ),
                Selector<HomeBloc, List<ActorVO>>(
                  selector: (context, bloc) => bloc.actors,
                  builder: (context, actorsList, child) => ActorAndCreatorsSectionView(
                    BEST_ACTOR_TITLE,
                    BEST_ACTOR_SEE_MORE,
                    actorsList: actorsList,
                  ),
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailsScreen(BuildContext context, int? movieId) {
    if (movieId != null) {
      // modelImpl.getMovieDetails(movieId);
      // modelImpl.getMovieDetailsFromDatabase(movieId);
      // modelImpl.getCreditsByMovie(movieId);
      Navigator.push(
          context,
          MaterialPageRoute(
            //builder: (context) => MovieDetailsPage()));
              builder: (context) => MovieDetailsPage(
                movieId: movieId,
              )));
    }
  }
}

 /* @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //homeBloc.dispose();
    super.dispose();
  }*/


class BannerSectionView extends StatefulWidget {
  final List<MovieVO>? movieList;

  BannerSectionView({required this.movieList});

  @override
  _BannerSectionViewState createState() => _BannerSectionViewState();
}

double _position = 0;

class _BannerSectionViewState extends State<BannerSectionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4,
          child: PageView(
            onPageChanged: (page) {
              setState(() {
                _position = page.toDouble();
              });
            },
            children: widget.movieList
                    ?.map(
                      (movie) => BannerView(
                        movie: movie,
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        DotsIndicator(
          dotsCount: (widget.movieList?.length == 0) ? 1 : widget.movieList?.length ?? 1,
          position: _position,
          decorator: DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
            activeColor: PLAY_BUTTON_COLOR,
          ),
        ),
      ],
    );
  }
}

class ShowCasesSection extends StatelessWidget {
  final List<MovieVO>? topRatedMovies;

  ShowCasesSection({required this.topRatedMovies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child:
              TitleTextWithSeeMoreView(SHOW_CASES_TITLE, SHOW_CASES_SEE_MORE),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          height: SHOW_CASES_HEIGHT,
          child: ListView(
            padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
            scrollDirection: Axis.horizontal,
            children: topRatedMovies
                    ?.map((topRatedMovie) => ShowCaseView(
                          movie: topRatedMovie,
                        ))
                    .toList() ??
                [],
          ),
        ),
      ],
    );
  }
}

class CheckMovieShowTimesSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: EdgeInsets.all(MARGIN_LARGE),
      height: SHOWTIME_SECTION_HEIGHT,
      color: PRIMARY_COLOR,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MAIN_SCREEN_CHECK_MOVIE_SHOWTIMES,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              TextSeeMore(MAIN_SCREEN_SEE_MORE, textColor: PLAY_BUTTON_COLOR),
            ],
          ),
          Spacer(),
          Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: BANNER_PLAY_BUTTON_SIZE,
          ),
        ],
      ),
    );
  }
}

class GenreSectionView extends StatelessWidget {
  final List<GenreVO>? genreList;
  final List<MovieVO>? moviesByGenre;
  final Function(int?) onTapMovie;
  final Function(int?) onChooseGenre;

  GenreSectionView(
      {required this.genreList,
      required this.moviesByGenre,
      required this.onTapMovie,
      required this.onChooseGenre});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: genreList?.length ?? 0,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                      ?.map(
                        (genre) => Tab(
                          child: Text(genre.name ?? ""),
                        ),
                      )
                      .toList() ??
                  [],
              onTap: (index) {
                onChooseGenre(genreList?[index].id);
              },
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            bottom: MARGIN_LARGE,
          ),
          child: HorizontalMovieListView(
            onTapMovie: (movieId) => this.onTapMovie(movieId),
            movieLists: moviesByGenre,
            onListEndReached: () {
              HomeBloc homeBloc = Provider.of(context, listen: false);
              homeBloc.nowPlayingMovieListEndReached();
            },
          ),
        ),
      ],
    );
  }
}

/* @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> genreList = [
    "Action",
    "Adventure",
    "Horror",
    "Comedy",
    "Thriller",
    "Drama"
  ];

  */ /*MovieModel movieModel = MovieModelImpl();

  /// State Variables
  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? popularMovies;
  List<MovieVO>? topRatedMovies;
  List<MovieVO>? moviesByGenre;
  List<GenreVO>? genres;
  List<ActorVO>? actors;

  @override
  void initState() {
    /// NowPlayingMovies
    // movieModel.getNowPlayingMovies(1).then((movieList) {
    //   setState(() {
    //     nowPlayingMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    /// NowPlayingMovies Database
    movieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      setState(() {
        nowPlayingMovies = movieList;
      });
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// PopularMovies
    // movieModel.getPopularMovies(1).then((movieList) {
    //   setState(() {
    //     popularMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    /// PopularMovies Database
    movieModel.getPopularMoviesFromDatabase().listen((movieList) {
      setState(() {
        popularMovies = movieList;
      });
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// TopRatedMovies
    // movieModel.getTopRatedMovies(1).then((movieList) {
    //   setState(() {
    //     topRatedMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    /// TopRatedMovies Database
    movieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
      setState(() {
        topRatedMovies = movieList;
      });
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Genres
    movieModel.getGenres().then((genres) {
      setState(() {
        this.genres = genres;

        /// MoviesByGenre
        _getMoviesByGenre(genres?.first.id ?? 0);
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Genres Database
    movieModel.getGenresFromDatabase().then((genres) {
      setState(() {
        this.genres = genres;

        /// MoviesByGenre
        _getMoviesByGenre(genres?.first.id ?? 0);
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Actors
    movieModel.getActors(1).then((actors) {
      setState(() {
        this.actors = actors;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Actors Database
    movieModel.getAllActorsFromDatabase().then((actors) {
      setState(() {
        this.actors = actors;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    super.initState();
  }

  void _getMoviesByGenre(int genreId) {
    movieModel.getMoviesByGenre(genreId).then((moviesByGenre) {
      setState(() {
        this.moviesByGenre = moviesByGenre;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }*/ /*

}*/
