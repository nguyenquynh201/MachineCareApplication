enum StatusEnum { Cancel, Waiting, Coming, Done, Received }

extension StatusExtenstion on StatusEnum {
  String get value {
    switch (this) {
      case StatusEnum.Cancel:
        return "cancel";
      case StatusEnum.Waiting:
        return "waiting";
      case StatusEnum.Coming:
        return "coming";
      case StatusEnum.Done:
        return "done";
      case StatusEnum.Received:
        return "received";
    }
  }

  static StatusEnum valueOf(String? value) {
    switch (value) {
      case "cancel":
        return StatusEnum.Cancel;
      case "waiting":
        return StatusEnum.Waiting;
      case "done":
        return StatusEnum.Done;
      case "coming":
        return StatusEnum.Coming;
      case "received":
        return StatusEnum.Received;
      default:
        return StatusEnum.Waiting;
    }
  }
  static String statusValueOf(StatusEnum? status) {
    switch (status) {
      case StatusEnum.Cancel:
        return "cancel";
      case StatusEnum.Waiting:
        return "waiting";
      case StatusEnum.Coming:
        return "coming";
      case StatusEnum.Done:
        return "done";
      case StatusEnum.Received:
        return "received";
      default:
        return "waiting";
    }
  }
}
