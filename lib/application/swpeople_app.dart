import 'package:desafio_startwars/application/swpeople/swpeople.dart';
import 'package:desafio_startwars/domain/startwars_repository.dart';
import 'package:desafio_startwars/repositories/starwars_repository_rest_adapter.dart';

class SWPeopleApp {
  static final SWPeopleApp _singleton = SWPeopleApp._internal();
  final SWPeopleBloc _swpeopleUseCase =
      SWPeopleBloc(StarwarsRepositoryRestAdapter() as StarwarsRepositoryPort);
  factory SWPeopleApp() {
    return _singleton;
  }
  SWPeopleApp._internal();

  Future initialize() async {
    // _swpeopleUseCase.add(GetNextSWPeopleEvent(count: 5));
  }

  SWPeopleBloc get swPeopleUseCase => _swpeopleUseCase;
}
