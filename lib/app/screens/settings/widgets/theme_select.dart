import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/device/repositories/repositories.dart';

class ThemeSelect extends ConsumerWidget {
  final GlobalKey<PopupMenuButtonState>? keyState;

  const ThemeSelect({Key? key, this.keyState}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeP = ref.watch(themeProvider);
    return ListTile(
      leading: const Icon(FontAwesomeIcons.lightbulb),
      title: Text("settings.theme.title".tr()),
      subtitle: Text("settings.theme.subtitle".tr()),
      onTap: keyState?.currentState?.showButtonMenu,
      trailing: PopupMenuButton(
        key: keyState,
        onSelected: (value) {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultRefNumber),
        ),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: Colors.transparent,
          child: Icon(
            themeP.name == THEMES.light.name
                ? Icons.brightness_5
                : themeP.name == THEMES.dark.name
                    ? Icons.brightness_2_outlined
                    : Icons.brightness_auto_outlined,
          ),
        ),
        itemBuilder: (_) => [ThemeMode.system, ThemeMode.light, ThemeMode.dark]
            .map(
              (e) => PopupMenuItem(
                child: ListTile(
                  onTap: () {
                    ref.read(themeProvider.notifier).set(themeMode: e);
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    e.name == THEMES.light.name
                        ? Icons.brightness_5
                        : e.name == THEMES.dark.name
                            ? Icons.brightness_2_outlined
                            : Icons.brightness_auto_outlined,
                  ),
                  title: Text("settings.theme.options.${e.name}".tr().toUpperCase()),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
