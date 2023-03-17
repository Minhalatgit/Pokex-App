import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokex/home/cubit/home_state.dart';
import 'package:pokex/model/pokemon_model.dart';
import 'package:pokex/repository/home_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(InitHomeState());

  Future<void> getPokex() async {
    emit(LoadingHomeState());
    try {
      PokemonModel response = await _homeRepository.getPokex();
      emit(ResponseHomeState(response));
    } catch (e) {
      emit(ErrorHomeState(e.toString()));
    }
  }
}
