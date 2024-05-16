// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/models/allocation.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/allocation_repository_impl.dart';

class AllocationListWidget extends StatefulWidget {
  const AllocationListWidget({
    super.key,
  });

  @override
  State<AllocationListWidget> createState() => _AllocationListWidgetState();
}

class _AllocationListWidgetState extends State<AllocationListWidget> {
  AllocationRepositoryImpl repo = AllocationRepositoryImpl();
  List<AllocationModel> items = List.empty(growable: true);

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
                child: Text('Nenhuma Alocação Encontrada'),
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
                            "Data de Início: ${formatDate(items[index].startDate)}",
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

  _showObjectDetails(AllocationModel obj) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Detalhes"),
        content: Table(
          children: [
            buildTableRow(
              "Número de Voluntários: ",
              obj.numOfVolunteers.toString(),
            ),
            buildTableRow("Área de Formação: ", obj.trainingArea),
            buildTableRow("Área de Actuação: ", obj.operationsSector),
            buildTableRow("Data de Início: ", formatDate(obj.startDate)),
            buildTableRow("Data de Término: ", formatDate(obj.finalDate)),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    DataState<List<AllocationModel>> res = await repo.getAllocation();
    if (res is DataSuccess) {
      setState(() {
        items = res.data!;
      });
    } else {
      showSnackBar(context, "ERRO:  ${res.error!.message!}");
    }
  }
}
