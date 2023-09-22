import 'dart:convert';

Questionnaire questionnaireFromJson(String str) =>
    Questionnaire.fromJson(json.decode(str));

String questionnaireToJson(Questionnaire data) => json.encode(data.toJson());

class Questionnaire {
  List<Question> questions;

  Questionnaire({
    required this.questions,
  });

  factory Questionnaire.fromJson(Map<String, dynamic> json) => Questionnaire(
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  String q;
  List<String> options;
  String ans;

  Question({
    required this.q,
    required this.options,
    required this.ans,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        q: json["q"],
        options: List<String>.from(json["options"].map((x) => x)),
        ans: json["ans"],
      );

  Map<String, dynamic> toJson() => {
        "q": q,
        "options": List<dynamic>.from(options.map((x) => x)),
        "ans": ans,
      };
}
