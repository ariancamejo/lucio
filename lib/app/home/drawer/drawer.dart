import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lucio/app/screens/consume_materials/consume_materials_page.dart';
import 'package:lucio/app/screens/employee/employee_page.dart';
import 'package:lucio/app/screens/materials/materials_page.dart';
import 'package:lucio/app/screens/settings/settings_page.dart';
import 'package:lucio/app/screens/type_of_production/type_of_production_page.dart';
import 'package:lucio/app/screens/type_of_sale/type_of_sale_page.dart';
import 'package:lucio/device/repositories/repositories.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    final theme = ref.watch(themeProvider);

    final size = MediaQuery.of(context).size;
    return Drawer(
      child: SizedBox(
        height: size.height,
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icon.png"),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(child: SizedBox(height: double.maxFinite)),
                        InkWell(
                          onTap: () => ref.read(themeProvider.notifier).set(themeMode: brightness == Brightness.light ? ThemeMode.dark : ThemeMode.light),
                          child: Icon(theme.name == 'system'
                              ? Icons.brightness_auto
                              : brightness == Brightness.light
                                  ? Icons.brightness_4_outlined
                                  : Icons.brightness_4),
                        )
                      ],
                    ),
                  ),
                  Text("home.drawer.app".tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.helmetSafety),
                    title: Text("home.drawer.employees".tr()),
                    onTap: () {
                      Navigator.pop(context);
                      context.go(context.namedLocation(EmployeePage.name));
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.recycle),
                    title: Text("home.drawer.materials_consumption".tr()),
                    onTap: () {
                      Navigator.pop(context);
                      context.go(context.namedLocation(ConsumeMaterialsPage.name));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.industry),
                    title: Text("home.drawer.productions_type".tr()),
                    onTap: () {
                      Navigator.pop(context);
                      context.go(context.namedLocation(TypeOfProductionPage.name));
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.tag),
                    title: Text("home.drawer.sales_type".tr()),
                    onTap: () {
                      Navigator.pop(context);
                      context.go(context.namedLocation(TypeOfSalePage.name));
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.trowelBricks),
                    title: Text("home.drawer.materials".tr()),
                    onTap: () {
                      Navigator.pop(context);
                      context.go(context.namedLocation(MaterialsPage.name));
                    },
                  )
                ],
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(FontAwesomeIcons.cogs),
              title: Text("settings.title".tr()),
              onTap: () {
                Navigator.pop(context);
                context.go(context.namedLocation(SettingsPage.name));
              },
            ),
          ],
        ),
      ),
    );
  }
}
