import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/blocs/movie_details_bloc.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/widgets/actor_and_creators_section_view.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  MovieDetailsPage({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsBloc(movieId),
      child: Scaffold(
        body: Selector<MovieDetailsBloc, MovieVO>(
          selector: (context, bloc) => bloc.mMovie!,
          builder: (context, movie, child) => Container(
            color: HOME_SCREEN_BACKGROUND_COLOR,
            child: (movie != null) ?
            CustomScrollView(
              slivers: [
                MovieDetailsSliverAppBarView(
                      () => Navigator.pop(context),
                  movie: movie,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_2),
                      child: TrailerSection(
                        genreList: movie.getGenreListAsStringList(),
                        storyLine: movie.overview ?? "",
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    Selector<MovieDetailsBloc, List<ActorVO>>(
                      selector: (context, bloc) => bloc.castList ?? [],
                      builder: (context, actorList, child) => ActorAndCreatorsSectionView(
                        ACTORS_TITLE,
                        "",
                        seeMoreButtonVisibility: false,
                        actorsList: actorList,
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_2),
                      child: AboutFilmSectionView(
                        movieVO: movie,
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    Selector<MovieDetailsBloc, List<ActorVO>>(
                      selector: (context, bloc) => bloc.crewList ?? [],
                      builder: (context, crewList, child) => ActorAndCreatorsSectionView(
                        CREATORS_TITLE,
                        CREATORS_SEE_MORE,
                        actorsList: crewList,
                      ),
                    ),
                  ]),
                ),
              ],
            ) : Container(),
          ),
        ),
      ),
    );
  }

}

class AboutFilmSectionView extends StatelessWidget {
  final MovieVO? movieVO;

