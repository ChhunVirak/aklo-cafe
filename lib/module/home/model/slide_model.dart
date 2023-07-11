// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class SlideModel {
  final String? id;
  final String? image;
  final Timestamp uploadedDate;
  SlideModel({
    this.id,
    required this.image,
    required this.uploadedDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'uploadedDate': uploadedDate,
    };
  }

  factory SlideModel.fromMap(Map<String, dynamic> map) {
    return SlideModel(
      id: map['id'] != null ? map['id'] as String : null,
      image: map['image'] as String,
      uploadedDate: map['uploadedDate'] as Timestamp,
    );
  }
}
