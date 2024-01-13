import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:picture_perfect/models/genre_model.dart';
import 'package:picture_perfect/models/picture_model.dart';
import 'package:picture_perfect/secret.dart';

class PictureDataProvider {
  final Dio _dio = Dio();

  final String baseUrl = "https://api.themoviedb.org/3";

  Future<List<PictureModel>> getPicturePlayingDetails() async {
    try {
      final res = await _dio.get("https://api.themoviedb.org/3/movie/popular?api_key=83a4d7205f356464792d3dd3bcf5735f");

      var movies = res.data['results'] as List;
      List<PictureModel>  movieList = movies.map((m) => PictureModel.fromMap(m)).toList();

    return movieList;
    } catch (e, stacktrace) {
      throw '$e with $stacktrace';
    }
  }

  Future<List<PictureModel>> getMovieByGenres(int genre_id) async {
    try {
      final res = await _dio.get("https://api.themoviedb.org/3/discover/movie?api_key=$api_key&with_genres=$genre_id");

      var movies = res.data['results'] as List;
      List<PictureModel>  movieList = movies.map((m) => PictureModel.fromMap(m)).toList();

    return movieList;
    } catch (e, stacktrace) {
      throw '$e with $stacktrace';
    }
  }



  Future<List<Genre>> getGenreList()async{
    try {
      final res = await _dio.get('https://api.themoviedb.org/3/genre/movie/list?api_key=83a4d7205f356464792d3dd3bcf5735f');
      var genres = res.data['genres'] as List;
      List<Genre> genreList = genres.map((e) => Genre.fromMap(e)).toList();

      return genreList;      
    } catch (e, stacktrace) {
      print(e);
      throw '$e with $stacktrace';
    }
  }
}



// baseUrl/movie/157336?api_key=$api_key