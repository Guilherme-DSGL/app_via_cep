import 'package:app_via_cep/models/cep.dart';
import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';
import 'components/card_comp.dart';
import 'components/dialog_component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = HomeController();
  @override
  void initState() {
    _homeController.getHistory();
    _homeController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CEP"),
      ),
      body: ListView.builder(
        itemCount: _homeController.ceps.length,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => CardComponent(
          cep: _homeController.ceps[index],
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              return _homeController
                  .deleteCep(_homeController.ceps[index].objectId!);
            } else if (direction == DismissDirection.startToEnd) {
              showDialog(
                  context: context,
                  builder: (context) => DialogComponent(
                        objectId: _homeController.ceps[index].objectId,
                      )).then(
                  (cep) => cep != Cep() ? _homeController.addCep(cep) : null);
              return false;
            }
            return null;
          },
          onDismissed: (direction) {
            _homeController.removeCep(_homeController.ceps[index].objectId!);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
                  context: context,
                  builder: (context) => const DialogComponent())
              .then((cep) => cep != Cep() ? _homeController.addCep(cep) : null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
