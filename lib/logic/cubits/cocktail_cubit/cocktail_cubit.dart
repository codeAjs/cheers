import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cheers/data/repo/cocktail_repo.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../data/models/cocktail_model.dart';
part 'cocktail_state.dart';

class CocktailCubit extends Cubit<CocktailState> {
  CocktailCubit() : super(CocktailInitialState()) {
    fetchCocktail();
  }

  List<CocktailModel>? _cachedModel;
  List<CocktailModel>? get cachedModel => _cachedModel;

  CocktailRepo cocktailRepo = CocktailRepo();
  Future<void> fetchCocktail() async {
    try {
      emit(CocktailLoadingState());
      List<CocktailModel> models = [];
      for (int i = 0; i < 5; i++) {
        final response = await cocktailRepo.fetchRandom();
        if (response.statusCode == 200) {
          Map<String, dynamic> jsonData = response.data;
          final cocktail = CocktailModel.fromJson(jsonData);
          models.add(cocktail);
        }
      }

      emit(CocktailLoadedState(models));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        emit(const CocktailErrorState('Cannot fetch posts. Check your internet connection.'));
      }
    }
  }
}
