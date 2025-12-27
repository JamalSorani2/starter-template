import 'package:app_name/app/auth/domain/entities/login_auth_param.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../common/imports/imports.dart';
import '../../input_forms/login_form.dart';
import '../../state/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    getIt<SharedPreferences>().setBool(KOnboardingCompleted, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: getIt<AuthBloc>(),
        child: ReactiveForm(
          formGroup: LoginForm.formGroup,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.loginAuthState.isLoaded()) {
                context.go(RoutesNames.root);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomReactiveField(
                      title: 'البريد الإلكتروني',
                      keyboardType: TextInputType.emailAddress,
                      controller: InputKeys.email,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomReactiveField(
                      title: 'كلمة المرور',
                      isPassword: true,
                      asset: const Icon(CupertinoIcons.eye_slash),
                      suffixPassIcon: const Icon(CupertinoIcons.eye),
                      controller: InputKeys.password,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton.primary(
                      isLoading: state.loginAuthState.isLoading(),
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              LoginAuthEvent(
                                loginAuthParam: LoginAuthParam(
                                  isEmail: true,
                                ),
                              ),
                            );
                      },
                      text: 'إرسال',
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              context.go(RoutesNames.signup);
                            },
                            child: const Text('إنشاء حساب'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
