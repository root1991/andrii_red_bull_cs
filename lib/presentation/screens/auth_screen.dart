import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:red_bull_case_study/blocs/auth/auth_cubit.dart';
import 'package:red_bull_case_study/blocs/auth/auth_state.dart';
import 'package:red_bull_case_study/constants.dart';
import 'package:red_bull_case_study/presentation/widgets/redbull_text_field.dart';
import 'package:red_bull_case_study/style/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    final strings = AppLocalizations.of(context)!;
    return BlocConsumer<AuthCubit, AuthState>(
        listener: _blocListener,
        builder: (context, state) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              systemNavigationBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            child: Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Spacer(),
                      Text(strings.login, style: RedBullTextStyles.titleTextStyle),
                      SizedBox(height: 0.5.h),
                      Text(
                        strings.auth_message,
                        style: RedBullTextStyles.labelTextStyle,
                      ),
                      SizedBox(height: 3.h),
                      RedBullTextField(
                        labelText: strings.email.toUpperCase(),
                        controller: _emailController,
                        preffixIcon: RedBullAssets.icMail,
                      ),
                      SizedBox(height: 2.h),
                      RedBullTextField(
                        labelText: strings.password.toUpperCase(),
                        controller: _passwordController,
                        preffixIcon: RedBullAssets.icLock,
                        suffixIcon: RedBullAssets.icObscure,
                      ),
                      SizedBox(height: 4.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: state.isLoading
                              ? null
                              : () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  cubit.login(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: RedBullColors.colorAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.only(
                              right: 2.w,
                              top: 1.3.h,
                              bottom: 1.3.h,
                              left: 5.w,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                strings.login.toUpperCase(),
                                style: RedBullTextStyles.labelTextStyle
                                    .copyWith(color: Colors.white),
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              const Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                      ),
                      state.isLoading
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 2.h),
                                child: const CircularProgressIndicator(
                                  color: RedBullColors.colorAccent,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      state.error
                          ? Padding(
                              padding: EdgeInsets.only(top: 3.h),
                              child: Material(
                                elevation: 1,
                                shadowColor: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8.0),
                                child: Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Text(
                                    _buildErrorMessage(state),
                                    style: RedBullTextStyles.labelTextStyle
                                        .copyWith(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          RedBullAssets.icRedBull,
                          height: 15.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  String _buildErrorMessage(AuthState state) {
    String? emailError = state.emailErrorText;
    String? passwordError = state.passwordErrorText;

    if (emailError != null && passwordError != null) {
      return '- $emailError\n- $passwordError';
    }

    return emailError != null ? '- $emailError' : '- $passwordError';
  }

  void _blocListener(
    BuildContext context,
    AuthState state,
  ) {
    if (state.success) {
      context.push(RedBullRoutes.folders);
    }
  }
}
