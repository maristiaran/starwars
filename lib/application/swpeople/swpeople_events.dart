import 'package:desafio_urbetrack/domain/starwars_character.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SWPeopleEvent {}

class GetNextSWPeopleEvent extends SWPeopleEvent {
  final int count;

  GetNextSWPeopleEvent({required this.count});
}

class EnterSWPeopleDetailsEvent extends SWPeopleEvent {
  final SWCharacter swCharacter;
  EnterSWPeopleDetailsEvent(this.swCharacter);
}

class ExitSWPeopleDetailsEvent extends SWPeopleEvent {
  ExitSWPeopleDetailsEvent();
}

class ShowSWPeopleMenuEvent extends SWPeopleEvent {
  ShowSWPeopleMenuEvent();
}

class SendReportEvent extends SWPeopleEvent {
  SendReportEvent();
}

class ReceiveErrorEvent extends SWPeopleEvent {
  final String message;
  ReceiveErrorEvent(this.message);
}
