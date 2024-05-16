// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/data_sources/authentication/firebase_auth_service.dart';
import 'package:flutter_application_1/features/common/data/models/allocation.dart';
import 'package:flutter_application_1/features/common/data/models/international_volunteer.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/allocation_repository_impl.dart';

class IntlVolunteerPage extends StatefulWidget {
  const IntlVolunteerPage({super.key, required this.intlVolunteer});

  final InternationalVolunteerModel intlVolunteer;

  @override
  State<IntlVolunteerPage> createState() => _IntlVolunteerPageState();
}

class _IntlVolunteerPageState extends State<IntlVolunteerPage> {
  AllocationRepositoryImpl repo = AllocationRepositoryImpl();
  List<AllocationModel> items = List.empty(growable: true);

  FirebaseAuthService auth = FirebaseAuthService();

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(gradient: kGradient),
          child: AppBar(
            title: const Text("Voluntário Internacional - Dashboard"),
            elevation: 10,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () => signOut(context),
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text("Terminar Sessão"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () => _resetPassword(),
                  icon: const Icon(Icons.lock_reset_rounded),
                  label: const Text("Actualizar Palavra-Passe"),
                ),
              ),
            ],
          ),
        ),
      ),
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

  void _resetPassword() {
    auth.resetPassord(widget.intlVolunteer.email);
    _showConfirmationDialog();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Mudar Palavra-Passe"),
        actions: [
          TextButton(
            onPressed: () => _confirmReset(context),
            child: const Text("Ok"),
          ),
        ],
        content: const Center(
          child: Text("Veja o link enviado para o seu email."),
        ),
      ),
    );
  }

  Future<void> _confirmReset(BuildContext context) async {
    showSnackBar(context, "Inicie sessão novamente.");
    Future.delayed(const Duration(seconds: 5))
        .then((value) => signOut(context));
    /* var res = await auth.confirmPassordReset(
      _codeController.text,
      _passwordController.text,
    );
    if (res is DataSuccess) {
      Navigator.of(context).pop();
      showSnackBar(context, "Confirmado, inicie sessão novamente.");
      Future.delayed(const Duration(seconds: 5))
          .then((value) => signOut(context));
    } else {
      showSnackBar(context, "ERRO: ${res.error!.message}.");
    } */
  }

  Future<void> _fetchData() async {
    DataState<List<AllocationModel>> res = await repo.getAllocation();
    if (res is DataSuccess) {
      setState(() {
        items = res.data!; //TODO: FILTER
      });
    } else {
      showSnackBar(context, "ERRO:  ${res.error!.message!}");
    }
  }
}
