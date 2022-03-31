part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfile extends ProfileEvent {
  final AuthenticatedUser user;
  final Function() onSucces;
  final Function(String message) onError;

  const UpdateProfile({
    required this.user,
    required this.onSucces,
    required this.onError,
  });
}

class UploadImage extends ProfileEvent {
  final Function() onSucces;
  final Function(String message) onError;

  const UploadImage({
    required this.onSucces,
    required this.onError,
  });
}
