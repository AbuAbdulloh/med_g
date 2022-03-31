part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final FormzStatus status;
  final AuthenticatedUser user;
  final String image;

  const ProfileState({
    required this.status,
    required this.user,
    required this.image,
  });
  
  ProfileState copyWith({
    FormzStatus? status,
    AuthenticatedUser? user,
    String? image,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      image: image ?? this.image,
    );
  }

  @override
  List<Object> get props => [status, user, image];
}
