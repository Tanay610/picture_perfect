
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:picture_perfect/models/cast_list.dart';
import 'package:picture_perfect/models/genre_model.dart';
import 'package:picture_perfect/models/person_model.dart';
import 'package:picture_perfect/models/picture_image.dart';
import 'package:picture_perfect/models/picture_model.dart';
import 'package:picture_perfect/models/preview_model.dart';
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
      final res = await _dio.get("https://api.themoviedb.org/3/discover/movie?api_key=83a4d7205f356464792d3dd3bcf5735f&with_genres=$genre_id");

      var movies = res.data['results'] as List;
      List<PictureModel>  movieList2 = movies.map((m) => PictureModel.fromMap(m)).toList();

    return movieList2;
    } catch (e, stacktrace) {
      print(e);
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


  Future<List<Person>> getTrendingPerson()async{
  try {
    const String url = "https://api.themoviedb.org/3/trending/person/week?api_key=83a4d7205f356464792d3dd3bcf5735f";
    final response = await _dio.get(url);
    var persons = response.data['results'] as List;
    List<Person> personList = persons.map((e) => Person.fromMap(e)).toList();
    return personList;
  } catch (e) {
    throw Exception(e.toString());
    
  }
}


  Future <MovieDetails> getMovieDetails(int movieId)async{
    try {
      final response = await _dio.get("https://api.themoviedb.org/3/movie/$movieId?api_key=83a4d7205f356464792d3dd3bcf5735f&language=en-US&append_to_response=videos");
      MovieDetails movieDetails = MovieDetails.fromMap(response.data);

      movieDetails.castList = await getcastList(movieId);

      return movieDetails;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future <PictureImage> getMovieImages(int movieId)async{
    try {
      final response = await _dio.get("https://api.themoviedb.org/3/movie/${movieId}/images?api_key=83a4d7205f356464792d3dd3bcf5735f");
      PictureImage movieImages = PictureImage.fromMap(response.data);

      return movieImages;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Cast>> getcastList(int movieId)async{
    try {
      final response = await _dio.get("https://api.themoviedb.org/3/movie/${movieId}/credits?api_key=83a4d7205f356464792d3dd3bcf5735f");
      var list = response.data['cast'] as List;
      List<Cast> castList = list.map((e) => Cast.fromMap(e)).toList();

      return castList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Future<List<VideoDetails>> getYoutubeID(int movieId)async{
  //   try {
  //     final response = await _dio.get("https://api.themoviedb.org/3/movie/${movieId}/videos?api_key=83a4d7205f356464792d3dd3bcf5735f&language=en-US");
  //     var youtubeVideo = response.data['results'] as List;

  //     List<VideoDetails> = youtubeVideo.map((e) => VideoDetails.fromMap(e)).toList();
  //   } catch (e) {
      
  //   }
  // }
}






// baseUrl/movie/157336?api_key=$api_key