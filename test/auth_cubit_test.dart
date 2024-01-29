import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:red_bull_case_study/blocs/auth/auth_cubit.dart';
import 'package:red_bull_case_study/blocs/auth/auth_state.dart';

void main() {
  group('AuthCubit', () {
    late AuthCubit authCubit;

    setUp(() {
      authCubit = AuthCubit();
    });

    tearDown(() {
      authCubit.close();
    });

    blocTest<AuthCubit, AuthState>(
      'emits success state when login is successful with valid email and password',
      build: () => authCubit,
      act: (cubit) => cubit.login('valid@example.com', 'ValidPassword123!'),
      wait: const Duration(seconds: 2),
      expect: () => [
        AuthState.loadingState(),
        AuthState.successState(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits error state when login with invalid email',
      build: () => authCubit,
      act: (cubit) => cubit.login('invalidemail', 'ValidPassword123!'),
      wait: const Duration(seconds: 2),
      expect: () => [
        AuthState.loadingState(),
        isA<AuthState>()
          .having((state) => state.error, 'error', true)
          .having((state) => state.emailErrorText, 'emailErrorText', isNotNull),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits error state when login with invalid password',
      build: () => authCubit,
      act: (cubit) => cubit.login('valid@example.com', 'short'),
      wait: const Duration(seconds: 2),
      expect: () => [
        AuthState.loadingState(),
        isA<AuthState>()
          .having((state) => state.error, 'error', true)
          .having((state) => state.passwordErrorText, 'passwordErrorText', isNotNull),
      ],
    );
  });
}
