import 'package:equatable/equatable.dart';

class CreateUserEntity extends Equatable {
  const CreateUserEntity({
    this.name,
    this.email,
    this.mobileNumber,
    this.address,
    this.description,
    this.receiveNotifications,
  });

  final String name;
  final String email;
  final String mobileNumber;
  final String address;
  final String description;
  final bool receiveNotifications;

  @override
  List<Object> get props =>
      [name, email, mobileNumber, address, description, receiveNotifications];
}
