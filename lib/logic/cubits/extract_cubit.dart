import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../data/models/cocktail_model.dart';

part 'extract_state.dart';

class ExtractCubit extends Cubit<ExtractState> {
  ExtractCubit(CocktailModel cocktail) : super(ExtractInitialState()) {
    propertiesExtracting(cocktail);
  }

  void propertiesExtracting(CocktailModel cocktail) {
    emit(ExtractStartingState());
    final Map<String, dynamic> drink = cocktail.toJson()['drinks'][0];
    final ingredients = <String>[];
    final measures = <String, String>{};
    for (var i = 1; i <= 15; i++) {
      final ingredient = drink['strIngredient$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add('$ingredient');
        measures[ingredient] = drink['strMeasure$i'] ?? '';
      }
    }

    Map<String, String>? ingredientImages;
    ingredientImages = _fetchIngredientImages(drink);
    emit(ExtractEndState(ingredients, ingredientImages, measures));
  }

  Map<String, String> _fetchIngredientImages(Map<String, dynamic> cocktail) {
    final images = <String, String>{};
    for (var i = 1; i <= 15; i++) {
      final ingredient = cocktail['strIngredient$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        final imageSearchUrl =
            'https://www.thecocktaildb.com/images/ingredients/${Uri.encodeFull(ingredient)}-Medium.png';
        images[ingredient] = imageSearchUrl;
      }
    }
    return images;
  }
}
