import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/core/constants/app_theme.dart';
import 'package:flutter_application_1/core/utils/utils.dart';
import 'package:flutter_application_1/features/common/data/models/promoter_entity_worker.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/activity_list_widget.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/activity_report_list_widget.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/allocation_list_widget.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/create_activity_report_widget.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/create_activity_widget.dart';
import 'package:flutter_application_1/features/common/presentation/widgets/create_allocation_widget.dart';

class PromoterEntityWorkerPage extends StatefulWidget {
  const PromoterEntityWorkerPage({
    super.key,
    required this.promoterEntityWorker,
  });

  final PromoterEntityWorkerModel promoterEntityWorker;

  @override
  State<PromoterEntityWorkerPage> createState() =>
      _PromoterEntityWorkerPageState();
}

class _PromoterEntityWorkerPageState extends State<PromoterEntityWorkerPage> {
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
            title: const Text("Funcionário da Entidade Promotora - Dashboard"),
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
                  title: "Alocações",
                  children: [
                    SideMenuItem(
                      title: 'Listar Alocações',
                      onTap: (index, _) => _changePage(index, _),
                    ),
                    SideMenuItem(
                      title: 'Criar Alocações',
                      onTap: (index, _) => _changePage(index, _),
                    ),
                  ],
                ),
                SideMenuExpansionItem(
                  icon: const Icon(Icons.list_alt_outlined),
                  title: "Actividades de Voluntariado",
                  children: [
                    SideMenuItem(
                      title: 'Listar Actividades',
                      onTap: (index, _) => _changePage(index, _),
                    ),
                    SideMenuItem(
                      title: 'Criar Actividades',
                      onTap: (index, _) => _changePage(index, _),
                    ),
                  ],
                ),
                SideMenuExpansionItem(
                  icon: const Icon(Icons.check_box),
                  title: "Relatório de Actividades",
                  children: [
                    SideMenuItem(
                      title: 'Listar Relatórios das Actividades',
                      onTap: (index, _) => _changePage(index, _),
                    ),
                    SideMenuItem(
                      title: 'Criar Relatórios das Actividades',
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
                AllocationListWidget(),
                CreateAllocationWidget(),
                ActivityListWidget(),
                CreateActivityWidget(),
                ActivityReportListWidget(),
                CreateActivityReportWidget(),
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
