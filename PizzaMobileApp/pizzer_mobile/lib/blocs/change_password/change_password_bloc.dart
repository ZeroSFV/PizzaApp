import 'dart:math';

import 'package:pizzer_mobile/blocs/change_password/change_password_events.dart';
import 'package:pizzer_mobile/blocs/change_password/change_password_states.dart';
import 'package:pizzer_mobile/repositories/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AccountRepository _accountRepository;
  String? oldPassword = "";
  String? newPassword = "";
  String? repeatPassword = "";
  String? successMessage = "";

  ChangePasswordBloc(this._accountRepository)
      : super(ChangePasswordLoadingState()) {
    on<LoadChangePasswordEvent>((event, emit) async {
      emit(ChangePasswordLoadingState());
      try {
        emit(LoadedNoAllowedChangePasswordState(
            event.token, oldPassword, newPassword, repeatPassword));
      } catch (e) {
        emit(ChangePasswordErrorState(e.toString()));
      }
    });

    on<OldPasswordChangedEvent>((event, emit) async {
      try {
        successMessage = "";
        oldPassword = event.oldPassword;
        if (oldPassword == "" || newPassword == "" || repeatPassword == "")
          emit(LoadedNoAllowedChangePasswordState(event.token,
              event.oldPassword, event.newPassword, event.repeatPassword));
        else {
          String? result = newPassword!.replaceAll(" ", "");
          if (result.length == 0)
            emit(LoadedNoAllowedChangePasswordState(event.token,
                event.oldPassword, event.newPassword, event.repeatPassword));
          else {
            emit(LoadedAllowedChangePasswordState(event.token,
                event.oldPassword, event.newPassword, event.repeatPassword));
          }
        }
      } catch (e) {
        emit(ChangePasswordErrorState(e.toString()));
      }
    });

    on<NewPasswordChangedEvent>((event, emit) async {
      try {
        successMessage = "";
        newPassword = event.newPassword;
        if (oldPassword == "" || newPassword == "" || repeatPassword == "")
          emit(LoadedNoAllowedChangePasswordState(event.token,
              event.oldPassword, event.newPassword, event.repeatPassword));
        else {
          String? result = newPassword!.replaceAll(" ", "");
          if (result.length == 0)
            emit(LoadedNoAllowedChangePasswordState(event.token,
                event.oldPassword, event.newPassword, event.repeatPassword));
          else {
            emit(LoadedAllowedChangePasswordState(event.token,
                event.oldPassword, event.newPassword, event.repeatPassword));
          }
        }
      } catch (e) {
        emit(ChangePasswordErrorState(e.toString()));
      }
    });

    on<RepeatPasswordChangedEvent>((event, emit) async {
      try {
        successMessage = "";
        repeatPassword = event.repeatPassword;
        if (oldPassword == "" || newPassword == "" || repeatPassword == "")
          emit(LoadedNoAllowedChangePasswordState(event.token,
              event.oldPassword, event.newPassword, event.repeatPassword));
        else {
          String? result = newPassword!.replaceAll(" ", "");
          if (result.length == 0)
            emit(LoadedNoAllowedChangePasswordState(event.token,
                event.oldPassword, event.newPassword, event.repeatPassword));
          else {
            emit(LoadedAllowedChangePasswordState(event.token,
                event.oldPassword, event.newPassword, event.repeatPassword));
          }
        }
      } catch (e) {
        emit(ChangePasswordErrorState(e.toString()));
      }
    });

    on<NewPasswordSubmittedEvent>((event, emit) async {
      try {
        if (newPassword != repeatPassword)
          emit(IncorrectRepeatChangePasswordState(
              event.token, oldPassword, newPassword, repeatPassword));
        else if (newPassword!.indexOf(" ") != -1 || newPassword!.length < 6)
          emit(IncorrectNewPasswordState(
              event.token, oldPassword, newPassword, repeatPassword));
        else {
          final result = await _accountRepository.changeUserPassword(
              event.token, oldPassword, newPassword);
          if (result == false) {
            emit(IncorrectOldPasswordState(
                event.token, oldPassword, newPassword, repeatPassword));
          } else {
            successMessage = "Пароль был изменён";
            oldPassword = "";
            newPassword = "";
            repeatPassword = "";
            emit(ChangePasswordLoadingState());
            emit(LoadedNoAllowedChangePasswordState(
                event.token, oldPassword, newPassword, repeatPassword));
          }
        }
      } catch (e) {
        emit(ChangePasswordErrorState(e.toString()));
      }
    });
  }
}
