// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/models/volunteer_activity.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/volunteer_activity_repository_impl.dart';

class ActivityListWidget extends StatefulWidget {
  const ActivityListWidget({
    super.key,
  });

  @override
  State<ActivityListWidget> createState() => _ActivityListWidgetState();
}

class _ActivityListWidgetState extends State<ActivityListWidget> {
  final VolunteerActivityRepositoryImpl repo =
      VolunteerActivityRepositoryImpl();
  List<VolunteerActivityModel> items = List.empty(growable: true);

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
              child: Text('Nenhuma Actividade de Voluntariado Encontrada'),
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
                          "${items[index].type}, ${items[index].place}",
                        ),
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

  _showObjectDetails(VolunteerActivityModel obj) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Detalhes"),
        content: Table(
          children: [
            buildTableRow("Tipo de Actividade: ", obj.type),
            buildTableRow("Local: ", obj.place),
            buildTableRow("Data de Ocorrência: ", formatDate(obj.date)),
            buildTableRow("Dias de Duração: ", obj.durationInDays.toString()),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    var res = await repo.getVolunteerActivity();
    if (res is DataSuccess) {
      setState(() {
        items = res.data!;
      });
    } else {
      showSnackBar(context, "ERRO:  ${res.error!.message!}");
    }
  }
}
