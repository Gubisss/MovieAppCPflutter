import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/review_model.dart';

const baseUrl = 'https://api.themoviedb.org/3/';
const key = '?api_key=$apiKey';

class ApiServices {
  Future<Result> getTopRatedMovies() async {
    var endPoint = 'movie/top_rated';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<Result> getNowPlayingMovies() async {
    var endPoint = 'movie/now_playing';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<Result> getUpcomingMovies() async {
    var endPoint = 'movie/upcoming';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load upcoming movies');
  }

  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    final endPoint = 'movie/$movieId';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load  movie details');
  }

  Future<Result> getMovieRecommendations(int movieId) async {
    final endPoint = 'movie/$movieId/recommendations';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load  movie details');
  }

  Future<Result> getSearchedMovie(String searchText) async {
    final endPoint = 'search/movie?query=$searchText';
    final url = '$baseUrl$endPoint';
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc'
    });
    if (response.statusCode == 200) {
      final movies = Result.fromJson(jsonDecode(response.body));
      return movies;
    }
    throw Exception('failed to load  search movie ');
  }

  Future<Result> getPopularMovies() async {
    const endPoint = 'movie/popular';
    const url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url), headers: {});
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<List<ReviewModel>> getMovieReviews(int movieId) async {
    final url = '$baseUrl/movie/$movieId/reviews?language=pt-BR&page=1';
    
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNmIzZDljZGFmMjFhYmZjM2Q3NmE5OGFlM2QzNDA0MyIsIm5iZiI6MTcyNjg2MDI0MS40MTg5NjIsInN1YiI6IjY2ZWRjOTA4YzIzNzI1OGU0YzI1YzNiYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.njLqPvIi8-LK7hjsNSwyWeIWpHPrT4A-sBsh3w_MhBY',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> reviewsJson = data['results'];
      return reviewsJson.map((review) => ReviewModel.fromJson(review)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Future<Result> getSimilarMovies(int movieId) async {
    final endPoint = 'movie/$movieId/similar';
    final url = '$baseUrl$endPoint$key&language=pt-BR';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao carregar filmes os similares');
    }
  }
}
