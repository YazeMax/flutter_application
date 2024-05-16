// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/constants/custom_regex.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/models/allocation.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/allocation_repository_impl.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/data_selection_button.dart';

class CreateAllocationWidget extends StatefulWidget {
  const CreateAllocationWidget({
    super.key,
  });

  @override
  State<CreateAllocationWidget> createState() => _CreateAllocationWidgetState();
}

class _CreateAllocationWidgetState extends State<CreateAllocationWidget> {
  AllocationRepositoryImpl repo = AllocationRepositoryImpl();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController numVolunteersCtrlr = TextEditingController();
  final TextEditingController operationAreaCtrlr = TextEditingController();
  final TextEditingController trainingAreaCtrlr = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime finalDate = DateTime.now();

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
                      controller: operationAreaCtrlr,
                      hintText: "Insira a área de actuação",
                      labelText: "Área de actuação",
                      regex: kNonBlankRegex,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: trainingAreaCtrlr,
                      hintText: "Insira a área de formação",
                      labelText: "Área de formação",
                      regex: kNonBlankRegex,
                    ),
                  ),
                ],
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 275,
                    child: CustomTextFormField(
                      obscureText: false,
                      textColor: Colors.black38,
                      borderColor: Colors.black38,
                      controller: numVolunteersCtrlr,
                      hintText: "Insira o número de voluntários",
                      labelText: "Número de voluntários",
                      regex: kStayTimeRegex,
                    ),
                  ),
                  DateSelectionButton(
                    title: "Data de Início",
                    date: startDate,
                    onTap: (selectedDate) {
                      setState(() => startDate = selectedDate);
                    },
                  ),
                  const SizedBox(width: 10),
                  DateSelectionButton(
                    title: "Data de Fim",
                    date: finalDate,
                    onTap: (selectedDate) {
                      setState(() {
                        finalDate = selectedDate;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.save),
        onPressed: () => _saveAllocation(),
        label: const Text("Salvar Alocação"),
      ),
    );
  }

  _saveAllocation() async {
    if (_formKey.currentState!.validate()) {
      var allocation = AllocationModel(
        id: randomId(),
        numOfVolunteers: int.parse(numVolunteersCtrlr.text),
        trainingArea: trainingAreaCtrlr.text,
        operationsSector: operationAreaCtrlr.text,
        startDate: startDate,
        finalDate: finalDate,
      );
      showLoadingDialog(context);
      var res = await repo.createAllocation(allocation);
      if (res is DataSuccess) {
        numVolunteersCtrlr.clear();
        trainingAreaCtrlr.clear();
        operationAreaCtrlr.clear();
        Navigator.of(context).pop();
        showSnackBar(context, "Alocação salva com sucesso.");
      } else {
        showSnackBar(context, "ERRO: ${res.error!.message}");
      }
    }
  }
}
