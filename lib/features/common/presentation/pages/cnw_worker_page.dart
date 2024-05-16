// ignore_for_file: use_build_context_synchronously

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/models/cnv_worker.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/allocation_list_widget.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/create_allocation_widget.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/create_int_volunteer_widget.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/create_volunteer_process_widget.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/int_volunteer_list_widget.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/nat_volunteer_list_widget.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/volunteer_process_list_widget.dart';

import '../widgets/create_nat_volunteer_widget.dart';

class CnvWorkerPage extends StatefulWidget {
  const CnvWorkerPage({super.key, required this.cnvWorker});

  final CnvWorkerModel cnvWorker;

  @override
  State<CnvWorkerPage> createState() => _CnvWorkerPageState();
}

class _CnvWorkerPageState extends State<CnvWorkerPage> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
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
            title: const Text("Funcionário do CNV - Dashboard"),
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
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
            ),
            child: SideMenu(
              controller: sideMenu,
              items: [
                SideMenuExpansionItem(
                  icon: const Icon(Icons.person),
                  title: "Gerir Voluntários",
                  children: [
                    SideMenuItem(
                      title: 'Listar Voluntários Internacionais',
                      onTap: (index, _) => _changePage(index, _),
                    ),
                    SideMenuItem(
                      title: 'Criar Voluntários Internacionais',
                      onTap: (index, _) => _changePage(index, _),
                    ),
                    SideMenuItem(
                      title: 'Listar Voluntários Nacionais',
                      onTap: (index, _) => _changePage(index, _),
                    ),
                    SideMenuItem(
                      title: 'Criar Voluntários Nacionais',
                      onTap: (index, _) => _changePage(index, _),
                    ),
                  ],
                ),
                SideMenuExpansionItem(
                  icon: const Icon(Icons.list_alt_outlined),
                  title: "Processos de Voluntários",
                  children: [
                    SideMenuItem(
                      title: 'Listar Processos',
                      onTap: (index, _) => _changePage(index, _),
                    ),
                    SideMenuItem(
                      title: 'Criar Processo',
                      onTap: (index, _) => _changePage(index, _),
                    ),
                  ],
                ),
                SideMenuExpansionItem(
                  icon: const Icon(Icons.check_box),
                  title: "Gestão de Alocações",
                  children: [
                    SideMenuItem(
                      title: 'Listar Alocações',
                      onTap: (index, _) => _changePage(index, _),
                    ),
                    SideMenuItem(
                      title: 'Criar Alocação',
                      onTap: (index, _) => _changePage(index, _),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: const [
                IntVolunteerListWidget(),
                CreateIntVolunteerWidget(),
                NatVolunteerListWidget(),
                CreateNatVolunteerWidget(),
                VolunteerProcessListWidget(),
                CreateVolunteerProcessWidget(),
                AllocationListWidget(),
                CreateAllocationWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _changePage(int index, SideMenuController _) {
    sideMenu.changePage(index);
    pageController.jumpTo(index.toDouble());
  }

}
