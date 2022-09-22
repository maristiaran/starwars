import 'package:desafio_urbetrack/application/swpeople/swpeople.dart';
// import 'package:desafio_urbetrack/application/swpeople/swpeople_events.dart';
import 'package:desafio_urbetrack/repositories/starwars_repository_rest_adapter.dart';

class SWPeopleApp {
  static final SWPeopleApp _singleton = SWPeopleApp._internal();
  final SWPeopleBloc _swpeopleUseCase =
      SWPeopleBloc(StarwarsRepositoryRestAdapter());
  factory SWPeopleApp() {
    return _singleton;
  }
  SWPeopleApp._internal();

  Future initialize() async {
    // _swpeopleUseCase.add(GetNextSWPeopleEvent(count: 5));
  }

  SWPeopleBloc get swPeopleUseCase => _swpeopleUseCase;
}
