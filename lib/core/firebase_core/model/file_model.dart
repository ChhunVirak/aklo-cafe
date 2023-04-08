import 'dart:convert';

class FirebaseStorageFileModel {
  final String folder;
  final String fileName;
  FirebaseStorageFileModel({
    required this.folder,
    required this.fileName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'folder': folder,
      'fileName': fileName,
    };
  }

  factory FirebaseStorageFileModel.fromMap(Map<String, dynamic> map) {
    return FirebaseStorageFileModel(
      folder: map['folder'] as String,
      fileName: map['fileName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FirebaseStorageFileModel.fromJson(String source) =>
      FirebaseStorageFileModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
