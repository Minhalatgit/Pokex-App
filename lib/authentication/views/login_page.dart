import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pokex/app_routes.dart';
import 'package:pokex/authentication/cubit/auth_cubit.dart';
import 'package:pokex/authentication/cubit/login_state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();

  final _passwordFieldKey = GlobalKey<FormBuilderFieldState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SuccessAuthState) {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homePage, (route) => false);
          }
        },
        child: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormBuilderTextField(
                  key: _emailFieldKey,
                  controller: _emailController,
                  name: 'email',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                FormBuilderTextField(
                  key: _passwordFieldKey,
                  controller: _passwordController,
                  name: 'password',
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(6),
                  ]),
                ),
                const SizedBox(height: 50),
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  if (state is InitAuthState || state is ErrorAuthState) {
                    if (state is ErrorAuthState) {
                      Fluttertoast.showToast(msg: state.message);
                    }

                    return ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).login(_emailController.text.trim(), _passwordController.text.trim());
                          }
                        },
                        child: const Text("Login"));
                  } else if (state is LoadingAuthState) {
                    return const CircularProgressIndicator();
                  } else {
                    return const SizedBox();
                  }
                }),
                const SizedBox(height: 50),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/signup");
                    },
                    child: const Text("Don't have account? Signup here!", style: TextStyle(fontWeight: FontWeight.bold)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
