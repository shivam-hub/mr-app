import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String username;
  // Add other user-related properties

  const UserModel({
    required this.username,
    // Add other user-related properties as named parameters
  });

  @override
  List<Object?> get props => [username]; // Include other properties as needed
}
