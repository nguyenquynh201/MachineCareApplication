String _kMale = "male";
String _kFemale = "female";
String _kOther = "other";

enum Gender {
  male,
  female,
}

extension GenderExtension on Gender {
  String get value {
    switch (this) {
      case Gender.female:
        return "female";
      case Gender.male:
        return "male";
    }
  }

  static Gender? valueOf(String? objString) {
    switch (objString) {
      case "male":
        return Gender.male;
      case "female":
        return Gender.female;
      default:
        return Gender.male;
    }
  }
  static String genderValueOf(Gender? target) {
    switch (target) {
      case Gender.female:
        return Gender.female.value;
      case Gender.male:
      default:
        return Gender.male.value;
    }
  }
}