import 'package:pizzer_mobile/blocs/sign_in/sign_in_events.dart';
import 'package:pizzer_mobile/blocs/sign_in/sign_in_states.dart';
import 'package:pizzer_mobile/repositories/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AccountRepository _accountRepository;
  String? email = "";
  String? password = "";

  SignInBloc(this._accountRepository) : super(LoadingSignInState()) {
    on<LoadSignInEvent>((event, emit) async {
      emit(LoadingSignInState());
      try {
        emit(LoadedNoAllowedSignInState(email, password));
      } catch (e) {
        emit(SignInErrorState(e.toString()));
      }
    });

    on<EmailChangedEvent>((event, emit) async {
      try {
        email = event.email;
        if (email == "" || password == "")
          emit(LoadedNoAllowedSignInState(email, password));
        else {
          emit(LoadedAllowedSignInState(email, password));
        }
      } catch (e) {
        emit(SignInErrorState(e.toString()));
      }
    });

    on<PasswordChangedEvent>((event, emit) async {
      try {
        password = event.password;
        if (email == "" || password == "")
          emit(LoadedNoAllowedSignInState(email, password));
        else {
          emit(LoadedAllowedSignInState(email, password));
        }
      } catch (e) {
        emit(SignInErrorState(e.toString()));
      }
    });

    on<SignInSubmittedEvent>((event, emit) async {
      try {
        final result = await _accountRepository.signIn(email, password);
        if (result.responseCode == 401) {
          emit(IncorrectEmailPasswordState(email, password));
        } else {
          email = "";
          password = "";
          emit(SignInSuccessState(result.jwTtoken));
        }
      } catch (e) {
        emit(SignInErrorState(e.toString()));
      }
    });
  }
}
