part of 'cocktail_cubit.dart';

@immutable
sealed class CocktailState extends Equatable {
  const CocktailState();

  @override
  List<Object?> get props => [];
}

final class CocktailInitialState extends CocktailState {}

final class CocktailLoadingState extends CocktailState {}

final class CocktailLoadedState extends CocktailState {
  final List<CocktailModel> cocktails;
  const CocktailLoadedState(this.cocktails);

  @override
  List<Object?> get props => [cocktails];
}

final class CocktailErrorState extends CocktailState {
  final String e;
  const CocktailErrorState(this.e);

  @override
  List<Object?> get props => [e];
}
