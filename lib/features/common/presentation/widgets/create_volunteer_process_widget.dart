// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/constants/custom_regex.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/models/volunteer_process.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/volunteer_process_repository_impl.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/custom_text_form_field.dart';

class CreateVolunteerProcessWidget extends StatefulWidget {
  const CreateVolunteerProcessWidget({
    super.key,
  });

  @override
  State<CreateVolunteerProcessWidget> createState() =>
      _CreateVolunteerProcessWidgetState();
}

class _CreateVolunteerProcessWidgetState
    extends State<CreateVolunteerProcessWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  VolunteerProcessRepositoryImpl repo = VolunteerProcessRepositoryImpl();
  final TextEditingController operationAreaCtrlr = TextEditingController();
  final TextEditingController academicLevelCtrlr = TextEditingController();
  bool medicalCertificate = false;
  bool criminalRecord = false;

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
            children: [
              const SizedBox(height: 25),
              SizedBox(
                width: 400,
                child: CustomTextFormField(
                  obscureText: false,
                  textColor: Colors.black38,
                  borderColor: Colors.black38,
                  controller: operationAreaCtrlr,
                  hintText: "Insira a área de actuação",
                  labelText: "Área de Actuação",
                  regex: kNonBlankRegex,
                ),
              ),
              SizedBox(
                width: 400,
                child: CustomTextFormField(
                  obscureText: false,
                  textColor: Colors.black38,
                  borderColor: Colors.black38,
                  controller: academicLevelCtrlr,
                  hintText: "Insira o nível academico",
                  labelText: "Nível Academico",
                  regex: kNonBlankRegex,
                ),
              ),
              SizedBox(
                width: 400,
                child: CheckboxListTile(
                  title: const Text("Marque caso tenha um registro criminal"),
                  value: criminalRecord,
                  onChanged: (newValue) {
                    setState(() {
                      criminalRecord = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 400,
                child: CheckboxListTile(
                  title: const Text("Marque caso tenha um atestado médico"),
                  value: medicalCertificate,
                  onChanged: (newValue) {
                    setState(() {
                      medicalCertificate = newValue!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.save),
        onPressed: () => _saveProcess(),
        label: const Text("Salvar Processo"),
      ),
    );
  }

  _saveProcess() async {
    if (_formKey.currentState!.validate()) {
      var vp = VolunteerProcessModel(
        id: randomId(),
        activityArea: operationAreaCtrlr.text,
        criminalRecord: criminalRecord,
        medicalCertificate: medicalCertificate,
        academicLevel: academicLevelCtrlr.text,
      );
      showLoadingDialog(context);
      var res = await repo.createVolunteerProcess(vp);
      if (res is DataSuccess) {
        operationAreaCtrlr.clear();
        academicLevelCtrlr.clear();
        Navigator.of(context).pop();
        showSnackBar(context, "Processo salvo com sucesso!");
      } else {
        showSnackBar(context, "ERRO:  ${res.error!.message}!");
      }
    }
  }
}
