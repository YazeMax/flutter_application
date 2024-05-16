// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/models/national_volunteer.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/national_volunteer_repository_impl.dart';

class NatVolunteerListWidget extends StatefulWidget {
  const NatVolunteerListWidget({
    super.key,
  });

  @override
  State<NatVolunteerListWidget> createState() => _NatVolunteerListWidgetState();
}

class _NatVolunteerListWidgetState extends State<NatVolunteerListWidget> {
  NationalVolunteerRepositoryImpl repo = NationalVolunteerRepositoryImpl();
  List<NationalVolunteerModel> items = List.empty(growable: true);

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
                child: Text('Nenhum Voluntário Nacional Encontrado'),
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
                          title: Text(items[index].name),
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

  _showObjectDetails(NationalVolunteerModel obj) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Detalhes"),
        content: Table(
          children: [
            buildTableRow("Nome: ", obj.name),
            buildTableRow("Email: ", obj.email),
            buildTableRow("Genero: ", obj.gender.name),
            buildTableRow("Distrito: ", obj.district),
            buildTableRow("Província: ", obj.province),
            buildTableRow("Número de BI: ", obj.idNumber),
            buildTableRow("Agregado: ", obj.householdNumber.toString()),
            buildTableRow("Data de Nascimento: ", formatDate(obj.birthDate)),
            buildTableRow("Número de Telefone: ", obj.phoneNumber.toString()),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    DataState<List<NationalVolunteerModel>> res =
        await repo.getNationalVolunteer();
    if (res is DataSuccess) {
      setState(() {
        items = res.data!;
      });
    } else {
      showSnackBar(context, "ERRO:  ${res.error!.message!}");
    }
  }
}
