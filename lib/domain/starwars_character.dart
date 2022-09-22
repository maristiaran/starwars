class SWCharacter {
  final int id;
  final String name;
  final String gender;
  bool hasDetail = false;
  String? birthYear;
  String? eyeColor;
  String? hairColor;
  int? height;
  String? homeworld;
  int? mass;
  List<String>? starships;
  List<String>? vehicles;

  SWCharacter.overview({
    required this.id,
    required this.name,
    required this.gender,
  });

  SWCharacter loadDetails(
      {required String birthYear,
      required String eyeColor,
      required String hairColor,
      required int height,
      required String homeworld,
      required int mass,
      required List<String> starships,
      required List<String> vehicles}) {
    return this;
  }

  @override
  String toString() {
    return '$id) $name - $gender';
  }
}
