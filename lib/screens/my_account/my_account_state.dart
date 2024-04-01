part of 'my_account_bloc.dart';

enum AccountStatus { init, success, failed, loading }

class MyAccountState extends Equatable {
  final AccountStatus? status;
  final String? message;
  final UserModel? userModel;
  const MyAccountState(
      {this.status = AccountStatus.init, this.message = '', this.userModel});

  @override
  List<Object?> get props => [status, message, userModel];

  MyAccountState copyWith({
    AccountStatus? status = AccountStatus.init,
    String? message = '',
    UserModel? userModel,
  }) {
    return MyAccountState(
        status: status ?? this.status,
        message: message ?? this.message,
        userModel: userModel ?? this.userModel);
  }
}

