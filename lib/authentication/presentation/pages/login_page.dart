import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather/authentication/presentation/cubits/login_cubit.dart';
import 'package:open_weather/authentication/presentation/cubits/login_state.dart';
import 'package:open_weather/authentication/presentation/widgets/validators/composite_validator.dart';
import 'package:open_weather/authentication/presentation/widgets/validators/email_validator.dart';
import 'package:open_weather/authentication/presentation/widgets/validators/minimum_length_validator.dart';
import 'package:open_weather/authentication/presentation/widgets/validators/non_empty_validator.dart';
import 'package:open_weather/core/config/routes.dart';
import 'package:open_weather/core/presentation/widgets/loading_indicator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginValidCredentials) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Welcome!')));
          Navigator.of(context).pushReplacementNamed(Routes.weather);
        } else if (state is LoginInvalidCredentials) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Wrong email or password!')));
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Open Weather',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your email',
                  ),
                  validator: compositeValidator(validators: [
                    nonEmptyValidator(
                      message: 'Please provide an email',
                    ),
                    emailValidator
                  ]),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your password',
                  ),
                  obscureText: true,
                  validator: compositeValidator(validators: [
                    nonEmptyValidator(
                      message: 'Please provide a password',
                    ),
                    minimumLengthValidator(
                      length: 5,
                      fieldName: 'password',
                    )
                  ]),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: switch (state) {
                          LoginLoading() => const Padding(
                              padding: EdgeInsets.all(8),
                              child: LoadingIndicator(),
                            ),
                          _ => SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                child: const Text('Log in'),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<LoginCubit>().login(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                  }
                                },
                              ),
                            ),
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
