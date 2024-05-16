// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/constants/custom_regex.dart';
import 'package:flutter_application_1/core/constants/general.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/resources/enums/gender.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/data_sources/authentication/firebase_auth_service.dart';
import 'package:flutter_application_1/features/common/data/models/international_volunteer.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/international_volunteer_repository_impl.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/custom_dropdown_menu.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/data_selection_button.dart';

class CreateIntVolunteerWidget extends StatefulWidget {
  const CreateIntVolunteerWidget({
    super.key,
  });

  @override
  State<CreateIntVolunteerWidget> createState() =>
      _CreateIntVolunteerWidgetState();
}

class _CreateIntVolunteerWidgetState extends State<CreateIntVolunteerWidget> {
  final InternationalVolunteerRepositoryImpl repo = InternationalVolunteerRepositoryImpl();
  final FirebaseAuthService auth = FirebaseAuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrlr = TextEditingController();
  final TextEditingController emailCtrlr = TextEditingController();
  String selectedGender = "Masculino";
  DateTime birthDate = DateTime.now();
  final TextEditingController stayTimeCtrlr = TextEditingController();
  final TextEditingController contactCtrlr = TextEditingController();
  final TextEditingController passportNumCtrlr = TextEditingController();
  final TextEditingController nationalityCtrlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: kLightGradient),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 400,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: nameCtrlr,
                      hintText: "Insira o nome",
                      labelText: "Nome",
                      regex: kNameRegex,
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: emailCtrlr,
                      hintText: "Insira o email",
                      labelText: "Email",
                      regex: kEmailRegex,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDropdownMenu(
                    width: 285,
                    options: const ["Masculino", "Femenino"],
                    selected: selectedGender,
                    onChanged: (var newValue) {
                      setState(() {
                        selectedGender = newValue!;
                      });
                    },
                  ),
                  SizedBox(
                    width: 320,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: stayTimeCtrlr,
                      hintText: "Insira o tempo de estadia em dias",
                      labelText: "Tempo de Estadia",
                      regex: kStayTimeRegex,
                    ),
                  ),
                  DateSelectionButton(
                    title: "Data de Nascimento",
                    date: birthDate,
                    onTap: (selectedDate) {
                      setState(() => birthDate = selectedDate);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 280,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: contactCtrlr,
                      hintText: "Insira o contacto",
                      labelText: "Contacto",
                      regex: kPhoneNumberRegex,
                    ),
                  ),
                  SizedBox(
                    width: 255,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: passportNumCtrlr,
                      hintText: "Insira o número de passaporte",
                      labelText: "Número de Passaporte",
                      regex: kPassportNumRegex,
                    ),
                  ),
                  SizedBox(
                    width: 260,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: nationalityCtrlr,
                      hintText: "Insira a nacionalidade",
                      labelText: "Nacionalidade",
                      regex: kNonBlankRegex,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.save),
        onPressed: () => _saveIntVolunteer(),
        label: const Text("Salvar Voluntário"),
      ),
    );
  }

  _saveIntVolunteer() async {
    if (_formKey.currentState!.validate()) {
      InternationalVolunteerModel iv = InternationalVolunteerModel(
        passportNumber: passportNumCtrlr.text,
        stayTime: int.parse(stayTimeCtrlr.text),
        nationality: nationalityCtrlr.text,
        id: randomId(),
        name: nameCtrlr.text,
        birthDate: birthDate,
        phoneNumber: int.parse(contactCtrlr.text),
        gender: selectedGender == "Masculino" ? Gender.Masculino : Gender.Femenino,
        email: emailCtrlr.text,
        defaultPassword: kDefaultPassword
      );
      showLoadingDialog(context);
      var res = await repo.createInternationalVolunteer(iv);
      if (res is DataSuccess) {
        auth.createUser(iv.email, kDefaultPassword);
        passportNumCtrlr.clear();
        stayTimeCtrlr.clear();
        nationalityCtrlr.clear();
        nameCtrlr.clear();
        contactCtrlr.clear();
        emailCtrlr.clear();
        Navigator.of(context).pop();
        showSnackBar(context, "Voluntário Salvo Com Sucesso");
      } else {
        showSnackBar(context, "ERRO: ${res.error!.message}");
      }
    }
  }
}
