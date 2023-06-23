import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucio/device/device.dart';
import 'package:lucio/device/helpers/biometric/fingerprint.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:path_provider/path_provider.dart';

class BackUp extends StatefulWidget {
  const BackUp({Key? key}) : super(key: key);

  @override
  State<BackUp> createState() => _BackUpState();

  static Future<void> createBackUpIsar() async {
    String? selectedDirectoryPath = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectoryPath == null) {
      return;
    }
    DateTime now = DateTime.now();
    await DBHelper.isar.copyToFile('$selectedDirectoryPath/backup-lucio-${DateFormat("dd-MMMM-YYYY").format(now)}-${now.millisecondsSinceEpoch}.isar');
  }

  static Future<void> recoveryFromBackUp(BuildContext context) async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles();

    if (filePickerResult == null) {
      return;
    }

    final backupFile = File(filePickerResult.files.single.path!);
    String extension = backupFile.path.split('.').last;
    if (extension != 'isar') {
      if (context.mounted) Utils.showSnack(context, title: "Type not supported", message: "the selected file is not a database backup", type: FlashType.error);
      return;
    }

    final document = await getApplicationDocumentsDirectory();
    final databaseFile = File("${document.path}/default.isar");

    // Copiar el archivo de copia de seguridad a la ubicación de la base de datos
    await backupFile.copy(databaseFile.path);

    await DBHelper.isar.close(deleteFromDisk: false);
    await DBHelper.init();
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

class _BackUpState extends State<BackUp> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("BackUp"),
      subtitle: const Text("Create a file with the information"),
      trailing: PopupMenuButton(
        icon: const Icon(Icons.cloud),
        itemBuilder: (_) => [
          {"value": 0, "text": "Save"},
          {"value": 1, "text": "Recovery"}
        ].map((e) => PopupMenuItem(value: e['value'], child: Text(e['text'].toString()))).toList(),
        onSelected: (value) {
          switch (value) {
            case 0:
              BackUp.createBackUpIsar();
              break;
            case 1:
              checkAuth(context, obli: false, useBiometric: true, onSuccess: () {
                BackUp.recoveryFromBackUp(context);
              });
              break;
            default:
              break;
          }
        },
      ),
      leading: const Icon(FontAwesomeIcons.floppyDisk),
    );
  }
}
