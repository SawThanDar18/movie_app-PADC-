import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

List<MovieVO> getMockMoviesForTest() {
  return [
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
    MovieVO(
      false,
      "/x747ZvF0CcYYTTpPRCoUrxA2cYy.jpg",
      [
        28,
        12,
        878,
      ],
      406759,
      "en",
      "Moonfall",
      "A mysterious force knocks the moon from its orbit around Earth and sends it hurtling on a collision course with life as we know it.",
      4501.778,
      "/odVv1sqVs0KxBXiA8bhIBlPgalx.jpg",
      "2022-02-03",
      "Moonfall",
      false,
      6.4,
      495,
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
      false,
      true,
      false,
    ),
    MovieVO(
      false,
      "/egoyMDLqCxzjnSrWOz50uLlJWmD.jpg",
      [
        28,
        878,
        35,
        10751,
      ],
      675353,
      "en",
      "Sonic the Hedgehog 2",
      "After settling in Green Hills, Sonic is eager to prove he has what it takes to be a true hero. His test comes when Dr. Robotnik returns, this time with a new partner, Knuckles, in search for an emerald that has the power to destroy civilizations. Sonic teams up with his own sidekick, Tails, and together they embark on a globe-trotting journey to find the emerald before it falls into the wrong hands.",
      3032.171,
      "/1j6JtMRAhdO3RaXRtiWdPL5D3SW.jpg",
      "2022-03-30",
      "Sonic the Hedgehog 2",
      false,
      7.8,
      122,
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
      false,
      false,
      true,
    ),
  ];
}

List<ActorVO> getMockActors() {
  return [
    ActorVO(
      false,
      224513,
      [],
      137.568,
      1,
      "Acting",
      "Ana de Armas",
      "/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg",
      null,
      null,
      null,
      null,
      null,
    ),
    ActorVO(
      false,
      2958961,
      [],
      122.259,
      0,
      "Acting",
      "Ana Jalandoni",
      "/6kOWtxVxaPMzxJ1jamuSzzTIkY2.jpg",
      null,
      null,
      null,
      null,
      null,
    ),
    ActorVO(
      false,
      1136406,
      [],
      108.741,
      2,
      "Acting",
      "Tom Holland",
      "/bBRlrpJm9XkNSg0YT5LCaxqoFMX.jpg",
      null,
      null,
      null,
      null,
      null,
    ),
  ];
}

List<GenreVO> getMockGenres() {
  return [
    GenreVO(1, "Action"),
    GenreVO(2, "Adventure"),
    GenreVO(3, "Comedy"),
  ];
}

List<List<ActorVO>> getMockCredits() {
  return [
    [
      ActorVO(
        false,
        90633,
        [],
        56.593,
        1,
        "Acting",
        "Gal Gadot",
        "/plLfB60M5cJrnog8KvAKhI4UJuk.jpg",
        "Gal Gadot",
        0,
        "Diana Prince / Wonder Woman",
        "595686e4c3a368382e050da4",
        0,
      ),
      ActorVO(
        false,
        1368162,
        [],
        0.956,
        2,
        "Creator",
        "Gardner Fox",
        null,
        "Gardner Fox",
        15,
        null,
        "5fe6b96666565a003dd84f41",
        null,
      ),
      ActorVO(
        false,
        41091,
        [],
        19.27,
        1,
        "Acting",
        "Kristen Wiig",
        "/N517EQh7j4mNl3BStMmjMN6hId.jpg",
        "Kristen Wiig",
        12,
        "Barbara Minerva / Cheetah",
        "5a975236c3a36861510077f1",
        2,
      ),
    ]
  ];
}