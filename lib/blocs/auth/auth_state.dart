import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final String? passwordErrorText;
  final String? emailErrorText;
  final bool success;
  final bool error;

  const AuthState({
    required this.isLoading,
    required this.success,
    required this.error,
    this.emailErrorText,
    this.passwordErrorText,
  });

  @override
  List<Object?> get props => [
        isLoading,
        emailErrorText,
        passwordErrorText,
        success,
      ];

  AuthState copyWith({
    bool? isLoading,
    String? passwordErrorText,
    String? emailErrorText,
    bool? success,
    bool? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      error: error ?? this.error,
      emailErrorText: emailErrorText ?? this.emailErrorText,
      passwordErrorText: passwordErrorText ?? this.passwordErrorText,
    );
  }

  static AuthState initial() {
    return const AuthState(
      isLoading: false,
      success: false,
      error: false,
    );
  }

  static AuthState successState() {
    return const AuthState(
      isLoading: false,
      success: true,
      error: false
    );
  }

  static AuthState loadingState() {
    return const AuthState(
      isLoading: true,
      success: false,
      error: false,
    );
  }
}
