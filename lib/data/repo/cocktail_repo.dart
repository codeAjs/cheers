import 'package:cheers/data/models/cocktail_model.dart';
import 'package:dio/dio.dart';
import 'api/api.dart';

class CocktailRepo {
  API api = API();

  Future<Response> fetchRandom() async {
    try {
      return await api.sendRequest.get('/random.php');
      // Map<String, dynamic> jsonData = response.data;
      // final cocktailMap = jsonData['drinks'] as List;
      // return cocktailMap.map((postMap) => CocktailModel.fromJson(postMap)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> searchCocktail(String name) async {
    try {
      return await api.sendRequest.get('/search.php?s=$name');
    } catch (_) {
      rethrow;
    }
  }
}