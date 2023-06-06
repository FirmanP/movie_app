import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/network.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTv = Tv(
    backdropPath: "/t2rAdgjSh0WYbXzdOB5zTDqzdCI.jpg",
    firstAirDate: "2022-11-02",
    genreIds: [18],
    id: 213713,
    name: "Faltu",
    originCountry: ["IN"],
    originalLanguage: "hi",
    originalName: "Faltu",
    overview:
        "What's in a name? Amidst the arid landscape of Rajasthan, a young woman with dreamy eyes struggles to prove her worth.",
    popularity: 2627.101,
    posterPath: "/lgyFuoXs7GvKJN0mNm7z7OMOFuZ.jpg",
    voteAverage: 4.5,
    voteCount: 25);

final testTvList = [testTv];

final testTvDetail = TvDetail(
    adult: false,
    backdropPath: "/gNPWlhUXhyWiHv9qxr57tvT0WwS.jpg",
    firstAirDate: "2014-10-07",
    genres: [Genre(id: 1, name: 'Action')],
    homepage: "http://www.cwtv.com/shows/the-flash/",
    id: 60735,
    inProduction: false,
    languages: ["en"],
    lastAirDate: "2023-05-24",
    name: "The Flash",
    networks: [
      Network(
          id: 71,
          logoPath: "/ge9hzeaU7nMtQ4PjkFlc68dGAJ9.png",
          name: "The CW",
          originCountry: "US")
    ],
    numberOfEpisodes: 184,
    numberOfSeasons: 9,
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "The Flash",
    overview:
        "After a particle accelerator causes a freak storm, CSI Investigator Barry Allen is struck by lightning and falls into a coma.",
    popularity: 974.777,
    posterPath: "/rg8N7x27Ef6PvlIiioLStf9ZaIO.jpg",
    seasons: [
      Season(
          airDate: "2015-10-06",
          episodeCount: 23,
          id: 66922,
          name: "Season 2",
          overview:
              "Following the dramatic events of season 1, Team Flash quickly turns their attention to a threat high above Central City.",
          posterPath: "/8xWZPVX1cv9V5YD1RPeLj9QZDE9.jpg",
          seasonNumber: 2)
    ],
    status: "Ended",
    tagline: "The fastest man alive.",
    type: "Scripted",
    voteAverage: 7.797,
    voteCount: 10436);

final testWatchlistTv = Tv.watchlist(
  id: 60735,
  name: 'The Flash',
  posterPath: '/rg8N7x27Ef6PvlIiioLStf9ZaIO.jpg',
  overview: 'After a particle accelerator causes a freak storm, CSI Investigator Barry Allen is struck by lightning and falls into a coma.',
);

final testTvTable = TvTable(
  id: 60735,
  name: 'The Flash',
  posterPath: '/rg8N7x27Ef6PvlIiioLStf9ZaIO.jpg',
  overview: 'After a particle accelerator causes a freak storm, CSI Investigator Barry Allen is struck by lightning and falls into a coma.',
);

final testTvMap = {
  'id': 60735,
  'overview': 'After a particle accelerator causes a freak storm, CSI Investigator Barry Allen is struck by lightning and falls into a coma.',
  'posterPath': '/rg8N7x27Ef6PvlIiioLStf9ZaIO.jpg',
  'name': 'The Flash',
};
