class PracticeSetModel {
  PracticeSetModel({
    required this.no,
    required this.question,
    required this.mediaFile,
    required this.options,
    required this.isSubmit,
    required this.submit,
  });

  final int no;
  final String question;
  final String? mediaFile;
  final List<Submit> options;
  final bool isSubmit;
  final Submit? submit;

  PracticeSetModel copyWith({
    int? no,
    String? question,
    String? mediaFile,
    List<Submit>? options,
    bool? isSubmit,
    Submit? submit,
  }) {
    return PracticeSetModel(
      no: no ?? this.no,
      question: question ?? this.question,
      mediaFile: mediaFile ?? this.mediaFile,
      options: options ?? this.options,
      isSubmit: isSubmit ?? this.isSubmit,
      submit: submit ?? this.submit,
    );
  }

  factory PracticeSetModel.fromJson(Map<String, dynamic> json) {
    return PracticeSetModel(
      no: json["no"],
      question: json["question"],
      mediaFile: json["mediaFile"],
      options: json["options"] == null
          ? []
          : List<Submit>.from(json["options"]!.map((x) => Submit.fromJson(x))),
      isSubmit: json["isSubmit"],
      submit: json["submit"] == null ? null : Submit.fromJson(json["submit"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "no": no,
        "question": question,
        "mediaFile": mediaFile,
        "options": options.map((x) => x.toJson()).toList(),
        "isSubmit": isSubmit,
        "submit": submit?.toJson(),
      };

  /// ✅ Override the == operator to compare objects
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PracticeSetModel &&
          runtimeType == other.runtimeType &&
          no == other.no &&
          question == other.question &&
          mediaFile == other.mediaFile &&
          isSubmit == other.isSubmit &&
          submit == other.submit;

  /// ✅ Override hashCode for hash-based comparison
  @override
  int get hashCode =>
      no.hashCode ^
      question.hashCode ^
      mediaFile.hashCode ^
      options.hashCode ^
      isSubmit.hashCode ^
      submit.hashCode;

  @override
  String toString() {
    return "$no, $question, $mediaFile, $options, $isSubmit, $submit, ";
  }
}

class Submit {
  Submit({
    required this.sl,
    required this.qus,
    required this.ans,
  });

  final String sl;
  final String qus;
  final bool ans;

  Submit copyWith({
    String? sl,
    String? qus,
    bool? ans,
  }) {
    return Submit(
      sl: sl ?? this.sl,
      qus: qus ?? this.qus,
      ans: ans ?? this.ans,
    );
  }

  factory Submit.fromJson(Map<String, dynamic> json) {
    return Submit(
      sl: json["sl"],
      qus: json["qus"],
      ans: json["ans"],
    );
  }

  Map<String, dynamic> toJson() => {
        "sl": sl,
        "qus": qus,
        "ans": ans,
      };

  /// ✅ Override the == operator to compare objects
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Submit &&
          runtimeType == other.runtimeType &&
          sl == other.sl &&
          qus == other.qus &&
          ans == other.ans;

  /// ✅ Override hashCode
  @override
  int get hashCode => sl.hashCode ^ qus.hashCode ^ ans.hashCode;

  @override
  String toString() {
    return "$sl, $qus, $ans, ";
  }
}
