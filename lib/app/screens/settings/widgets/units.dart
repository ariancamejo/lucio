import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lucio/app/screens/settings/unit/unit_page.dart';

class UnitsWidget extends StatelessWidget {
  const UnitsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.balanceScale),
      title: const Text("Unit of Measurement"),
      subtitle: const Text("Define which ones your app uses"),
      onTap: () {
        context.go(context.namedLocation(UnitPage.name));
      },
    );
  }
}
