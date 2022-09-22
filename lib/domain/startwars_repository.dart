import 'package:desafio_urbetrack/domain/errors.dart';
import 'package:desafio_urbetrack/domain/starwars_character.dart';
import 'package:either_dart/either.dart';

abstract class StarwarsRepositoryPort {
  Stream<Either<SWPeopleError, List<SWCharacter>>> fetchSWPeopleOverviews();
  Future<Either<SWPeopleError, SWCharacter>> fetchSWPeopleDetails(
      {required SWCharacter swCharacter});
}
