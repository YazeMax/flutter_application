// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/constants/custom_regex.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/models/activity_report.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/activity_report_repository_impl.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/data_selection_button.dart';

class CreateActivityReportWidget extends StatefulWidget {
  const CreateActivityReportWidget({
    super.key,
  });

  @override
  State<CreateActivityReportWidget> createState() =>
      _CreateActivityReportWidgetState();
}

class _CreateActivityReportWidgetState
    extends State<CreateActivityReportWidget> {
  final ActivityReportRepositoryImpl repo = ActivityReportRepositoryImpl();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController activityTypeCtrlr = TextEditingController();
  final TextEditingController locationCtrlr = TextEditingController();
  DateTime occurenceDate = DateTime.now();
  final TextEditingController durationCtrlr = TextEditingController();
  final TextEditingController numOfParticipantsCtrlr = TextEditingController();
  DateTime initialDate = DateTime.now();
  DateTime finalDate = DateTime.now();
  final TextEditingController promEntityCtrlr = TextEditingController();

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
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 300,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: activityTypeCtrlr,
                      hintText: "Insira o tipo de actividade",
                      labelText: "Tipo de Acitividade",
                      regex: kNonBlankRegex,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: locationCtrlr,
                      hintText: "Insira a localização",
                      labelText: "Localização",
                      regex: kNonBlankRegex,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 200,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: durationCtrlr,
                      hintText: "Dias de duração",
                      labelText: "Duração",
                      regex: kStayTimeRegex,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: numOfParticipantsCtrlr,
                      hintText: "Insira o número de participantes",
                      labelText: "Número de Participantes",
                      regex: kDigitsRegex,
                    ),
                  ),
                  DateSelectionButton(
                    title: "Data de Ocorrência",
                    date: occurenceDate,
                    onTap: (selectedDate) {
                      setState(() => occurenceDate = selectedDate);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 260,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: promEntityCtrlr,
                      hintText: "Insira o nome da entidade promotora",
                      labelText: "Entidade Promotora",
                      regex: kStringRegex,
                    ),
                  ),
                  DateSelectionButton(
                    title: "Data de Início",
                    date: initialDate,
                    onTap: (selectedDate) {
                      setState(() => initialDate = selectedDate);
                    },
                  ),
                  const SizedBox(width: 10),
                  DateSelectionButton(
                    title: "Data de Fim",
                    date: finalDate,
                    onTap: (selectedDate) {
                      setState(() => finalDate = selectedDate);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.save),
        onPressed: () => _saveReport(),
        label: const Text("Salvar Relatório"),
      ),
    );
  }

  _saveReport() async {
    if (_formKey.currentState!.validate()) {
      var ar = ActivityReportModel(
        id: randomId(),
        type: activityTypeCtrlr.text,
        place: locationCtrlr.text,
        date: occurenceDate,
        durationInDays: int.parse(durationCtrlr.text),
        numOfParticipants: int.parse(numOfParticipantsCtrlr.text),
        startDate: initialDate,
        finalDate: finalDate,
        promotingEntityName: promEntityCtrlr.text,
      );
      showLoadingDialog(context);
      var res = await repo.createActivityReport(ar);
      if (res is DataSuccess) {
        activityTypeCtrlr.clear();
        locationCtrlr.clear();
        durationCtrlr.clear();
        numOfParticipantsCtrlr.clear();
        promEntityCtrlr.clear();
        Navigator.of(context).pop();
        showSnackBar(context, "Relatório Salvo Com Sucesso");
      } else {
        showSnackBar(context, "ERRO: ${res.error!.message}");
      }
    }
  }
}