  AboutFilmSectionView({required this.movieVO});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("ABOUT FILM"),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          "Original Title:",
          movieVO?.title ?? "",
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          "Type:",
          movieVO?.getGenreListAsCommaSeparatedString() ?? "",
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          "Production:",
          movieVO?.getProductionCountriesAsCommaSeparatedString() ?? "",
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          "Premiere:",
          movieVO?.releaseDate ?? "",
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          "Description:",
          movieVO?.overview ?? "",
        ),
      ],
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {
  final String label;
  final String description;

  AboutFilmInfoView(this.label, this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            label,
            style: TextStyle(
              color: MOVIE_DETAILS_INFO_TEXT_COLOR,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: MARGIN_CARD_MEDIUM_2,
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {
  final List<String> genreList;
  final String storyLine;

  TrailerSection({required this.genreList, required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        StoryLineView(
          storyLine: this.storyLine,
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
          children: [
            MovieDetailsScreenButtonView(
              "PLAY TRAILER",
              PLAY_BUTTON_COLOR,
              Icon(
                Icons.play_circle_fill,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              width: MARGIN_CARD_MEDIUM_2,
            ),
            MovieDetailsScreenButtonView(
              "RATE MOVIE",
              HOME_SCREEN_BACKGROUND_COLOR,
              Icon(
                Icons.star,
                color: PLAY_BUTTON_COLOR,
              ),
              isGhostButton: true,
            ),
          ],
        ),
      ],
    );
  }
}

class MovieDetailsScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  MovieDetailsScreenButtonView(
      this.title, this.backgroundColor, this.buttonIcon,
      {this.isGhostButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      height: MARGIN_XX_LARGE,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          MARGIN_LARGE,
        ),
        border:
            (isGhostButton) ? Border.all(color: Colors.white, width: 2) : null,
      ),
      child: Center(
        child: Row(
          children: [
            buttonIcon,
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {
  final String storyLine;

  StoryLineView({required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          storyLine,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    required this.genreList,
  });

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          Icons.access_time,
          color: PLAY_BUTTON_COLOR,
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
        Text(
          "2hr 30min",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        ...genreList.map((genre) => GenreChipView(genre)).toList(),
        Icon(
          Icons.favorite_border,
          color: Colors.white,
        ),
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
          label: Text(
            genreText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
      ],
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  final Function onTapBack;
  final MovieVO? movie;

  MovieDetailsSliverAppBarView(this.onTapBack, {required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: false,
      expandedHeight: MOVIE_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: MovieDetailsAppBarImageView(
                imageUrl: movie?.posterPath ?? "",
              ),
            ),
            Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XX_LARGE,
                  left: MARGIN_MEDIUM_2,
                ),
                child: BackButtonView(() {
                  this.onTapBack();
                }),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XX_LARGE + MARGIN_MEDIUM,
                  right: MARGIN_MEDIUM_2,
                ),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                  bottom: MARGIN_LARGE,
                ),
                child: MovieDetailsAppBarInfoView(
                  movie: this.movie,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  final MovieVO? movie;

  MovieDetailsAppBarInfoView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            MovieDetailsYearView(
              year: movie?.releaseDate?.substring(0, 4) ?? "",
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingView(),
                    SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    TitleText("${movie?.voteCount} VOTES"),
                    SizedBox(
                      height: MARGIN_CARD_MEDIUM_2,
                    ),
                  ],
                ),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                Text(
                  movie?.voteAverage.toString() ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          movie?.title ?? "",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_2X,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  final String year;

  MovieDetailsYearView({required this.year});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XX_LARGE,
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
      ),
      child: Center(
        child: Text(
          year,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_X_LARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;

  BackButtonView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTapBack();
      },
      child: Container(
        width: MARGIN_XX_LARGE,
        height: MARGIN_XX_LARGE,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_X_LARGE,
        ),
      ),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  final String imageUrl;

  MovieDetailsAppBarImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '$IMAGE_BASE_URL$imageUrl',
      fit: BoxFit.cover,
    );
  }
}

/*/// Model
  MovieModel _movieModel = MovieModelImpl();

  /// State Variables
  MovieVO? movieDetails;
  List<ActorVO>? cast;
  List<ActorVO>? crew;

  final List<String> genreList = ["Action", "Adventure", "Thriller"];

  @override
  void initState() {

    /// MovieDetails
    _movieModel.getMovieDetails(widget.movieId)
    .then((movieDetails) {
      setState(() {
        this.movieDetails = movieDetails;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// MovieDetails Database
    _movieModel.getMovieDetailsFromDatabase(widget.movieId).then((movie) {
      setState(() {
        this.movieDetails = movie;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    _movieModel.getCreditsByMovie(widget.movieId)
    .then((castAndCrew) {
      setState(() {
        this.cast = castAndCrew.first;
        this.crew = castAndCrew[1];
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    super.initState();

  }*/

/*class MovieDetailsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<MovieModelImpl>(
        builder: (BuildContext context, Widget child, MovieModelImpl model) {
          return Container(
            color: HOME_SCREEN_BACKGROUND_COLOR,
            child: CustomScrollView(
              slivers: [
                MovieDetailsSliverAppBarView(
                      () => Navigator.pop(context),
                  movie: model.movieDetails,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                      child: TrailerSection(
                        genreList: model.movieDetails?.getGenreListAsStringList() ?? [],
                        storyLine: model.movieDetails?.overview ?? "",),
                    ),
                    SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    ActorAndCreatorsSectionView(
                      ACTORS_TITLE,
                      "",
                      seeMoreButtonVisibility: false,
                      actorsList: model.cast,
                    ),
                    SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                      child: AboutFilmSectionView(
                        movieVO: model.movieDetails,
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    ActorAndCreatorsSectionView(
                      CREATORS_TITLE,
                      CREATORS_SEE_MORE,
                      actorsList: model.crew,
                    ),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}*/

/*

class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  MovieDetailsPage({required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late MovieDetailsBloc _detailsBloc;

  @override
  void initState() {
    _detailsBloc = MovieDetailsBloc(widget.movieId);
    super.initState();
  }

  @override
  void dispose() {
    _detailsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream:
                _detailsBloc.movieStreamController.stream.asBroadcastStream(),
            builder: (BuildContext context, AsyncSnapshot<MovieVO> snapShot) {
              if (snapShot.hasData) {
                return Container(
                  color: HOME_SCREEN_BACKGROUND_COLOR,
                  child: CustomScrollView(
                    slivers: [
                      MovieDetailsSliverAppBarView(
                        () => Navigator.pop(context),
                        movie: snapShot.data,
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: MARGIN_MEDIUM_2),
                            child: TrailerSection(
                              genreList:
                                  snapShot.data?.getGenreListAsStringList() ??
                                      [],
                              storyLine: snapShot.data?.overview ?? "",
                            ),
                          ),
                          SizedBox(
                            height: MARGIN_LARGE,
                          ),
                          StreamBuilder(
                            stream: _detailsBloc.actorsStreamController.stream.asBroadcastStream(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ActorVO>> snapShot) {
                              if (snapShot.hasData && (snapShot.data?.isNotEmpty ?? false)) {
                                print("Snapshot has data..");
                                return ActorAndCreatorsSectionView(
                                  ACTORS_TITLE,
                                  "",
                                  seeMoreButtonVisibility: false,
                                  actorsList: snapShot.data,
                                );
                              } else {
                                print("Snapshot does not have data..");
                                return Container();
                              }
                            },
                          ),
                          SizedBox(
                            height: MARGIN_LARGE,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: MARGIN_MEDIUM_2),
                            child: AboutFilmSectionView(
                              movieVO: snapShot.data,
                            ),
                          ),
                          SizedBox(
                            height: MARGIN_LARGE,
                          ),
                          StreamBuilder(
                            stream: _detailsBloc.creatorsStreamController.stream.asBroadcastStream(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ActorVO>> snapShot) {
                              if (snapShot.hasData && (snapShot.data?.isNotEmpty ?? false)) {
                                print("Snapshot has data..");
                                return ActorAndCreatorsSectionView(
                                  CREATORS_TITLE,
                                  CREATORS_SEE_MORE,
                                  actorsList: snapShot.data,
                                );
                              } else {
                                print("Snapshot does not have data..");
                                return Container();
                              }
                            },
                          ),
                        ]),
                      ),
                    ],
                  ),
                );
              } else {
                print("Snapshot does not have data..");
                return Container();
              }
            },),);
  }
}
*/

/*class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  MovieDetailsPage({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsBloc(movieId),
      child: Scaffold(
        body: Consumer<MovieDetailsBloc> (
          builder: (context, bloc, child) => Container(
            color: HOME_SCREEN_BACKGROUND_COLOR,
            child: CustomScrollView(
              slivers: [
                MovieDetailsSliverAppBarView(
                      () => Navigator.pop(context),
                  movie: bloc.mMovie,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_2),
                      child: TrailerSection(
                        genreList:
                        bloc.mMovie?.getGenreListAsStringList() ?? [],
                        storyLine: bloc.mMovie?.overview ?? "",
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    (bloc.castList != null)
                        ? ActorAndCreatorsSectionView(
                      ACTORS_TITLE,
                      "",
                      seeMoreButtonVisibility: false,
                      actorsList: bloc.castList,
                    ) : Container(),
                    SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_2),
                      child: AboutFilmSectionView(
                        movieVO: bloc.mMovie,
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    (bloc.crewList != null)
                        ? ActorAndCreatorsSectionView(
                      CREATORS_TITLE,
                      CREATORS_SEE_MORE,
                      actorsList: bloc.crewList,
                    )
                        : Container(),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}*/
