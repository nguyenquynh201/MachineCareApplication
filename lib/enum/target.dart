enum TargetMachine { frequent, maintenance }

extension TargetMachineExtension on TargetMachine {
  String get value {
    switch (this) {
      case TargetMachine.frequent:
        return "frequent";
      case TargetMachine.maintenance:
        return "maintenance";
    }
  }

  static TargetMachine? valueOf(String? objString) {
    switch (objString) {
      case "frequent":
        return TargetMachine.frequent;
      case "maintenance":
        return TargetMachine.maintenance;
      default:
        return TargetMachine.frequent;
    }
  }
}
