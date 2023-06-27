import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flash/flash.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:lucio/app/navigator.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/device/helpers/storage/secure.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum FlashType { success, error, info }

class Utils {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    await EasyLocalization.ensureInitialized();
    await dotenv.load();
    await SecureStorage.init();
    await DBHelper.init();
  }

  static BuildContext? currentContext(StateNotifierProviderRef? ref) => ref?.read(navigatorProvider).routeInformationParser.configuration.navigatorKey.currentContext;

  static showSnack(
    BuildContext context, {
    required String title,
    required String message,
    IconData? iconData,
    Duration? duration,
    FlashPosition flashPosition = FlashPosition.top,
    bool barrierDismissible = true,
    FlashType type = FlashType.info,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final color = type == FlashType.error
        ? scheme.error
        : type == FlashType.success
            ? Colors.green
            : scheme.primary;
    context.showFlash<bool>(
      barrierDismissible: barrierDismissible,
      duration: duration ?? const Duration(seconds: 5),
      builder: (context, controller) => FlashBar(
        controller: controller,
        forwardAnimationCurve: Curves.easeInCirc,
        reverseAnimationCurve: Curves.bounceIn,
        position: flashPosition,
        elevation: 10,
        showProgressIndicator: true,
        progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(color),
        icon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber),
          child: Icon(
            iconData ??
                (type == FlashType.success
                    ? Icons.done_all
                    : type == FlashType.error
                        ? Icons.error_outline
                        : Icons.tips_and_updates_outlined),
            color: color,
          ),
        ),
        title: Text(title, style: TextStyle(color: color)),
        content: Text(message, style: TextStyle(color: color)),
      ),
    );
  }
}

class DeviceInfoImpl {
  static DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> get deviceId async {
    String deviceId = 'Unknown';
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = '${androidInfo.model}${androidInfo.device}';
    }
    if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? '';
    }
    return deviceId;
  }

  static Future<int> get deviceSDK async {
    final androidInfo = await deviceInfoPlugin.androidInfo;
    int deviceSDK = androidInfo.version.sdkInt;
    return deviceSDK;
  }

  static Future<String?> get apkVersion async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
