// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/models/international_volunteer.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/international_volunteer_repository_impl.dart';

class IntVolunteerListWidget extends StatefulWidget {
  const IntVolunteerListWidget({
    super.key,
  });

  @override
  State<IntVolunteerListWidget> createState() => _IntVolunteerListWidgetState();
}

class _IntVolunteerListWidgetState extends State<IntVolunteerListWidget> {
  final InternationalVolunteerRepositoryImpl repo =
      InternationalVolunteerRepositoryImpl();
  List<InternationalVolunteerModel> items = List.empty(growable: true);

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
              child: Text('Nenhum Voluntário Internacional Encontrado'),
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
    );
  }

  _showObjectDetails(InternationalVolunteerModel obj) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Detalhes"),
        content: Table(
          children: [
            buildTableRow("Nome: ", obj.name),
            buildTableRow("Email: ", obj.email),
            buildTableRow("Genero: ", obj.gender.name),
            buildTableRow("Tempo de Estadia: ", obj.stayTime.toString()),
            buildTableRow("Contacto: ", obj.phoneNumber.toString()),
            buildTableRow("Passaporte: ", obj.passportNumber.toString()),
            buildTableRow("Nacionalidade: ", obj.nationality),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    DataState<List<InternationalVolunteerModel>> res =
        await repo.getInternationalVolunteer();
    if (res is DataSuccess) {
      setState(() {
        items = res.data!;
      });
    } else {
      showSnackBar(context, "ERRO:  ${res.error!.message!}");
    }
  }
}
