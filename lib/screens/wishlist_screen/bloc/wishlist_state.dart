part of 'wishlist_bloc.dart';

enum WishlistStatus { init, success, failed, loading, submittedSuccess }

class WishlistState extends Equatable {
  final WishlistStatus? status;
  final String? message;
  List<FavoriteCategory>? listData;
  List<FavoriteCategory>? listSelectedData;
  WishlistState(
      {this.status = WishlistStatus.init,
      this.message = '',
      this.listData = const [],
      this.listSelectedData = const []});

  @override
  List<Object?> get props => [status, message, listData, listSelectedData];

  WishlistState copyWith({
    WishlistStatus? status = WishlistStatus.init,
    String? message = '',
    List<FavoriteCategory>? listData,
    List<FavoriteCategory>? listSelectedData,
  }) {
    return WishlistState(
        status: status ?? this.status,
        message: message ?? this.message,
        listData: listData ?? this.listData,
        listSelectedData: listSelectedData ?? this.listSelectedData);
  }
}
