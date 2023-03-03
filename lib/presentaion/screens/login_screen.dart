import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_task/core/app_functions/show_snackbar.dart';
import 'package:qr_code_task/core/app_resources/app_images.dart';
import 'package:qr_code_task/core/app_resources/app_sizes.dart';
import 'package:qr_code_task/core/app_resources/app_strings.dart';
import 'package:qr_code_task/core/app_routes/routes.dart';
import 'package:qr_code_task/presentaion/managers/auth_cubit/auth_cubit.dart';
import 'package:qr_code_task/presentaion/widgets/custom_full_button.dart';
import 'package:qr_code_task/presentaion/widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ///set App Height and Width to use in all app
    AppSizes.appHeight = MediaQuery.of(context).size.height;
    AppSizes.appWidth = MediaQuery.of(context).size.width;

    ///
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _buildLoginBody(context),
    );
  }

  Widget _buildLoginBody(context) => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildLoginHeader(context),
              SizedBox(
                height: AppSizes.appHeight * AppHeight.s104,
              ),
              _buildLoginForm(context),
            ],
          ),
        ),
      );

  Widget _buildLoginForm(context) => Form(
      key: _formKey,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: AppSizes.appWidth * AppWidth.s21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              controller: _emailController,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              hintText: AppStrings.emailHintText,
              enabled: true,
              validator: _validateEmail,
            ),
            SizedBox(
              height: AppSizes.appHeight * AppHeight.s15,
            ),
            CustomTextFormField(
                controller: _passwordController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                enabled: true,
                hintText: AppStrings.passwordHintText,
                validator: _validatePassword,
                isPassword: true),
            SizedBox(
              height: AppSizes.appHeight * AppHeight.s24,
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.grey.shade600),
                  child: const AutoSizeText(AppStrings.forgetPassword)),
            ),
            SizedBox(
              height: AppSizes.appHeight * AppHeight.s43,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is UserFailedLoginState) {
                  showTextSnackBar(context: context, message: state.message);
                } else if (state is UserSuccessLoginState) {
                  showTextSnackBar(
                      context: context, message: state.user!.message);
                  Navigator.pushReplacementNamed(
                      context,
                  AppRoutes.scanQrCodeScreenRoute
                  );
                } else {
                  debugPrint(state.toString());
                }
              },
              builder: (context, state) => CustomActionButton(
                  width: AppSizes.appWidth * AppWidth.s280,
                  verticalPadding: AppSizes.appHeight * AppHeight.s20,
                  borderColor: Colors.transparent,
                  borderRadius: 5,
                  onPressed: state is UserLoginingState
                      ? null
                      : () {
                          _loginAction(context);
                        },
                  textStyle: Theme.of(context).textTheme.titleMedium!,
                  fontWeight: FontWeight.w500,
                  backgroundColor: Colors.deepOrange.shade400,
                  foregroundColor: Colors.white,
                  text: AppStrings.login,
                  elevation: 2),
            ),
          ],
        ),
      ));

  Widget _buildLoginHeader(context) => SizedBox(
        width: double.infinity,
        height: AppSizes.appHeight * AppHeight.s180,
        child: Stack(
          children: [
            Align(
                alignment: AlignmentDirectional.topEnd,
                child: Image.asset(
                  AppImages.ellipse47,
                  width: AppSizes.appWidth * AppWidth.s220,
                  height: AppSizes.appHeight * AppHeight.s180,
                  fit: BoxFit.cover,
                )),
            Image.asset(
              AppImages.ellipse48,
              height: AppSizes.appHeight * AppHeight.s180,
              fit: BoxFit.cover,
            ),
            Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(
                  bottom: AppSizes.appHeight * AppHeight.s40,
                ),
                width: double.infinity,
                child: AutoSizeText(
                  AppStrings.login,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      );

  String? _validateEmail(input) {
    if (input.isEmpty) {
      return AppStrings.emailEmptyError;
    } else if (!EmailValidator.validate(input)) {
      return AppStrings.emailFormatError;
    }
    return null;
  }

  String? _validatePassword(input) {
    if (input.isEmpty) {
      return AppStrings.passwordEmptyError;
    } else if (input.length < 6) {
      return AppStrings.passwordShortError;
    }
    return null;
  }

  void _loginAction(context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthCubit.get(context).login(
          email: _emailController.text, password: _passwordController.text);
    }
  }
}
