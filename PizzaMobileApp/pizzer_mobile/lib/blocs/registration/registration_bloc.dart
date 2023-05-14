import 'package:pizzer_mobile/blocs/registration/registration_events.dart';
import 'package:pizzer_mobile/blocs/registration/registration_states.dart';
import 'package:pizzer_mobile/repositories/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AccountRepository _accountRepository;
  String? email = "";
  String? name = "";
  String? phone = "";
  String? password = "";
  String? repeatPassword = "";

  RegistrationBloc(this._accountRepository)
      : super(LoadingRegistrationState()) {
    on<LoadRegistrationEvent>((event, emit) async {
      emit(LoadingRegistrationState());
      try {
        emit(LoadedNoAllowedRegistrationState(
            email, name, phone, password, repeatPassword));
      } catch (e) {
        emit(RegistrationErrorState(e.toString()));
      }
    });

    on<EmailChangedEvent>((event, emit) async {
      try {
        email = event.email;
        if (email == "" ||
            name == "" ||
            phone == "" ||
            password == "" ||
            repeatPassword == "")
          emit(LoadedNoAllowedRegistrationState(
              email, name, phone, password, repeatPassword));
        else {
          String? result = password!.replaceAll(" ", "");
          if (result.length == 0)
            emit(LoadedNoAllowedRegistrationState(
                email, name, phone, password, repeatPassword));
          else {
            emit(LoadedAllowedRegistrationState(
                email, name, phone, password, repeatPassword));
          }
        }
      } catch (e) {
        emit(RegistrationErrorState(e.toString()));
      }
    });

    on<NameChangedEvent>((event, emit) async {
      try {
        name = event.name;
        if (email == "" ||
            name == "" ||
            phone == "" ||
            password == "" ||
            repeatPassword == "")
          emit(LoadedNoAllowedRegistrationState(
              email, name, phone, password, repeatPassword));
        else {
          String? result = password!.replaceAll(" ", "");
          if (result.length == 0)
            emit(LoadedNoAllowedRegistrationState(
                email, name, phone, password, repeatPassword));
          else {
            emit(LoadedAllowedRegistrationState(
                email, name, phone, password, repeatPassword));
          }
        }
      } catch (e) {
        emit(RegistrationErrorState(e.toString()));
      }
    });

    on<PhoneChangedEvent>((event, emit) async {
      try {
        phone = event.phone;
        if (email == "" ||
            name == "" ||
            phone == "" ||
            password == "" ||
            repeatPassword == "")
          emit(LoadedNoAllowedRegistrationState(
              email, name, phone, password, repeatPassword));
        else {
          String? result = password!.replaceAll(" ", "");
          if (result.length == 0)
            emit(LoadedNoAllowedRegistrationState(
                email, name, phone, password, repeatPassword));
          else {
            emit(LoadedAllowedRegistrationState(
                email, name, phone, password, repeatPassword));
          }
        }
      } catch (e) {
        emit(RegistrationErrorState(e.toString()));
      }
    });

    on<PasswordChangedEvent>((event, emit) async {
      try {
        password = event.password;
        if (email == "" ||
            name == "" ||
            phone == "" ||
            password == "" ||
            repeatPassword == "")
          emit(LoadedNoAllowedRegistrationState(
              email, name, phone, password, repeatPassword));
        else {
          String? result = password!.replaceAll(" ", "");
          if (result.length == 0)
            emit(LoadedNoAllowedRegistrationState(
                email, name, phone, password, repeatPassword));
          else {
            emit(LoadedAllowedRegistrationState(
                email, name, phone, password, repeatPassword));
          }
        }
      } catch (e) {
        emit(RegistrationErrorState(e.toString()));
      }
    });

    on<RepeatPasswordChangedEvent>((event, emit) async {
      try {
        repeatPassword = event.repeatPassword;
        if (email == "" ||
            name == "" ||
            phone == "" ||
            password == "" ||
            repeatPassword == "")
          emit(LoadedNoAllowedRegistrationState(
              email, name, phone, password, repeatPassword));
        else {
          String? result = password!.replaceAll(" ", "");
          if (result.length == 0)
            emit(LoadedNoAllowedRegistrationState(
                email, name, phone, password, repeatPassword));
          else {
            emit(LoadedAllowedRegistrationState(
                email, name, phone, password, repeatPassword));
          }
        }
      } catch (e) {
        emit(RegistrationErrorState(e.toString()));
      }
    });

    on<RegistrationSubmittedEvent>((event, emit) async {
      try {
        if (password != repeatPassword)
          emit(IncorrectRepeatPasswordState(
              email, name, phone, password, repeatPassword));
        else if (password!.indexOf(" ") != -1 || password!.length < 6)
          emit(IncorrectPasswordState(
              email, name, phone, password, repeatPassword));
        else {
          final result = await _accountRepository.register(
              email, name, phone, password, repeatPassword);
          if (result == false) {
            emit(EmailIsNotAllowedState(
                email, name, phone, password, repeatPassword));
          } else {
            email = "";
            name = "";
            phone = "";
            password = "";
            repeatPassword = "";
            emit(RegistrationSuccessState());
          }
        }
      } catch (e) {
        emit(RegistrationErrorState(e.toString()));
      }
    });
  }
}
