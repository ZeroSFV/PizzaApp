import 'package:pizzer_mobile/blocs/reset_password/reset_password_events.dart';
import 'package:pizzer_mobile/blocs/reset_password/reset_password_states.dart';
import 'package:pizzer_mobile/repositories/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AccountRepository _accountRepository;
  String? email = "";

  ResetPasswordBloc(this._accountRepository)
      : super(LoadingResetPasswordState()) {
    on<LoadResetPasswordEvent>((event, emit) async {
      emit(LoadingResetPasswordState());
      try {
        emit(LoadedNoAllowedResetPasswordState(email));
      } catch (e) {
        emit(ResetPasswordErrorState(e.toString()));
      }
    });

    on<EmailChangedEvent>((event, emit) async {
      try {
        email = event.email;
        if (email == "")
          emit(LoadedNoAllowedResetPasswordState(email));
        else {
          emit(LoadedAllowedResetPasswordState(email));
        }
      } catch (e) {
        emit(ResetPasswordErrorState(e.toString()));
      }
    });

    on<ResetPasswordSubmittedEvent>((event, emit) async {
      try {
        final result = await _accountRepository.resetPassword(email);
        if (result == false) {
          emit(IncorrectEmailState(email));
        } else {
          email = "";
          emit(ResetPasswordSuccessState());
        }
      } catch (e) {
        emit(ResetPasswordErrorState(e.toString()));
      }
    });
  }
}
