import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucio/app/screens/settings/widgets/backup.dart';
import 'package:lucio/app/screens/settings/widgets/biometric.dart';
import 'package:lucio/app/screens/settings/widgets/daysChangeWork.dart';
import 'package:lucio/app/screens/settings/widgets/google.dart';
import 'package:lucio/app/screens/settings/widgets/range_date_select.dart';
import 'package:lucio/app/screens/settings/widgets/theme_select.dart';
import 'package:lucio/app/screens/settings/widgets/units.dart';
import 'package:lucio/data/const.dart';

class SettingsPage extends StatefulWidget {
  static String name = 'SettingsPage';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<PopupMenuButtonState> key1 = GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: const [GoogleWidget(settings: false), SizedBox(width: kDefaultRefNumber)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(FontAwesomeIcons.lightbulb),
              title: const Text("Theme"),
              subtitle: const Text("Press to select theme of application"),
              trailing: ThemeSelect(keyState: key1),
              onTap: () => key1.currentState?.showButtonMenu(),
            ),
            const BiometricOption(),
            const BackUp(),
            const DaysOfChangeWorkProductionWidget(),
            const RangeDateSelectWidget(),
            const UnitsWidget()
          ],
        ),
      ),
    );
  }
}
