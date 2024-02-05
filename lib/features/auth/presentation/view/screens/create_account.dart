import 'dart:io';
import 'package:facebook_clone/core/constants/values.dart';
import 'package:facebook_clone/core/utils/picker_file.dart';
import 'package:facebook_clone/core/widgets/bottom.dart';
import 'package:facebook_clone/core/widgets/text_form_field.dart';
import 'package:facebook_clone/features/auth/presentation/view/widgets/gender_picker.dart';
import 'package:facebook_clone/features/auth/presentation/view/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/validation.dart';
import '../../managers/auth_provider.dart';
import '../widgets/birthday_picker.dart';

class CreateAccountPage extends ConsumerStatefulWidget {
  const CreateAccountPage({super.key});

  @override
  ConsumerState<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends ConsumerState<CreateAccountPage> {
  File? image;
  DateTime? birthday;
  String gender = 'male';
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void createAccount() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() => isLoading = true);
      ref
          .read(authProvider)
          .createAccount(
            fullName: '${firstNameController.text} ${lastNameController.text}',
            birthday: birthday ?? DateTime.now(),
            gender: gender,
            email: emailController.text,
            password: passwordController.text,
            image: image,
          )
          .then((credential) {
        if (!credential!.user!.emailVerified) {
          Navigator.pop(context);
        }
      }).catchError((_) {
        setState(() => isLoading = false);
      });
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: Values.defaultPadding,
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      image = await pickImage();
                      setState(() {});
                    },
                    child: ImagePickerWidget(image: image),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      // First Name Text Field
                      Expanded(
                        child: GeneralTextField(
                            controller: firstNameController,
                            hintText: 'First name',
                            textInputAction: TextInputAction.next,
                            validator: validateName),
                      ),
                      const SizedBox(width: 10),

                      // Last Name Text Field
                      Expanded(
                        child: GeneralTextField(
                            controller: lastNameController,
                            hintText: 'Last name',
                            textInputAction: TextInputAction.next,
                            validator: validateName),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Values.generalPaddingValue),
                    child: BirthdayPicker(
                      dateTime: birthday ?? DateTime.now(),
                      onPressed: () async {
                        birthday = await pickDate(
                          context: context,
                          date: birthday,
                        );
                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: Values.generalPaddingValue),
                    child: GenderPicker(
                      gender: gender,
                      onChanged: (value) {
                        gender = value ?? 'male';
                        setState(() {});
                      },
                    ),
                  ),
                  GeneralTextField(
                    controller: emailController,
                    hintText: 'Email',
                    textInputAction: TextInputAction.next,
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 10),
                  GeneralTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    textInputAction: TextInputAction.next,
                    validator: validatePassword,
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : GeneralButton(
                          onPressed: createAccount,
                          label: 'Create Account',
                        ),
                ],
              )),
        ),
      ),
    );
  }
}
