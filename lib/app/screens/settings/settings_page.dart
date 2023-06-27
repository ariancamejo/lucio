import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucio/app/screens/settings/widgets/backup.dart';
import 'package:lucio/app/screens/settings/widgets/biometric.dart';
import 'package:lucio/app/screens/settings/widgets/daysChangeWork.dart';
import 'package:lucio/app/screens/settings/widgets/google.dart';
import 'package:lucio/app/screens/settings/widgets/language.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings.title".tr()),
        actions: const [GoogleWidget(settings: false), SizedBox(width: kDefaultRefNumber)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ThemeSelect(keyState: GlobalKey()),
            LanguageSelect(keyState: GlobalKey(), refreshState: () => setState(() {})),
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
