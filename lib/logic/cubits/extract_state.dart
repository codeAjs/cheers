part of 'extract_cubit.dart';

@immutable
sealed class ExtractState extends Equatable {
  const ExtractState();

  @override
  List<Object?> get props => [];
}

final class ExtractInitialState extends ExtractState {}

final class ExtractStartingState extends ExtractState {}

final class ExtractEndState extends ExtractState {
  final List<String>? ingredients;
  final Map<String, String>? measures;
  final Map<String, String>? ingredientImages;
  const ExtractEndState(this.ingredients, this.ingredientImages, this.measures );


  @override
  List<Object?> get props => [ingredients, measures, ingredientImages];
}

final class ExtractErrorState extends ExtractState {
  final String e;
  const ExtractErrorState(this.e);

  @override
  List<Object?> get props => [e];
}
