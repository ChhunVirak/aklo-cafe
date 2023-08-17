// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String? id;
  final String? email;
  final String? username;
  final String? role;
  bool? addProduct;
  bool? updateProduct;
  bool? deleteProduct;
  bool? addCategory;
  bool? updateCategory;
  bool? deleteCategory;
  bool? allowSeeUser;
  UserModel({
    this.id,
    this.email,
    this.username,
    this.role,
    this.addProduct,
    this.updateProduct,
    this.deleteProduct,
    this.addCategory,
    this.updateCategory,
    this.deleteCategory,
    this.allowSeeUser,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': username,
      'role': role,
      'addProduct': addProduct,
      'updateProduct': updateProduct,
      'deleteProduct': deleteProduct,
      'addCategory': addCategory,
      'updateCategory': updateCategory,
      'deleteCategory': deleteCategory,
      'allowSeeUser': allowSeeUser,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      addProduct: map['addProduct'] != null ? map['addProduct'] as bool : null,
      updateProduct:
          map['updateProduct'] != null ? map['updateProduct'] as bool : null,
      deleteProduct:
          map['deleteProduct'] != null ? map['deleteProduct'] as bool : null,
      addCategory:
          map['addCategory'] != null ? map['addCategory'] as bool : null,
      updateCategory:
          map['updateCategory'] != null ? map['updateCategory'] as bool : null,
      deleteCategory:
          map['deleteCategory'] != null ? map['deleteCategory'] as bool : null,
      allowSeeUser:
          map['allowSeeUser'] != null ? map['allowSeeUser'] as bool : null,
    );
  }

  bool get isAdmin => role?.toLowerCase() == 'admin';
}
