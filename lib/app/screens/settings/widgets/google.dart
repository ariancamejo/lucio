import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lucio/app/screens/settings/settings_page.dart';
import 'package:lucio/data/repositories/google_auth/google_auth_provider.dart';

class GoogleWidget extends ConsumerWidget {
  final bool settings;

  const GoogleWidget({Key? key, this.settings = true}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final user = ref.watch(googleAuthProvider);
    return PopupMenuButton(
      onSelected: (value) {
        switch (value) {
          case 0:
            ref.read(googleAuthProvider.notifier).login();
            break;
          case 1:
            ref.read(googleAuthProvider.notifier).logout();
            break;
          case 2:
            context.go(context.namedLocation(SettingsPage.name));
            break;
          default:
            break;
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: user == null ? 0 : 1,
          child: ListTile(
            title: Text(user == null ? "SignIn" : "SignOut"),
            trailing: Icon(user == null ? FontAwesomeIcons.signIn : FontAwesomeIcons.signOut),
          ),
        ),
        if (settings)
          const PopupMenuItem(
            value: 2,
            child: ListTile(
              title: Text("Settings"),
              trailing: Icon(FontAwesomeIcons.cogs),
            ),
          ),
      ],
      icon: CachedNetworkImage(
        imageUrl: user?.photoUrl ?? "http://server.image",
        imageBuilder: (_, image) => CircleAvatar(
          backgroundColor: scheme.primary,
          backgroundImage: image,
        ),
        placeholder: (_, __) => const CircleAvatar(
          child: Stack(
            children: [Center(child: CircularProgressIndicator(strokeWidth: 1)), Center(child: Icon(FontAwesomeIcons.google))],
          ),
        ),
        errorWidget: (_, __, ___) => CircleAvatar(
          child: user?.displayName == null ? const Icon(FontAwesomeIcons.google) : Text(user!.displayName![0].toUpperCase()),
        ),
      ),
    );
  }
}
