import 'package:http/http.dart' as http;
import 'package:picture_perfect/secret.dart';

class PictureDataProvider {
  Future<String> geetPictureDetails() async {
    try {
      final res = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/movie/157336?api_key=$api_key"));

      print(res.body);
      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
