import 'package:pokex/model/pokemon_model.dart';

abstract class HomeState {}

class InitHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class ErrorHomeState extends HomeState {
  final String message;

  ErrorHomeState(this.message);
}

class ResponseHomeState extends HomeState {
  final PokemonModel pokemonModel;

  ResponseHomeState(this.pokemonModel);
}
