import "dart:async";
import "package:http/http.dart" as http;
import "dart:convert";
import "package:yify_movies/models/movies_model.dart";

class MostRecentMovies {
  MostRecentMovies();

  Future<YifyMovies> getMostRecentMovies() async {
    var res = await http.get(
        "https://yts.lt/api/v2/list_movies.json?limit=50");
    var decodedJson = jsonDecode(res.body);

    YifyMovies movie = YifyMovies.fromJson(decodedJson);

    return movie;
  }
}
