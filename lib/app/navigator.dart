import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucio/app/home/home_page.dart';
import 'package:lucio/app/screens/404/not_found.dart';
import 'package:lucio/app/screens/consume_materials/consume_materials_page.dart';
import 'package:lucio/app/screens/employee/employee_page.dart';
import 'package:lucio/app/screens/employee/plan/plan_page.dart';
import 'package:lucio/app/screens/materials/materials_page.dart';
import 'package:lucio/app/screens/settings/settings_page.dart';
import 'package:lucio/app/screens/settings/unit/unit_page.dart';
import 'package:lucio/app/screens/type_of_production/type_of_production_page.dart';
import 'package:lucio/app/screens/type_of_sale/type_of_sale_page.dart';

import 'package:riverpod/riverpod.dart';

final navigatorProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier();

  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: router,
    redirect: router._redirectLogic,
    routes: router._routes,
    errorBuilder: (context, state) => NotFoundPage(state: state),
  );
});

class RouterNotifier extends ChangeNotifier {
  Future<String?> _redirectLogic(BuildContext context, GoRouterState state) async {
    return null;
  }

  List<GoRoute> get _routes => [
        GoRoute(
          name: HomePage.name,
          path: '/',
          builder: (context, _) => const HomePage(),
          routes: [
            GoRoute(
              name: SettingsPage.name,
              path: 'settings',
              pageBuilder: (context, _) => slideTransition(const SettingsPage(), _),
              routes: [
                GoRoute(
                  name: UnitPage.name,
                  path: 'units',
                  pageBuilder: (context, _) => slideTransition(const UnitPage(), _),
                ),
              ],
            ),
            GoRoute(
              name: MaterialsPage.name,
              path: 'materials',
              pageBuilder: (context, _) => slideTransition(const MaterialsPage(), _),
            ),
            GoRoute(
              name: ConsumeMaterialsPage.name,
              path: 'materials_consume',
              pageBuilder: (context, _) => slideTransition(const ConsumeMaterialsPage(), _),
            ),
            GoRoute(
              name: TypeOfSalePage.name,
              path: 'type_of_sale',
              pageBuilder: (context, _) => slideTransition(const TypeOfSalePage(), _),
            ),
            GoRoute(
              name: TypeOfProductionPage.name,
              path: 'type_of_production',
              pageBuilder: (context, _) => slideTransition(const TypeOfProductionPage(), _),
            ),
            GoRoute(
              name: EmployeePage.name,
              path: 'employee',
              pageBuilder: (context, _) => slideTransition(const EmployeePage(), _),
              routes: [
                GoRoute(
                  name: PlanPage.name,
                  path: 'plan',
                  pageBuilder: (context, _) => slideTransition(const PlanPage(), _),
                )
              ],
            ),
          ],
        ),
      ];
}

fadeTransition(Widget page, GoRouterState state, {Cubic? curves}) => CustomTransitionPage(
      key: state.pageKey,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
        opacity: CurveTween(curve: curves ?? Curves.easeInOut).animate(animation),
        child: child,
      ),
    );

scaleTransition(Widget page, GoRouterState state, {Cubic? curves, Alignment? alignment, Offset? offset}) => CustomTransitionPage(
      key: state.pageKey,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => ScaleTransition(
        alignment: alignment ?? Alignment.center,
        scale: Tween<double>(begin: offset?.dx ?? 0.0, end: offset?.dy ?? 1.0).animate(CurvedAnimation(parent: animation, curve: curves ?? Curves.easeInOut)),
        child: child,
      ),
    );

slideTransition(Widget page, GoRouterState state, {Cubic? curves, Offset? offset}) => CustomTransitionPage(
      key: state.pageKey,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
        position: Tween<Offset>(begin: offset ?? const Offset(1.0, 0.0), end: Offset.zero).animate(CurvedAnimation(parent: animation, curve: curves ?? Curves.easeInOut)),
        child: child,
      ),
    );

sizeTransition(Widget page, GoRouterState state, {Cubic? curves, Offset? offset}) => CustomTransitionPage(
      key: state.pageKey,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => SizeTransition(
        sizeFactor: Tween<double>(begin: offset?.dx ?? 0.0, end: offset?.dy ?? 1.0).animate(CurvedAnimation(parent: animation, curve: curves ?? Curves.easeInOutCirc)),
        axisAlignment: 0.0,
        child: child,
      ),
    );
