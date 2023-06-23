import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/app/navigator.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/rlp_provider.dart';
import 'package:lucio/device/device.dart';
import 'package:lucio/device/helpers/biometric/fingerprint.dart';
import 'package:lucio/device/helpers/storage/secure.dart';
import 'package:lucio/device/helpers/theme/theme.dart';
import 'package:lucio/device/repositories/repositories.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

void main() async => await Utils.init().then(
      (value) => runApp(const ProviderScope(child: KeyboardVisibilityProvider(child: MainApp()))),
    );

class MainApp extends ConsumerStatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    debugPrint("InitState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("DidChangeDependencies");
  }

  @override
  void setState(fn) {
    debugPrint("SetState");
    super.setState(fn);
  }

  @override
  void deactivate() {
    debugPrint("Deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    debugPrint("Dispose");
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        debugPrint('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        var context = ref.read(navigatorProvider).routeInformationParser.configuration.navigatorKey.currentContext;
        String? pin = await SecureStorage.read('pin');
        String? checkAuthHome = await SecureStorage.read('checkAuthHome');
        if (context != null && pin != null && checkAuthHome == null) {
          if (context.mounted) {
            checkAuth(
              context,
              onSuccess: () {
                debugPrint("OK");
              },
              useBiometric: true,
              obli: true,
            );
          }
        }
        debugPrint('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        debugPrint('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        debugPrint('appLifeCycleState detached');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(navigatorProvider);
    final theme = ref.watch(themeProvider);
    return MaterialApp.router(
      //ROUTER

      title: kAppName,
      debugShowCheckedModeBanner: false,
      //NAVIGATOR
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      //LOCALE
      // locale: context.locale,
      // supportedLocales: context.supportedLocales,
      // localizationsDelegates: context.localizationDelegates,
      // localeResolutionCallback: (locale, __) => locale,
      //THEME
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      themeMode: theme,
      //RESPONSIBE
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: Scaffold(
          body: Stack(
            children: [if (child != null) child, const RequestLoadingWidget()],
          ),
        ),
        breakpoints: [
          const Breakpoint(start: 0, end: 800, name: MOBILE),
          const Breakpoint(start: 801, end: 1200, name: TABLET),
          const Breakpoint(start: 1201, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}
