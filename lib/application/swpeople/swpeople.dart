import 'dart:async';

import 'package:desafio_startwars/application/swpeople/swpeople_events.dart';
import 'package:desafio_startwars/application/swpeople/swpeople_state.dart';
import 'package:desafio_startwars/domain/domain_utils.dart';
import 'package:desafio_startwars/domain/startwars_repository.dart';
import 'package:desafio_startwars/domain/starwars_character.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SWPeopleBloc extends Bloc<SWPeopleEvent, SWPeopleState> {
  final StarwarsRepositoryPort _starwarsRepository;
  bool initial = true;
  //TODO: Extraer el 82 del Repositorio
  final CircularBuffer<SWCharacter> _allSWPeople =
      CircularBuffer<SWCharacter>(82);

  SWPeopleBloc(this._starwarsRepository)
      : super(const SWPeopleState.initialLoading(count: 0)) {
    _starwarsRepository.fetchSWPeopleOverviews().listen((response) {
      response.fold((error) => add(ReceiveErrorEvent(error.message())),
          (someSWPeople) {
        _allSWPeople.addElements(someSWPeople);
      });
    });
    on<GetNextSWPeopleEvent>(_onGetNextSWPeople);
    on<EnterSWPeopleDetailsEvent>(_onEnterSWPeopleDetails);
    on<ExitSWPeopleDetailsEvent>(_onExitSWPeopleDetails);
    on<ReceiveErrorEvent>(_onReceiveError);
    on<EnterSWPeopleMenuEvent>(_onEnterMenu);
    on<ExitSWPeopleMenuEvent>(_onExitMenu);

    add(GetNextSWPeopleEvent(count: 5));
  }
  CircularBuffer<SWCharacter> get allSWPeople => _allSWPeople;

  _onGetNextSWPeople(
      GetNextSWPeopleEvent event, Emitter<SWPeopleState> emit) async {
    if (_allSWPeople.canGetNextElements(count: event.count)) {
      if (initial) {
        initial = false;
        emit(state.toChangeLoadedSWPeople(
            firstIndex: _allSWPeople.currentIndex, inc: event.count));
      } else {
        _allSWPeople.updateCurrentIndex(count: event.count);
        emit(state.toChangeLoadedSWPeople(
            firstIndex: _allSWPeople.currentIndex, inc: event.count));
      }
    } else {
      Timer(const Duration(milliseconds: 500), () {
        add(GetNextSWPeopleEvent(count: 5));
      });

      emit(state.toLoading());
    }
  }

  _onEnterSWPeopleDetails(
      EnterSWPeopleDetailsEvent event, Emitter<SWPeopleState> emit) async {
    (await _starwarsRepository.fetchSWPeopleDetails(
            swCharacter: event.swCharacter))
        .fold((error) => emit(state.toError(message: error.message())),
            (swCharacter) {
      emit(state.toEnterDetails(swCharacter: event.swCharacter));
    });
  }

  _onExitSWPeopleDetails(
      ExitSWPeopleDetailsEvent event, Emitter<SWPeopleState> emit) async {
    emit(state.toExitDetails());
  }

  _onEnterMenu(
      EnterSWPeopleMenuEvent event, Emitter<SWPeopleState> emit) async {
    emit(state.toEnterMenu());
  }

  _onExitMenu(ExitSWPeopleMenuEvent event, Emitter<SWPeopleState> emit) async {
    emit(state.toExitMenu());
  }

  _onReceiveError(ReceiveErrorEvent event, Emitter<SWPeopleState> emit) async {
    emit(state.toError(message: event.message));
  }
}
