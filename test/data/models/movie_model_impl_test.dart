import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

import '../../mock_data/mock_data.dart';
import '../../network/movie_data_agent_impl_mock.dart';
import '../../persistence/actor_dao_impl_mock.dart';
import '../../persistence/genre_dao_impl_mock.dart';
import '../../persistence/movie_dao_impl_mock.dart';

void main() {
  group("movie_model_impl", () {
    var movieModel = MovieModelImpl();

    setUp(() {
      movieModel.setDaosAndDataAgents(
        MovieDaoImplMock(),
        ActorDaoImplMock(),
        GenreDaoImplMock(),
        MovieDataAgentImplMock(),
      );
    });

    test(
        "Saving Now Playing Movies and Getting Now Playing Movies From Database",
            () {
          expect(
              movieModel.getNowPlayingMoviesFromDatabase(),
              emits(
                [
                  MovieVO(
                    false,
                    "/fOy2Jurz9k6RnJnMUMRDAgBwru2.jpg",
                    [
                      16,
                      10751,
                      35,
                      14,
                    ],
                    508947,
                    "en",
                    "Turning Red",
                    "Thirteen-year-old Mei is experiencing the awkwardness of being a teenager with a twist – when she gets too excited, she transforms into a giant red panda.",
                    5329.202,
                    "/qsdjk9oAKSQMWs0Vt5Pyfh6O4GZ.jpg",
                    "2022-03-01",
                    "Turning Red",
                    false,
                    7.5,
                    1433,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    true,
                    false,
                    false,
                  ),
                ],
              ));
        }
    );

    test(
        "Saving Popular Movies and Getting Popular Movies From Database",
            () {
          expect(
              movieModel.getNowPlayingMoviesFromDatabase(),
              emits(
                [
                  MovieVO(
                    false,
                    "/fOy2Jurz9k6RnJnMUMRDAgBwru2.jpg",
                    [
                      16,
                      10751,
                      35,
                      14,
                    ],
                    508947,
                    "en",
                    "Turning Red",
                    "Thirteen-year-old Mei is experiencing the awkwardness of being a teenager with a twist – when she gets too excited, she transforms into a giant red panda.",
                    5329.202,
                    "/qsdjk9oAKSQMWs0Vt5Pyfh6O4GZ.jpg",
                    "2022-03-01",
                    "Turning Red",
                    false,
                    7.5,
                    1433,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    true,
                    false,
                    false,
                  ),             ],
              ));
        }
    );

    test(
        "Saving Top Rated Movies and Getting Top Rated Movies From Database",
            () {
          expect(
              movieModel.getNowPlayingMoviesFromDatabase(),
              emits(
                [
                  MovieVO(
                    false,
                    "/fOy2Jurz9k6RnJnMUMRDAgBwru2.jpg",
                    [
                      16,
                      10751,
                      35,
                      14,
                    ],
                    508947,
                    "en",
                    "Turning Red",
                    "Thirteen-year-old Mei is experiencing the awkwardness of being a teenager with a twist – when she gets too excited, she transforms into a giant red panda.",
                    5329.202,
                    "/qsdjk9oAKSQMWs0Vt5Pyfh6O4GZ.jpg",
                    "2022-03-01",
                    "Turning Red",
                    false,
                    7.5,
                    1433,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    true,
                    false,
                    false,
                  ),
                ],
              ));
        }
    );

    test(
        "Get Genres Test",
            () {
          expect(
              movieModel.getGenres(),
              completion(
                equals(getMockGenres()),
              ));
        });

    test(
        "Get Actors Test",
            () {
          expect(
              movieModel.getActors(1),
              completion(
                equals(getMockActors()),
              ));
        });

    test(
        "Get Credits Test",
            () {
          expect(
              movieModel.getCreditsByMovie(1),
              completion(
                equals(getMockCredits()),
              ));
        });

    test(
        "Get Movie Details Test",
            () {
          expect(
              movieModel.getMovieDetails(1),
              completion(
                equals(getMockMoviesForTest().first),
              ));
        });

    test(
        "Get Genres from Database Test",
            () async {
          await movieModel.getGenres();
          expect(
              movieModel.getGenresFromDatabase(),
              emits(getMockGenres()));
        });

    test(
        "Get Actors from Database Test",
            () async {
          await movieModel.getActors(1);
          expect(
              movieModel.getAllActorsFromDatabase(),
              emits(getMockActors()));
        });

    test(
        "Get Movie Details from Database Test",
            () async {
          await movieModel.getMovieDetails(1);
          expect(
              movieModel.getMovieDetails(1),
              completion(
                equals(getMockMoviesForTest().first),
              ));
        });

  });
}