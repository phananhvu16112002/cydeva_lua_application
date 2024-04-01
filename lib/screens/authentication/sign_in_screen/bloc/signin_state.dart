part of 'signin_bloc.dart';

enum BaseStatus { init, success, failed, loading }

class SigninState extends Equatable {
  final BaseStatus? status;
  final String? message;
  final UserDetail? userDetail;
  const SigninState(
      {this.status = BaseStatus.init, this.message = '', this.userDetail});

  @override
  // TODO: implement props
  List<Object?> get props => [status, message, userDetail];

  SigninState copyWith({
    BaseStatus? status = BaseStatus.init,
    String? message = '',
    UserDetail? userDetail,
  }) {
    // print('Copy With Success');
    // print('Status: ${status}');
    // print('Message: ${message}');
    // print('UserDetail: ${userDetail!.email}');

    return SigninState(
        status: status ?? this.status,
        message: message ?? this.message,
        userDetail: userDetail ?? this.userDetail);
  }
}
