// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/constants/custom_regex.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/user_auth_repository_impl.dart';
import 'package:flutter_application_1/features/common/presentation/pages/cnw_worker_page.dart';
import 'package:flutter_application_1/features/common/presentation/pages/intl_volunteer_page.dart';
import 'package:flutter_application_1/features/common/presentation/pages/natl_volunteer_page.dart';
import 'package:flutter_application_1/features/common/presentation/pages/promoter_entity_worker_page.dart';
import 'package:flutter_application_1/features/common/presentation/pages/register_page.dart';

import 'package:flutter_application_1/features/common/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/custom_text_form_field.dart';

import 'package:flutter_application_1/features/common/presentation/widgets/custom_text_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: kGradient),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(),
              const SizedBox(height: 25),
              SizedBox(
                width: 450,
                child: CustomTextFormField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Insira o teu email',
                  regex: kEmailRegex,
                  errorText: "Enter a valid email",
                ),
              ),
              SizedBox(
                width: 450,
                child: CustomTextFormField(
                  regex: kPasswordRegex,
                  controller: _passwordController,
                  obscureText: true,
                  // errorText: "Enter a valid password",
                  hintText: 'Insira a palavra-passe',
                  labelText: 'Palavra-passe',
                ),
              ),
              SizedBox(
                width: 450,
                child: CustomElevatedButton(
                  onPressed: () => _login(context),
                  text: "Iniciar Sessão",
                ),
              ),
              const SizedBox(height: 10),
              CustomTextButton(
                lightText: 'Não tem uma conta? ',
                boldText: ' Registre-se.',
                onTap: () => navigateTo(context, const RegisterPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    UserAuthRepositoryImpl auth = UserAuthRepositoryImpl();
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      showLoadingDialog(context);
      //TODO: Uncomment
      var res1 = await auth.signinUserCnvWorker(email, password);
      if (res1 is DataSuccess) {
        Navigator.of(context).pop();
        navigateWithReplacementTo(
          context,
          CnvWorkerPage(cnvWorker: res1.data!),
        );
        return;
      }

      var res4 = await auth.signinUserPromEntWorker(email, password);
      if (res4 is DataSuccess) {
        Navigator.of(context).pop();
        navigateWithReplacementTo(
          context,
          PromoterEntityWorkerPage(promoterEntityWorker: res4.data!),
        );
        return;
      }

      var res2 = await auth.signinUserIntVolunteer(email, password);
      if (res2 is DataSuccess) {
        Navigator.of(context).pop();
        navigateWithReplacementTo(
          context,
          IntlVolunteerPage(intlVolunteer: res2.data!),
        );
        return;
      }

      var res3 = await auth.signinUserNatVolunteer(email, password);
      if (res3 is DataSuccess) {
        Navigator.of(context).pop();
        navigateWithReplacementTo(
          context,
          NatlVolunteerPage(natlVolunteer: res3.data!),
        );
        return;
      }

      Navigator.of(context).pop();
      showSnackBar(context, "ERRO:  ${res3.error!.message}");
    }
  }

  Container _buildIcon() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle,
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
