// part of 'test_screen_bloc.dart';

// enum BaseStatus { init, success, failed, loading }

// class TestScreenState extends Equatable {
//   final BaseStatus? status;
//   final String? message;
//   final UserModel? userModel;
//   const TestScreenState(
//       {this.status = BaseStatus.init, this.message = '', this.userModel});

//   @override
//   List<Object?> get props => [status, message, userModel];

//   TestScreenState copyWith({
//     BaseStatus? status = BaseStatus.init,
//     String? message = '',
//     UserModel? userModel,
//   }) {
//     // print('Copy With Success');
//     // print('Status: ${status}');
//     // print('Message: ${message}');
//     // print('UserDetail: ${userDetail!.email}');

//     return TestScreenState(
//         status: status ?? this.status,
//         message: message ?? this.message,
//         userModel: userModel ?? this.userModel);
//   }
// }
