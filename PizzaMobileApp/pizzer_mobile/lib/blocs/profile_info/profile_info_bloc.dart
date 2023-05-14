import 'package:pizzer_mobile/blocs/profile_info/profile_info_events.dart';
import 'package:pizzer_mobile/blocs/profile_info/profile_info_states.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {
  final UserInfoRepository _userInfoRepository;
  String? name = "";
  String? phone = "";

  ProfileInfoBloc(this._userInfoRepository) : super(ProfileInfoLoadingState()) {
    on<LoadProfileInfoEvent>((event, emit) async {
      emit(ProfileInfoLoadingState());
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        name = userInfo.name;
        phone = userInfo.phone;
        emit(LoadedNoAllowedChangeProfileInfoState(
            userInfo, event.token, userInfo.name, userInfo.phone));
      } catch (e) {
        emit(ProfileInfoErrorState(e.toString()));
      }
    });

    on<ProfileNameChangedEvent>((event, emit) async {
      try {
        if (event.newName != event.previousName) {
          name = event.newName;
          if (name == "" || phone == "")
            emit(LoadedNoAllowedChangeProfileInfoState(event.user, event.token,
                event.previousName, event.previousPhone));
          else {
            emit(LoadedAllowedChangeProfileInfoState(event.user, event.token,
                event.previousName, event.previousPhone));
          }
        } else
          emit(LoadedNoAllowedChangeProfileInfoState(event.user, event.token,
              event.previousName, event.previousPhone));
      } catch (e) {
        emit(ProfileInfoErrorState(e.toString()));
      }
    });

    on<ProfilePhoneChangedEvent>((event, emit) async {
      try {
        if (event.newPhone != event.previousPhone) {
          phone = event.newPhone;
          if (name == "" || phone == "")
            emit(LoadedNoAllowedChangeProfileInfoState(event.user, event.token,
                event.previousName, event.previousPhone));
          else {
            emit(LoadedAllowedChangeProfileInfoState(event.user, event.token,
                event.previousName, event.previousPhone));
          }
        } else
          emit(LoadedNoAllowedChangeProfileInfoState(event.user, event.token,
              event.previousName, event.previousPhone));
      } catch (e) {
        emit(ProfileInfoErrorState(e.toString()));
      }
    });

    on<ProfileInfoChangedEvent>((event, emit) async {
      try {
        final userInfo = await _userInfoRepository.getUserInfo(event.token);
        await _userInfoRepository.updateUserInfo(userInfo.id, name, phone);
        final newUserInfo = await _userInfoRepository.getUserInfo(event.token);
        emit(LoadedNoAllowedChangeProfileInfoState(
            newUserInfo, event.token, newUserInfo.name, newUserInfo.phone));
      } catch (e) {
        emit(ProfileInfoErrorState(e.toString()));
      }
    });
  }
}
