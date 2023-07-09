import 'package:app_via_cep/models/cep.dart';
import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  const CardComponent(
      {super.key,
      required this.cep,
      required this.confirmDismiss,
      required this.onDismissed});

  final Cep cep;
  final Future<bool?> Function(DismissDirection)? confirmDismiss;
  final void Function(DismissDirection)? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: confirmDismiss,
      crossAxisEndOffset: 0.1,
      key: Key(cep.objectId!),
      secondaryBackground: Card(
        color: Colors.red[300]!,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
        ),
      ),
      background: Card(
        color: Colors.blue[300]!,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
        ),
      ),
      onDismissed: onDismissed,
      child: Container(
        child: SizedBox(
            height: 75,
            child: Card(
                color: Colors.blue[300]!,
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          cep.objectId ?? "",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Spacer(),
                      Text(
                        cep.cep ?? "",
                        style: const TextStyle(fontSize: 19),
                      )
                    ],
                  ),
                ))),
      ),
    );
  }
}
