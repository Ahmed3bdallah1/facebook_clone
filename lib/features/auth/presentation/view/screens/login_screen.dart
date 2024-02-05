import 'package:facebook_clone/config/routes/routes.dart';
import 'package:facebook_clone/core/constants/values.dart';
import 'package:facebook_clone/core/widgets/bottom.dart';
import 'package:facebook_clone/core/widgets/text_form_field.dart';
import 'package:facebook_clone/features/auth/presentation/managers/auth_provider.dart';
import 'package:facebook_clone/features/auth/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  bool isLoading = false;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() => isLoading = true);
      await ref.read(authProvider).signIn(
          email: emailController.text, password: passwordController.text);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: Values.defaultPadding,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: height * .05, bottom: height * .09),
                child: Image.asset(
                  'assets/facebook.png',
                  width: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      GeneralTextField(
                        controller: emailController,
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 15),
                      GeneralTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        isPassword: true,
                        validator: validatePassword,
                      ),
                      const SizedBox(height: 15),
                      GeneralButton(onPressed: login, label: 'Login'),
                      const SizedBox(height: 15),
                      const Text(
                        'Forget Password',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              Column(
                children: [
                  GeneralButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        Routes.createAccount,
                      );
                    },
                    label: 'Create new account',
                    color: Colors.transparent,
                  ),
                  Image.asset(
                    'assets/meta.png',
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
