String _kMale = "male";
String _kFemale = "female";
String _kOther = "other";

enum Gender { male, female, other }

extension GenderExtension on Gender {
  String get value {
    switch (this) {
      case Gender.female:
        return "female";
      case Gender.male:
        return "male";
      case Gender.other:
        return "other";
    }
  }

  static Gender? valueOf(String? objString) {
    switch (objString) {
      case "male":
        return Gender.male;
      case "female":
        return Gender.female;
      case "other":
        return Gender.other;
      default:
        return Gender.male;
    }
  }

  static String genderValueOf(Gender? target) {
    switch (target) {
      case Gender.female:
        return Gender.female.value;
      case Gender.other:
        return Gender.other.value;
      case Gender.male:
      default:
        return Gender.male.value;
    }
  }
}
