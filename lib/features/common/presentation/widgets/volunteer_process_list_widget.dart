// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/models/volunteer_process.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/volunteer_process_repository_impl.dart';

class VolunteerProcessListWidget extends StatefulWidget {
  const VolunteerProcessListWidget({
    super.key,
  });

  @override
  State<VolunteerProcessListWidget> createState() =>
      _VolunteerProcessListWidgetState();
}

class _VolunteerProcessListWidgetState
    extends State<VolunteerProcessListWidget> {
  VolunteerProcessRepositoryImpl repo = VolunteerProcessRepositoryImpl();
  List<VolunteerProcessModel> items = List.empty(growable: true);

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: kLightGradient),
        child: items.isEmpty
            ? const Center(
                child: Text('Nenhum Processo Encontrado'),
              )
            : SizedBox(
                child: RefreshIndicator(
                  onRefresh: () => _fetchData(),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          title: Text(
                            "Processo #${items[index].id.toString()}",
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () => _showObjectDetails(items[index]),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }

  _showObjectDetails(VolunteerProcessModel obj) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Detalhes"),
        content: Table(
          children: [
            buildTableRow("Nível Academico: ", obj.academicLevel),
            buildTableRow("Area de Actuação: ", obj.activityArea),
            buildTableRow(
              "Registro Criminal: ",
              obj.criminalRecord ? "SIM" : "NÃO",
            ),
            buildTableRow(
              "Atestado Médico: ",
              obj.medicalCertificate ? "SIM" : "NÃO",
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    DataState<List<VolunteerProcessModel>> res =
        await repo.getVolunteerProcess();
    if (res is DataSuccess) {
      setState(() {
        items = res.data!;
      });
    } else {
      showSnackBar(context, "ERRO:  ${res.error!.message!}");
    }
  }
}
