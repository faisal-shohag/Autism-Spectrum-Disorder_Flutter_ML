import 'dart:convert';

ChildInfo infoFromJson(String str) => ChildInfo.fromJson(json.decode(str));

String infoToJson(ChildInfo data) => json.encode(data.toJson());

class ChildInfo {
  Info info;

  ChildInfo({
    required this.info,
  });

  factory ChildInfo.fromJson(Map<String, dynamic> json) => ChildInfo(
        info: Info.fromJson(json["info"]),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
      };
}

class Info {
  String name;
  String dob;
  String aoa;
  String gender;
  String school;
  String grade;
  String home;
  Parents parents;
  String parentsEmail;
  List<String> currentConcerns;

  Info({
    required this.name,
    required this.dob,
    required this.aoa,
    required this.gender,
    required this.school,
    required this.grade,
    required this.home,
    required this.parents,
    required this.parentsEmail,
    required this.currentConcerns,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        name: json["name"],
        dob: json["dob"],
        aoa: json["aoa"],
        gender: json["gender"],
        school: json["school"],
        grade: json["grade"],
        home: json["home"],
        parents: Parents.fromJson(json["parents"]),
        parentsEmail: json["parentsEmail"],
        currentConcerns:
            List<String>.from(json["currentConcerns"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dob": dob,
        "aoa": aoa,
        "gender": gender,
        "school": school,
        "grade": grade,
        "home": home,
        "parents": parents.toJson(),
        "parentsEmail": parentsEmail,
        "currentConcerns": List<dynamic>.from(currentConcerns.map((x) => x)),
      };
}

class Parents {
  String father;
  String mother;

  Parents({
    required this.father,
    required this.mother,
  });

  factory Parents.fromJson(Map<String, dynamic> json) => Parents(
        father: json["father"],
        mother: json["mother"],
      );

  Map<String, dynamic> toJson() => {
        "father": father,
        "mother": mother,
      };
}
