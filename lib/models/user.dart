import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  UserClass user;

  User({
    required this.user,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class UserClass {
  String uid;
  String email;
  String guardianName;
  String relationWith;
  String childAge;
  String childGrade;
  String photoUrl;
  String displayName;
  String phoneNumber;
  String height;
  String weight;
  String gender;
  bool info;

  UserClass({
    required this.uid,
    required this.email,
    required this.guardianName,
    required this.relationWith,
    required this.childAge,
    required this.childGrade,
    required this.photoUrl,
    required this.displayName,
    required this.phoneNumber,
    required this.height,
    required this.weight,
    required this.gender,
    required this.info,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        uid: json["uid"],
        email: json["email"],
        guardianName: json["guardianName"],
        relationWith: json["relationWith"],
        childAge: json["childAge"],
        childGrade: json["childGrade"],
        photoUrl: json["photoURL"],
        displayName: json["displayName"],
        phoneNumber: json["phoneNumber"],
        height: json["height"],
        weight: json["weight"],
        gender: json["gender"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "guardianName": guardianName,
        "relationWith": relationWith,
        "childAge": childAge,
        "childGrade": childGrade,
        "photoURL": photoUrl,
        "displayName": displayName,
        "phoneNumber": phoneNumber,
        "height": height,
        "weight": weight,
        "gender": gender,
        "info": info
      };
}
