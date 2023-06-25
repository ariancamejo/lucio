import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/google_auth/google_auth_provider.dart';
import 'package:lucio/data/repositories/rlp_provider.dart';
import 'package:lucio/device/device.dart';
import 'package:lucio/device/helpers/biometric/fingerprint.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:path_provider/path_provider.dart';

class BackUp extends ConsumerStatefulWidget {
  const BackUp({Key? key}) : super(key: key);

  @override
  ConsumerState<BackUp> createState() => _BackUpState();

  static Future<String> _savedFile(String folder) async {
    DateTime now = DateTime.now();
    String fullPath = '$folder/backup-lucio-${DateFormat(dateFormat).format(now)}-${now.millisecondsSinceEpoch}.isar';
    await DBHelper.isar.copyToFile(fullPath);
    return fullPath;
  }

  static Future<String?> createBackUpIsar(BuildContext context, WidgetRef ref, {Function()? onStart, Function()? onFinish}) async {
    onStart?.call();
    if (ref.read(googleAuthProvider) != null) {
      final directory = await getApplicationDocumentsDirectory();

      String pathFile = await _savedFile(directory.path);
      if (context.mounted) await ref.read(googleAuthProvider.notifier).saveFile(context, file: File(pathFile));
      onFinish?.call();
      return pathFile;
    }

    String? selectedDirectoryPath = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectoryPath == null) {
      onFinish?.call();
      return null;
    }
    String? s;
    try {
      s = await _savedFile(selectedDirectoryPath);
    } catch (e) {
      print(e);
      if (context.mounted) {
        Utils.showSnack(context, title: "Operation Error", message: "You dont have permissions for save file on selected folder, please select other", type: FlashType.error);
      }
    }
    if (context.mounted) Utils.showSnack(context, title: "Backup", message: "File has saved", type: FlashType.success);
    onFinish?.call();
    return s;
  }

  static Future<void> recoveryFromBackUp(BuildContext context, WidgetRef ref, {Function()? onStart, Function()? onFinish}) async {
    File? backupFile;
    onStart?.call();
    if (ref.read(googleAuthProvider) != null) {
      backupFile = await ref.read(googleAuthProvider.notifier).pickFile(context);
    } else {
      FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles();

      if (filePickerResult == null) {
        onFinish?.call();
        return;
      }

      backupFile = File(filePickerResult.files.single.path!);
    }
    if (backupFile == null) {
      onFinish?.call();
      return;
    }

    String extension = backupFile.path.split('.').last;
    if (extension != 'isar') {
      if (context.mounted) Utils.showSnack(context, title: "Type not supported", message: "the selected file is not a database backup", type: FlashType.error);
      onFinish?.call();
      return;
    }

    final document = await getApplicationDocumentsDirectory();
    final databaseFile = File("${document.path}/default.isar");

    // Copiar el archivo de copia de seguridad a la ubicación de la base de datos
    await backupFile.copy(databaseFile.path);

    await DBHelper.isar.close(deleteFromDisk: false);
    await DBHelper.init();
    onFinish?.call();
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Restart required"),
          content: const Text("Your app will close to load the backup"),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
        ),
      ).then((value) => exit(1));
    }
  }
}

class _BackUpState extends ConsumerState<BackUp> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(googleAuthProvider);
    return ListTile(
      title: const Text("BackUp"),
      subtitle: const Text("Create a file with the information"),
      trailing: PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (_) => [
          {"value": 0, "text": "Save"},
          {"value": 1, "text": "Recovery"}
        ]
            .map(
              (e) => PopupMenuItem(
                value: e['value'],
                child: Text(
                  e['text'].toString(),
                ),
              ),
            )
            .toList(),
        onSelected: (value) {
          switch (value) {
            case 0:
              BackUp.createBackUpIsar(
                context,
                ref,
                onStart: () {
                  ref.read(rlP.notifier).start();
                },
                onFinish: () {
                  ref.read(rlP.notifier).stop();
                },
              );
              break;
            case 1:
              checkAuth(ref, message: "Recovery BackUp", onSuccess: () {
                BackUp.recoveryFromBackUp(
                  context,
                  ref,
                  onStart: () {
                    ref.read(rlP.notifier).start();
                  },
                  onFinish: () {
                    ref.read(rlP.notifier).stop();
                  },
                );
              });
              break;
            default:
              break;
          }
        },
      ),
      leading: user == null ? const Icon(FontAwesomeIcons.floppyDisk) : RotatingBox(),
    );
  }
}

class RotatingBox extends ConsumerStatefulWidget {
  const RotatingBox({Key? key}) : super(key: key);

  @override
  _RotatingBoxState createState() => _RotatingBoxState();
}

class _RotatingBoxState extends ConsumerState<RotatingBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(rlP);
    return RotationTransition(
      turns: loading ? _controller : const AlwaysStoppedAnimation(0),
      child: const Icon(FontAwesomeIcons.googleDrive),
    );
  }
}
