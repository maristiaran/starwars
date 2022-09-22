import 'package:desafio_urbetrack/domain/starwars_character.dart';
import 'package:equatable/equatable.dart';

enum SWPeopleStatus { loading, loaded, error, details, menu }

class SWPeopleState extends Equatable {
  final SWPeopleStatus swpeopleStatus;
  final int currentSWPeopleIndex;
  final int inc;
  final bool isConnectionActive;
  final String? errorMessageIfAny;
  final SWCharacter? selectedSWCharacterIfAny;

  const SWPeopleState(
      {required this.swpeopleStatus,
      required this.currentSWPeopleIndex,
      required this.inc,
      required this.isConnectionActive,
      required this.errorMessageIfAny,
      required this.selectedSWCharacterIfAny});

  @override
  List<Object?> get props => [
        swpeopleStatus,
        currentSWPeopleIndex,
        inc,
        isConnectionActive,
        errorMessageIfAny,
        selectedSWCharacterIfAny
      ];
  const SWPeopleState.initialLoading({required int count})
      : swpeopleStatus = SWPeopleStatus.loading,
        currentSWPeopleIndex = -1,
        inc = count,
        isConnectionActive = false,
        errorMessageIfAny = null,
        selectedSWCharacterIfAny = null;

  SWPeopleState toLoading() {
    return SWPeopleState(
        swpeopleStatus: SWPeopleStatus.loading,
        currentSWPeopleIndex: currentSWPeopleIndex,
        inc: inc,
        isConnectionActive: isConnectionActive,
        errorMessageIfAny: errorMessageIfAny,
        selectedSWCharacterIfAny: selectedSWCharacterIfAny);
  }

  SWPeopleState toError({required String message}) {
    return SWPeopleState(
        swpeopleStatus: SWPeopleStatus.error,
        currentSWPeopleIndex: currentSWPeopleIndex,
        inc: inc,
        isConnectionActive: isConnectionActive,
        errorMessageIfAny: message,
        selectedSWCharacterIfAny: selectedSWCharacterIfAny);
  }

  SWPeopleState toEnterDetails({required SWCharacter swCharacter}) {
    return SWPeopleState(
        swpeopleStatus: SWPeopleStatus.details,
        currentSWPeopleIndex: currentSWPeopleIndex,
        inc: inc,
        isConnectionActive: isConnectionActive,
        errorMessageIfAny: errorMessageIfAny,
        selectedSWCharacterIfAny: swCharacter);
  }

  SWPeopleState toExitDetails() {
    return SWPeopleState(
        swpeopleStatus: SWPeopleStatus.loaded,
        currentSWPeopleIndex: currentSWPeopleIndex,
        inc: inc,
        isConnectionActive: isConnectionActive,
        errorMessageIfAny: errorMessageIfAny,
        selectedSWCharacterIfAny: null);
  }

  SWPeopleState toChangeLoadedSWPeople(
      {required int firstIndex, required int inc}) {
    return SWPeopleState(
        swpeopleStatus: SWPeopleStatus.loaded,
        currentSWPeopleIndex: firstIndex,
        inc: inc,
        isConnectionActive: isConnectionActive,
        errorMessageIfAny: errorMessageIfAny,
        selectedSWCharacterIfAny: null);
  }

  SWPeopleState toChangeIsConnectionActive({required bool isActive}) {
    return SWPeopleState(
        swpeopleStatus: swpeopleStatus,
        currentSWPeopleIndex: currentSWPeopleIndex,
        inc: inc,
        isConnectionActive: isConnectionActive,
        errorMessageIfAny: errorMessageIfAny,
        selectedSWCharacterIfAny: null);
  }

  SWPeopleState toEnterMenu() {
    return SWPeopleState(
        swpeopleStatus: SWPeopleStatus.menu,
        currentSWPeopleIndex: currentSWPeopleIndex,
        inc: inc,
        isConnectionActive: isConnectionActive,
        errorMessageIfAny: errorMessageIfAny,
        selectedSWCharacterIfAny: null);
  }

  SWPeopleState toExitMenu() {
    return SWPeopleState(
        swpeopleStatus: SWPeopleStatus.loaded,
        currentSWPeopleIndex: currentSWPeopleIndex,
        inc: inc,
        isConnectionActive: isConnectionActive,
        errorMessageIfAny: errorMessageIfAny,
        selectedSWCharacterIfAny: null);
  }
}
