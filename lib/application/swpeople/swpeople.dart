import 'dart:async';

import 'package:desafio_urbetrack/application/swpeople/swpeople_events.dart';
import 'package:desafio_urbetrack/application/swpeople/swpeople_state.dart';
import 'package:desafio_urbetrack/domain/domain_utils.dart';
import 'package:desafio_urbetrack/domain/startwars_repository.dart';
import 'package:desafio_urbetrack/domain/starwars_character.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SWPeopleBloc extends Bloc<SWPeopleEvent, SWPeopleState> {
  final StarwarsRepositoryPort _starwarsRepository;
  bool initial = true;
  //TODO: Extraer el 82 del Json
  final CircularBuffer<SWCharacter> _allSWPeople =
      CircularBuffer<SWCharacter>(82);
  int? _nextElementsIncrementWaitingToShowIfAny;

  SWPeopleBloc(this._starwarsRepository)
      : super(const SWPeopleState.initialLoading(count: 0)) {
    _starwarsRepository.fetchSWPeopleOverviews().listen((response) {
      response.fold((error) => add(ReceiveErrorEvent(error.message())),
          (someSWPeople) {
        _allSWPeople.addElements(someSWPeople);
        // if (_nextElementsIncrementWaitingToShowIfAny != null) {
        //   if (_allSWPeople.canGetNextElements(
        //       count: _nextElementsIncrementWaitingToShowIfAny!)) {
        //     add(GetNextSWPeopleEvent(
        //         count: _nextElementsIncrementWaitingToShowIfAny!));
        //     _nextElementsIncrementWaitingToShowIfAny = null;
        //   }
        // }
      });
    });
    on<GetNextSWPeopleEvent>(_onGetNextSWPeople);
    on<EnterSWPeopleDetailsEvent>(_onEnterSWPeopleDetails);
    on<ExitSWPeopleDetailsEvent>(_onExitSWPeopleDetails);
    on<ReceiveErrorEvent>(_onReceiveError);
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
      Timer(const Duration(seconds: 1), () {
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

  _onReceiveError(ReceiveErrorEvent event, Emitter<SWPeopleState> emit) async {
    emit(state.toError(message: event.message));
  }
}
