import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/data/bloc/auth/auth_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final authCubit = context.read<AuthCubit>();
        return Form(
          key: authCubit.formKey,
          child: Column(
            children: [
              CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email cannot be empty';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                controller: authCubit.emailController,
                text: 'Email',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email, color: ColorManager.grey),
              ),
              verticalSpace(24),
              CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                controller: authCubit.passwordController,
                text: 'Password',
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: Icon(Icons.visibility, color: ColorManager.grey),
                prefixIcon: Icon(Icons.lock, color: ColorManager.grey),
              ),
              verticalSpace(48),
              CustomBtn(
                color:
                    authCubit.state is AuthLoading
                        ? ColorManager.primary
                        : ColorManager.secondary,
                text: 'Sign Up',
                onPressed: () {
                  if (authCubit.formKey.currentState!.validate()) {
                    authCubit.signUp(
                      authCubit.emailController.text.trim(),
                      authCubit.passwordController.text.trim(),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
