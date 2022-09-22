enum SWPeopleErrors { networkConnection, noMoreSWPeople }

class SWPeopleError implements Exception {
  final SWPeopleErrors errorType;

  SWPeopleError(this.errorType);

  String message() {
    switch (errorType) {
      case SWPeopleErrors.networkConnection:
        return "Error de conección";
      case SWPeopleErrors.noMoreSWPeople:
        return "No hay más personajes";
      default:
        return "";
    }
  }
}
