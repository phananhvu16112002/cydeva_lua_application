// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FavoriteCategory {
   String? title;
  FavoriteCategory({
    this.title,
  });

  FavoriteCategory copyWith({
    String? title,
  }) {
    return FavoriteCategory(
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
    };
  }

  factory FavoriteCategory.fromJson(Map<String, dynamic> map) {
    return FavoriteCategory(
      title: map['title'] != null ? map['title'] as String : null,
    );
  }


  @override
  String toString() => 'FavoriteCategory(title: $title)';

  @override
  bool operator ==(covariant FavoriteCategory other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title;
  }

  @override
  int get hashCode => title.hashCode;
}


