import 'package:auto_route/auto_route.dart';
import 'package:bloc_project/core/router.gr.dart';
import 'package:bloc_project/feature/auth/data/models/registration_model.dart';
import 'package:bloc_project/feature/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:bloc_project/presentation/widgets/custom_form_field.dart';
import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _collegeController = TextEditingController();

  late final AuthBloc _registerBloc;

  @override
  void initState() {
    // _registerBloc = getIt<AuthBloc>();
    _registerBloc = context.read<AuthBloc>();
    super.initState();
  }

  // @override
  // void dispose() {
  //   context.read<AuthBloc>().close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _registerBloc,
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            success: (message) => context.router.push(
                  const LoginRoute(),
                )

            // print('Type of states ${state}');
            // if (state is RegisterSuccessState) {
            //   context.router.push(const LoginRoute());
            // }
            );
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Register Form'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _phoneController,
                  labelText: 'Phone No',
                  hintText: 'please add your phone no',
                  validator: (value) {
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'please add your email',
                  validator: (value) {
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: _usernameController,
                  labelText: 'Username',
                  hintText: 'please add your username',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'user name is required';
                    } else if (value.isEmpty) {
                      return 'Invalid user number';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'please add your password',
                  validator: (password) {
                    if (password != null && password.contains('@')) {
                      return null;
                    }
                    return 'password must contain @ symbol';
                  },
                ),
                CustomTextFormField(
                    controller: _firstNameController,
                    labelText: 'First Name',
                    hintText: 'please add your first name',
                    validator: (password) {
                      return null;
                    }),
                CustomTextFormField(
                    controller: _lastNameController,
                    labelText: 'Last Name',
                    hintText: 'please add your last name',
                    validator: (password) {
                      return null;
                    }),
                CustomTextFormField(
                    controller: _collegeController,
                    labelText: 'College Name',
                    hintText: 'please add your college name',
                    validator: (password) {
                      return null;
                    }),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Cancel')),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(content: Text('Processing Data')));
                          FloatingSnackBar(
                            message: 'Processing Data',
                            context: context,
                            textColor: Colors.black,
                            textStyle: const TextStyle(color: Colors.white),
                            duration: const Duration(milliseconds: 4000),
                            backgroundColor:
                                const Color.fromARGB(255, 14, 14, 14),
                          );
                          RegistrationModel registrationModel =
                              RegistrationModel(
                            email: _emailController.text,
                            username: _usernameController.text,
                            password: _passwordController.text,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            collegeName: _collegeController.text,
                            phoneNo: _phoneController.text,
                          );

                          _registerBloc.add(
                            RegisterButtonClickEvent(
                                registrationModel: registrationModel),
                          );
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => context.router.pushAndPopUntil(
                      const LoginRoute(),
                      predicate: (route) => false),
                  child: const Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 15),
                      text: "Already have an account ? ", // default text style
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                              fontStyle: FontStyle.italic, color: Colors.blue),
                        ),
                      ],
                    ),
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
