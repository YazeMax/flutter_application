// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/models/activity_report.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/activity_report_repository_impl.dart';

class ActivityReportListWidget extends StatefulWidget {
  const ActivityReportListWidget({
    super.key,
  });

  @override
  State<ActivityReportListWidget> createState() =>
      _ActivityReportListWidgetState();
}

class _ActivityReportListWidgetState extends State<ActivityReportListWidget> {
  ActivityReportRepositoryImpl repo = ActivityReportRepositoryImpl();
  List<ActivityReportModel> items = List.empty(growable: true);

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(gradient: kLightGradient),
      child: items.isEmpty
          ? const Center(
              child: Text('Nenhum Relatório de Actividades Encontrado'),
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
                        title: Text(items[index].type),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () => _showObjectDetails(items[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  _showObjectDetails(ActivityReportModel obj) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Detalhes"),
        content: Table(
          children: [
            buildTableRow("Tipo de Actividade: ", obj.type),
            buildTableRow("Local: ", obj.place),
            buildTableRow("Data: ", formatDate(obj.date)),
            buildTableRow("Dias de Duração: ", obj.durationInDays.toString()),
            buildTableRow(
                "Número de Participantes: ", obj.numOfParticipants.toString()),
            buildTableRow("Data de Início: ", formatDate(obj.startDate)),
            buildTableRow("Data de Término: ", formatDate(obj.finalDate)),
            buildTableRow("Entitidade Promotora: ", obj.promotingEntityName),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    var res = await repo.getActivityReport();
    if (res is DataSuccess) {
      setState(() {
        items = res.data!;
      });
    } else {
      showSnackBar(context, "ERRO:  ${res.error!.message!}");
    }
  }
}
