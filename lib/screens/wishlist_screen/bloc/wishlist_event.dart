part of 'wishlist_bloc.dart';

class WishlistEvent {}

class ListFavoriteInitital extends WishlistEvent {
  List<FavoriteCategory>? listData;
  ListFavoriteInitital({this.listData});
}

class ListFavoriteChanged extends WishlistEvent {
  FavoriteCategory? listData;
  ListFavoriteChanged({this.listData});
}

class SubmitFavorite extends WishlistEvent {
  List<FavoriteCategory>? listData;
  SubmitFavorite({this.listData});
}
