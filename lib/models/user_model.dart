// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:cydeva_lua_application/models/favorite_model.dart';

class UserModel {
  String? id;
  String? phoneNumber;
  String? email;
  String? avatar;
  String? fullName;
  String? gender;
  String? address;
  String? dateOfBirth;
  String? userType;
  List<String>? favContent;
  String? introduction;
  String? coverImage;
  String? dateVerified;
  bool? isRegister;
  UserModel({
    this.id,
    this.phoneNumber,
    this.email,
    this.avatar,
    this.fullName,
    this.gender,
    this.address,
    this.dateOfBirth,
    this.userType,
    this.favContent,
    this.introduction,
    this.coverImage,
    this.dateVerified,
    this.isRegister,
  });

  UserModel copyWith({
    String? id,
    String? phoneNumber,
    String? email,
    String? avatar,
    String? fullName,
    String? gender,
    String? address,
    String? dateOfBirth,
    String? userType,
    List<String>? favContent,
    String? introduction,
    String? coverImage,
    String? dateVerified,
    bool? isRegister,
  }) {
    return UserModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      userType: userType ?? this.userType,
      favContent: favContent ?? this.favContent,
      introduction: introduction ?? this.introduction,
      coverImage: coverImage ?? this.coverImage,
      dateVerified: dateVerified ?? this.dateVerified,
      isRegister: isRegister ?? this.isRegister,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'phoneNumber': phoneNumber,
      'email': email,
      'avatar': avatar,
      'fullName': fullName,
      'gender': gender,
      'address': address,
      'dateOfBirth': dateOfBirth,
      'userType': userType,
      'favContent': favContent,
      'introduction': introduction,
      'coverImage': coverImage,
      'dateVerified': dateVerified,
      'isRegister': isRegister,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      phoneNumber:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      fullName: map['full_name'] != null ? map['full_name'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      dateOfBirth:
          map['date_of_birth'] != null ? map['date_of_birth'] as String : null,
      userType: map['user_type'] != null ? map['user_type'] as String : null,
      favContent: map['fav_content'] != null
          ? List<String>.from((map['fav_content']))
          : null,
      introduction:
          map['introduction'] != null ? map['introduction'] as String : null,
      coverImage:
          map['cover_image'] != null ? map['cover_image'] as String : null,
      dateVerified:
          map['date_verified'] != null ? map['date_verified'] as String : null,
      isRegister: map['is_register'] != null ? map['is_register'] as bool : null,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, phoneNumber: $phoneNumber, email: $email, avatar: $avatar, fullName: $fullName, gender: $gender, address: $address, dateOfBirth: $dateOfBirth, userType: $userType, favContent: $favContent, introduction: $introduction, coverImage: $coverImage, dateVerified: $dateVerified, isRegister: $isRegister)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.avatar == avatar &&
        other.fullName == fullName &&
        other.gender == gender &&
        other.address == address &&
        other.dateOfBirth == dateOfBirth &&
        other.userType == userType &&
        listEquals(other.favContent, favContent) &&
        other.introduction == introduction &&
        other.coverImage == coverImage &&
        other.dateVerified == dateVerified &&
        other.isRegister == isRegister;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        avatar.hashCode ^
        fullName.hashCode ^
        gender.hashCode ^
        address.hashCode ^
        dateOfBirth.hashCode ^
        userType.hashCode ^
        favContent.hashCode ^
        introduction.hashCode ^
        coverImage.hashCode ^
        dateVerified.hashCode ^
        isRegister.hashCode;
  }
}
