import 'package:equatable/equatable.dart';
import 'package:tradpool/features/register/data/models/create_user.dart';

class Params extends Equatable {
  final CreateUserModel user;

  const Params({this.user});

  @override
  List<Object> get props => [user];
}
