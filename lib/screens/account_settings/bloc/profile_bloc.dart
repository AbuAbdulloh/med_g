import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:med_g/models/authenticated_user/authenticated_user.dart';
import 'package:med_g/repository/authentication.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthenticationRepository _repository;
  ProfileBloc({
    required AuthenticationRepository repository,
  })  : _repository = repository,
        super(
          ProfileState(
            status: FormzStatus.pure,
            user: AuthenticatedUser.fromJson(const {}),
            image: '',
          ),
        ) {
    on<UpdateProfile>((event, emit) async {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final updatedUser = await _repository.updateProfile(user: event.user);
        print('this is updated user: $updatedUser');
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          user: updatedUser,
        ));
        print('state update user" ${state.user}');
        event.onSucces();
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        event.onError('$e');
      }
    });
    on<UploadImage>((event, emit) async {
      // TODO: implement event handler
    });
  }
}
