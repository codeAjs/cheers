part of 'search_cubit.dart';

@immutable
sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}



final class SearchInitialState extends SearchState {}

final class SearchLoadingState extends SearchState {}

final class SearchLoadedState extends SearchState {
  final CocktailModel? cocktails;
  const SearchLoadedState(this.cocktails);

  @override
  List<Object?> get props => [cocktails];

}

final class SearchErrorState extends SearchState {
  final String e;
  const SearchErrorState(this.e);

  @override
  List<Object?> get props => [e];
}
