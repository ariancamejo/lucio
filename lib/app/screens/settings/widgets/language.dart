import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/main.dart';

class LanguageSelect extends ConsumerWidget {
  final GlobalKey<PopupMenuButtonState>? keyState;
  final Function()? refreshState;

  const LanguageSelect({Key? key, this.keyState, this.refreshState}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text("settings.language.title".tr()),
      leading: const Icon(FontAwesomeIcons.language),
      subtitle: Text("settings.language.subtitle".tr()),
      onTap: keyState?.currentState?.showButtonMenu,
      trailing: PopupMenuButton(
        key: keyState,
        onSelected: (value) {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultRefNumber),
        ),
        child: CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage('assets/translations/${context.locale.languageCode}.png'),
        ),
        itemBuilder: (_) => locales
            .map(
              (e) => PopupMenuItem(
                child: ListTile(
                  onTap: () async {
                    Navigator.pop(context);
                    await context.setLocale(e);
                    refreshState?.call();
                  },
                  leading: SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset("assets/translations/${e.languageCode}.png"),
                  ),
                  title: Text("settings.language.options.${e.languageCode}".tr()),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
