class ProfileModel {
  final String? id;
  final String? image;
  final String name;
  final String email;
  final String department;
  final String? bio;
  ProfileModel({
    this.id,
    this.image,
    required this.name,
    required this.email,
    required this.department,
    this.bio,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'name': name,
      'email': email,
      'department': department,
      'bio': bio,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] != null ? map['id'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      name: map['name'] as String,
      email: map['email'] as String,
      department: map['department'] as String,
      bio: map['bio'] != null ? map['bio'] as String : null,
    );
  }
}
