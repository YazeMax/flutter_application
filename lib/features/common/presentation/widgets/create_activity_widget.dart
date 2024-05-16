// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/constants/custom_regex.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/models/volunteer_activity.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/volunteer_activity_repository_impl.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/data_selection_button.dart';

class CreateActivityWidget extends StatefulWidget {
  const CreateActivityWidget({
    super.key,
  });

  @override
  State<CreateActivityWidget> createState() => _CreateActivityWidgetState();
}

class _CreateActivityWidgetState extends State<CreateActivityWidget> {
  final TextEditingController typeCtrlr = TextEditingController();
  final TextEditingController locationCtrlr = TextEditingController();
  final TextEditingController durationCtrlr = TextEditingController();
  DateTime selectedDate = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VolunteerActivityRepositoryImpl repo =
      VolunteerActivityRepositoryImpl();

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
                      controller: typeCtrlr,
                      hintText: "Insira o tipo de actividade",
                      labelText: "Tipo de Actividade",
                      regex: kNonBlankRegex,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: locationCtrlr,
                      hintText: "Insira o local",
                      labelText: "Local",
                      regex: kNonBlankRegex,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 390,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: durationCtrlr,
                      hintText: "Insira duração em dias",
                      labelText: "Duração",
                      regex: kStayTimeRegex,
                    ),
                  ),
                  DateSelectionButton(
                    date: selectedDate,
                    onTap: (pickedDate) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
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
        onPressed: () => _saveActivity(),
        label: const Text("Salvar Actividade"),
      ),
    );
  }

  _saveActivity() async {
    if (_formKey.currentState!.validate()) {
      var va = VolunteerActivityModel(
        id: randomId(),
        type: typeCtrlr.text,
        place: locationCtrlr.text,
        date: selectedDate,
        durationInDays: int.parse(durationCtrlr.text),
      );
      showLoadingDialog(context);
      var res = await repo.createVolunteerActivity(va);
      if (res is DataSuccess) {
        typeCtrlr.clear();
        locationCtrlr.clear();
        durationCtrlr.clear();
        Navigator.of(context).pop();
        showSnackBar(context, "Voluntário Salvo Com Sucesso");
      } else {
        showSnackBar(context, "ERRO: ${res.error!.message}");
      }
    }
  }
}
