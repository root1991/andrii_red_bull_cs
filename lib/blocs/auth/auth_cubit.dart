import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_bull_case_study/blocs/auth/auth_state.dart';
import 'package:red_bull_case_study/constants.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  Future<void> login(String email, String password) async {
    if (state.isLoading) return;

    emit(AuthState.loadingState());

    await Future.delayed(const Duration(seconds: 2));

    final emailValid = EmailValidator.validate(email.trim());
    final passwordValid =
        RedBullConstants.passwordValidator.hasMatch(password.trim());

    if (!emailValid || !passwordValid) {
      emit(
        AuthState(
          isLoading: false,
          success: false,
          error: true,
          emailErrorText: emailValid ? null : 'Invalid email',
          passwordErrorText: passwordValid
              ? null
              : 'Password must contain at least 8 characters and include a combination of lowercase, uppercase, numbers, and special characters',
        ),
      );
    } else {
      emit(AuthState.successState());
    }
  }
}
