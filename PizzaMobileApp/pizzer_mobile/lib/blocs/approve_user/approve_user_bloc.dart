import 'package:pizzer_mobile/blocs/approve_user/approve_user_events.dart';
import 'package:pizzer_mobile/blocs/approve_user/approve_user_states.dart';
import 'package:pizzer_mobile/repositories/account_repository.dart';
import 'package:pizzer_mobile/repositories/user_info_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApproveUserBloc extends Bloc<ApproveUserEvent, ApproveUserState> {
  final AccountRepository _accountRepository;
  final UserInfoRepository _userInfoRepository;
  String? checkApprovalCode = "";

  ApproveUserBloc(this._accountRepository, this._userInfoRepository)
      : super(LoadingApprovalUserState()) {
    on<LoadApproveUserEvent>((event, emit) async {
      emit(LoadingApprovalUserState());
      try {
        emit(LoadedNoAllowedApproveUserState(
            event.token, event.approvalCode, checkApprovalCode));
      } catch (e) {
        emit(ApprovalUserErrorState(e.toString()));
      }
    });

    on<CheckApprovalCodeChangedEvent>((event, emit) async {
      try {
        checkApprovalCode = event.checkApprovalCode;
        if (checkApprovalCode == "")
          emit(LoadedNoAllowedApproveUserState(
              event.token, event.approvalCode, checkApprovalCode));
        else {
          emit(LoadedAllowedApproveUserState(
              event.token, event.approvalCode, checkApprovalCode));
        }
      } catch (e) {
        emit(ApprovalUserErrorState(e.toString()));
      }
    });

    on<ApproveUserSubmittedEvent>((event, emit) async {
      try {
        if (checkApprovalCode != event.approvalCode) {
          emit(IncorrectApprovalCodeState(
              event.token, event.approvalCode, checkApprovalCode));
        } else {
          checkApprovalCode = "";
          final result = await _userInfoRepository.getUserInfo(event.token);
          await _accountRepository.approveUser(result.id, event.approvalCode);
          emit(ApprovalUserSuccessState(event.token));
        }
      } catch (e) {
        emit(ApprovalUserErrorState(e.toString()));
      }
    });
  }
}
