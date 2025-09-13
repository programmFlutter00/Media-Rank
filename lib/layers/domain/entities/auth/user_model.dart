import 'package:equatable/equatable.dart';
import 'package:media_rank/layers/domain/entities/character_entity.dart';
import 'package:media_rank/layers/domain/entities/firebase/anime_firebase_entity.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;
  final String userName;
  final String? photoUrl;
  final DateTime createdAt;
  final List<NewsFirebaseEntity>? save;
  final List<CharacterEntity>? charcterSave;

  UserModel({
    required this.uid,
    required this.email,
    required this.userName,
    this.photoUrl,
    required this.createdAt,
    this.save,
    this.charcterSave,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
      'photo_url': photoUrl,
      'created_at': createdAt.toIso8601String(),
      'save': save,
      'character_save': charcterSave,
    };
  }

factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
    uid: json['uid'] as String? ?? "",
    email: json['email'] as String? ?? "",
    userName: json['userName'] as String? ?? "",
    photoUrl: json['photoUrl'] as String?,
    createdAt: (json['createdAt'] != null)
        ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
        : DateTime.now(),
    save: (json['save'] as List<dynamic>?)
            ?.map((v) => NewsFirebaseEntity.fromJson(v as Map<String, dynamic>))
            .toList() ??
        [],
    charcterSave: (json['character_save'] as List<dynamic>?)
            ?.map((v) => CharacterEntity.fromJson(v as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

  @override
  List<Object?> get props => [uid, email, userName, photoUrl, createdAt, save, charcterSave];
}
