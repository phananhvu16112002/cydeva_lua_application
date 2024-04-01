// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:cydeva_lua_application/models/favorite_model.dart';
import 'package:cydeva_lua_application/models/user_model.dart';

class ResponseFavorite {
   int? statusCode;
   String? message;
   List<FavoriteCategory>? listFavoriteCategory;
  ResponseFavorite({
    this.statusCode,
    this.message,
    this.listFavoriteCategory,
  });

  // ResponseFavorite(
  //     {this.statusCode = 0, this.message = '', this.listFavoriteCategory});

  // factory ResponseFavorite.fromJson(Map<String, dynamic> json) {
  //   List<FavoriteCategory> categories = json['data']
  //       .map((category) => FavoriteCategory.fromJson(category))
  //       .toList();


  //   print('cate: $categories');
  //   return ResponseFavorite(
  //       statusCode: json['status_code'] ?? 0,
  //       message: json['message'] ?? '',
  //       listFavoriteCategory: categories);
  // }

  ResponseFavorite copyWith({
    int? statusCode,
    String? message,
    List<FavoriteCategory>? listFavoriteCategory,
  }) {
    return ResponseFavorite(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      listFavoriteCategory: listFavoriteCategory ?? this.listFavoriteCategory,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status_code': statusCode,
      'message': message,
      'data': listFavoriteCategory?.map((x) => x?.toJson()).toList(),
    };
  }

  factory ResponseFavorite.fromJson(Map<String, dynamic> map) {
    return ResponseFavorite(
      statusCode: map['status_code'] != null ? map['status_code'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      listFavoriteCategory: map['data'] != null ? 
      List<FavoriteCategory>.from((map['data']).map<FavoriteCategory?>((x) => FavoriteCategory.fromJson(x as Map<String,dynamic>),),) : null,
    );
  }


  @override
  String toString() => 'ResponseFavorite(statusCode: $statusCode, message: $message, listFavoriteCategory: $listFavoriteCategory)';

  @override
  bool operator ==(covariant ResponseFavorite other) {
    if (identical(this, other)) return true;
  
    return 
      other.statusCode == statusCode &&
      other.message == message &&
      listEquals(other.listFavoriteCategory, listFavoriteCategory);
  }

  @override
  int get hashCode => statusCode.hashCode ^ message.hashCode ^ listFavoriteCategory.hashCode;
}
