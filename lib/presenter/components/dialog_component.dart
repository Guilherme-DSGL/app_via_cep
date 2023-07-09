import 'package:app_via_cep/controllers/dialog_controller.dart';
import 'package:flutter/material.dart';

class DialogComponent extends StatefulWidget {
  const DialogComponent({super.key, this.objectId});
  final String? objectId;
  @override
  State<DialogComponent> createState() => _DialogComponentState();
}

class _DialogComponentState extends State<DialogComponent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cep = TextEditingController();
  final DialogController _dialogController = DialogController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          height: 220,
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _cep,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        label: Text("Cep"),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, informe um cep";
                        } else if (value.length != 8) {
                          return "Por favor, informe 8 caracteres";
                        }
                        return null;
                      },
                    ),
                    const Spacer(),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                            onPressed: () async {
                              if ((_formKey.currentState?.validate() ??
                                      false) &&
                                  !_dialogController.isLoading) {
                                String? cepSent =
                                    await _dialogController.sendCep(
                                        cepCode: _cep.text,
                                        objectId: widget.objectId);
                                if (cepSent == null && context.mounted) {
                                  Navigator.pop(context, _dialogController.cep);
                                } else {
                                  _showSnackBar(context, cepSent!);
                                }
                              }
                            },
                            child: const Text("Pesquisar")))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_showSnackBar(context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: const Duration(seconds: 3),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {},
    ),
  ));
}
