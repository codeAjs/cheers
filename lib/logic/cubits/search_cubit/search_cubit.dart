import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/models/cocktail_model.dart';
import '../../../data/repo/cocktail_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  // Cached variable for no internet connection
  CocktailModel? _cachedSearch;
  CocktailModel? get cachedSearch => _cachedSearch;
  CocktailRepo cocktailRepo = CocktailRepo();

  void searchSingleCocktail(String name) async {
    try {
      emit(SearchLoadingState());
     //List<CocktailModel>? cocktails;
      CocktailModel? cocktail;
      final response = await cocktailRepo.searchCocktail(name);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        if (data['drinks'] != null)  {
          final List<dynamic> drinks = data['drinks'];
          //log('dynamic: $drinks');
          //cocktails = drinks.map((drink) => CocktailModel.fromJson(drink)).toList();

          //log('cocktails names: ${cocktails[0].drinks?[0].strDrink}');

          cocktail = CocktailModel.fromJson(data);
          log('cocktails length: ${cocktail.drinks?.length}');

          // for (var drink in drinks) {
          //   final cocktail = CocktailModel.fromJson(drink);
          //   log('cocktail: ${cocktail.drinks?[0]}');
          //   cocktails.add(cocktail);
          // }

          _cachedSearch = cocktail;
        }

        emit(SearchLoadedState(cocktail));
      }
    } on DioException catch (e) {
      emit(SearchErrorState(e.message.toString()));
    }
  }
}
