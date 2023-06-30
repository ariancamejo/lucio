import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/app/home/drawer/drawer.dart';
import 'package:lucio/app/home/production/production_tab.dart';
import 'package:lucio/app/home/sales/sales_tab.dart';
import 'package:lucio/app/home/start/start_tab.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucio/app/screens/settings/widgets/google.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/google_auth/google_auth_provider.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/data/repositories/sales/sales_provider.dart';
import 'package:lucio/device/helpers/biometric/fingerprint.dart';
import 'package:lucio/device/helpers/storage/secure.dart';

class HomePage extends ConsumerStatefulWidget {
  static String name = "HomePage";

  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int currentIndex = 1;
  List<Widget> tabs = [
    FadeIn(key: const Key('1'), duration: const Duration(milliseconds: 200), child: const ProductionTab()),
    FadeIn(key: const Key('2'), duration: const Duration(milliseconds: 200), child: const StartTab()),
    FadeIn(key: const Key('3'), duration: const Duration(milliseconds: 200), child: const SalesTab()),
  ];

  _init() async {
    if (context.mounted) {
      checkAuth(
        ref,
        message: "Access to application",
        onSuccess: () {},
        useBiometric: true,
        obli: true,
      );
    }
  }

  @override
  void initState() {
    Future.microtask(() => _init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(kAppName),
        actions: const [GoogleWidget(),  SizedBox(width: kDefaultRefNumber,)],
      ),
      drawer: const MyDrawer(),
      drawerEdgeDragWidth: size.width / 5,
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: scheme.primary,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.production_quantity_limits), label: "Production"),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopify), label: "Sales"),
        ],
      ),
    );
  }
}
