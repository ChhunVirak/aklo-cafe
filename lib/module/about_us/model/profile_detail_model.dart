import 'dart:convert';

class ProfileModel {
  final String name;
  final String email;
  final String department;
  final String? bio;
  ProfileModel({
    required this.name,
    required this.email,
    required this.department,
    this.bio,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'department': department,
      'bio': bio,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      name: map['name'] as String,
      email: map['email'] as String,
      department: map['department'] as String,
      bio: map['bio'] != null ? map['bio'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
