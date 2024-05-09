import 'package:cheers/data/models/cocktail_model.dart';
import 'package:dio/dio.dart';
import 'api/api.dart';

class CocktailRepo {
  API api = API();

  Future<List<CocktailModel>> fetchPosts() async {
    try {
      Response response = await api.sendRequest.get('/random.php');
      Map<String, dynamic> jsonData = response.data;
      final cocktailMap = jsonData['drinks'] as List;
      return cocktailMap.map((postMap) => CocktailModel.fromJson(postMap)).toList();
    } catch (e) {
      rethrow;
    }
  }
}