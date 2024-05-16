// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/constants/custom_regex.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/resources/enums/gender.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/models/cnv_worker.dart';
import 'package:flutter_application_1/features/common/data/models/promoter_entity_worker.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/user_auth_repository_impl.dart';
import 'package:flutter_application_1/features/common/presentation/pages/cnw_worker_page.dart';
import 'package:flutter_application_1/features/common/presentation/pages/promoter_entity_worker_page.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/custom_dropdown_menu.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/custom_text_form_field.dart';

import '../widgets/data_selection_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrlr = TextEditingController();
  final TextEditingController passwordCtrlr = TextEditingController();
  final TextEditingController emailCtrlr = TextEditingController();
  final TextEditingController idNumberCtrlr = TextEditingController();
  final TextEditingController contactCtrlr = TextEditingController();
  final TextEditingController postionCtrlr = TextEditingController();
  DateTime birthDate = DateTime.now();
  String selectedGender = "Masculino";
  String workerType = "Funcionário do CNV";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(gradient: kGradient),
          child: AppBar(
            title: const Text("Registro"),
            elevation: 10,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () => _createAccount(),
                  icon: const Icon(Icons.save),
                  label: const Text("Criar Conta"),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: kLightGradient),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 400,
                    child: CustomTextFormField(
                      obscureText: true,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: passwordCtrlr,
                      hintText: "Enter your password",
                      labelText: "Palavra-passe",
                      regex: kPasswordRegex,
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    child: CustomTextFormField(
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: emailCtrlr,
                      hintText: "Insira o teu email",
                      labelText: "Email",
                      regex: kEmailRegex,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 400,
                    child: CustomTextFormField(
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: nameCtrlr,
                      hintText: "Insira o teu nome",
                      labelText: "Nome",
                      regex: kNameRegex,
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    child: CustomTextFormField(
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: contactCtrlr,
                      hintText: "Insira o teu número de telefone",
                      labelText: "Número de telefone",
                      regex: kPhoneNumberRegex,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 400,
                    child: CustomTextFormField(
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: postionCtrlr,
                      hintText: "Insira o cargo",
                      labelText: "Cargo",
                      regex: kNonBlankRegex,
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    child: CustomTextFormField(
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: idNumberCtrlr,
                      hintText: "Insira o número de BI",
                      labelText: "Número de BI",
                      regex: kIdNumberRegex,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text("Sexo"),
                      ),
                      CustomDropdownMenu(
                        width: 270,
                        options: const ["Masculino", "Femenino"],
                        selected: selectedGender,
                        onChanged: (var newValue) {
                          setState(() {
                            selectedGender = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text("Tipo de Funcionário"),
                      ),
                      CustomDropdownMenu(
                        width: 295,
                        options: const [
                          "Funcionário do CNV",
                          "Funcionário da Entidade Promotora"
                        ],
                        selected: workerType,
                        onChanged: (var newValue) {
                          setState(() {
                            workerType = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text("Data de Nascimento"),
                      ),
                      const SizedBox(height: 8),
                      DateSelectionButton(
                        date: birthDate,
                        title: "Data de Nascimento",
                        onTap: (selectedDate) {
                          setState(() => birthDate = selectedDate);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createAccount() async {
    if (_formKey.currentState!.validate()) {
      int id = randomId();
      String name = nameCtrlr.text;
      String email = emailCtrlr.text;
      String idNumber = idNumberCtrlr.text;
      Gender gender =
          selectedGender == "Masculino" ? Gender.Masculino : Gender.Femenino;
      int phoneNumber = int.parse(contactCtrlr.text);
      String position = postionCtrlr.text;
      String password = passwordCtrlr.text;

      UserAuthRepositoryImpl auth = UserAuthRepositoryImpl();
      if (workerType == "Funcionário da Entidade Promotora") {
        PromoterEntityWorkerModel pew = PromoterEntityWorkerModel(
          id: id,
          name: name,
          email: email,
          idNumber: idNumber,
          gender: gender,
          phoneNumber: phoneNumber,
          position: position,
        );
        await showLoadingDialog(context);
        var res = await auth.signupUserPromEntWorker(pew, password);
        Navigator.of(context).pop();
        if (res is DataSuccess) {
          navigateWithReplacementTo(
            context,
            PromoterEntityWorkerPage(promoterEntityWorker: res.data!),
          );
        } else {
          showSnackBar(context, "ERRO:  ${res.error!.message}");
        }
      } else {
        CnvWorkerModel cw = CnvWorkerModel(
          id: id,
          name: name,
          email: email,
          idNumber: idNumber,
          gender: gender,
          phoneNumber: phoneNumber,
          position: position,
        );
        var res = await auth.signupUserCnvWorker(cw, password);
        Navigator.of(context).pop();
        if (res is DataSuccess) {
          navigateWithReplacementTo(
            context,
            CnvWorkerPage(cnvWorker: res.data!),
          );
        } else {
          showSnackBar(context, "ERRO:  ${res.error!.message}");
        }
      }
    }
  }
}
