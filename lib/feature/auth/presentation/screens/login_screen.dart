import 'package:auto_route/auto_route.dart';
import 'package:bloc_project/core/router.gr.dart';
import 'package:bloc_project/feature/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:bloc_project/presentation/widgets/custom_form_field.dart';
import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  late final AuthBloc _registerBloc;

  @override
  void initState() {
    //_registerBloc = getIt<AuthBloc>();

    super.initState();
    _registerBloc = context.read<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          logging: () {},
          loginSuccess: (message) {
            FloatingSnackBar(
              message: message,
              context: context,
              textColor: Colors.white,
              backgroundColor: Colors.green,
              textStyle: const TextStyle(color: Colors.white),
              duration: const Duration(milliseconds: 4000),
            );
            context.router.push(const MovieHomeRoute());
          },
          authError: (message) {
            FloatingSnackBar(
              message: message,
              context: context,
              textColor: Colors.white,
              backgroundColor: Colors.red,
              textStyle: const TextStyle(color: Colors.white),
              duration: const Duration(milliseconds: 4000),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Form'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: _usernameController,
                labelText: 'Username',
                hintText: 'Your username here',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'username cannot be empty';
                  } else if (value.length < 2) {
                    return 'Invalid username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: _passwordController,
                labelText: 'Password',
                hintText: 'Your password here',
                validator: (value) {
                  if (value != null && value.contains('@')) {
                    return null;
                  }
                  return 'Password must contain @';
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return _buildLoginButton(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _registerBloc.add(LoginButtonClickEvent(
                                      _usernameController.text,
                                      _passwordController.text));
                                }
                              },
                              child: const Text('Login'),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                    logging: () {
                      return _buildLoginButton(
                        child: ElevatedButton(
                          onPressed: null,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Login'),
                              SizedBox(
                                height: 15,
                                width: 15,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.blue,
                                )),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              GestureDetector(
                onTap: () => context.router.push(const RegisterRoute()),
                child: const Text("Don't have account ? SignUp"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildLoginButton({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}
