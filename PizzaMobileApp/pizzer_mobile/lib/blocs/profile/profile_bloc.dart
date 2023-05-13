import 'package:pizzer_mobile/blocs/profile/profile_events.dart';
import 'package:pizzer_mobile/blocs/profile/profile_states.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserInfoRepository _userInfoRepository;

  ProfileBloc(this._userInfoRepository) : super(ProfileLoadingState()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        emit(ProfileInfoChosenState(event.token));
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });

    on<ProfileInfoChosenEvent>((event, emit) async {
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        emit(ProfileInfoChosenState(event.token));
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });

    on<OrdersChosenEvent>((event, emit) async {
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        emit(UserOrderState(event.token));
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });

    on<PasswordChosenEvent>((event, emit) async {
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        emit(ChangePasswordState(event.token));
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });
  }
}
