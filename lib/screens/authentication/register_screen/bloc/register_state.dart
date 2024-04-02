part of 'register_bloc.dart';

enum BasesStatus { init, success, failed, loading, failedSubmitted }

class RegisterState extends Equatable {
  final BasesStatus? status;
  final String? message;
  final UserModel? userModel;
  const RegisterState(
      {this.status = BasesStatus.init, this.message = '', this.userModel});

  @override
  List<Object?> get props => [status, message, userModel];

  RegisterState copyWith({
    BasesStatus? status = BasesStatus.init,
    String? message = '',
    UserModel? userModel,
  }) {

    return RegisterState(
        status: status ?? this.status,
        message: message ?? this.message,
        userModel: userModel ?? this.userModel);
  }
}

class RegisterInitial extends RegisterState {}
