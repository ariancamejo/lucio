import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;
import 'package:http/http.dart' as http;
import 'package:lucio/app/widgets/empty.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/rlp_provider.dart';
import 'package:lucio/device/device.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';

class MyHttpClient extends http.BaseClient {
  final Map<String, String> headers;
  final http.Client _inner = http.Client();

  MyHttpClient(this.headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(headers);
    return _inner.send(request);
  }
}

class GoogleAuthNotifier extends StateNotifier<signIn.GoogleSignInAccount?> {
  final googleSignIn = signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveScope]);

  GoogleAuthNotifier(this.ref) : super(null) {
    googleSignIn.isSignedIn().then((value) async => state = await googleSignIn.signInSilently(suppressErrors: true));
  }

  late StateNotifierProviderRef<StateNotifier, signIn.GoogleSignInAccount?> ref;

  Future<void> login() async {
    state = await googleSignIn.signIn();
  }
  Future<void> logout() async {
    state = await googleSignIn.signOut();
  }

  Future<drive.File?> saveFile(BuildContext context, {required File file}) async {
    final driveApi = drive.DriveApi(MyHttpClient(await state!.authHeaders));
    // drive.FileList folderList = await driveApi.files.list(q: "mimeType='application/vnd.google-apps.folder' and trashed=false", $fields: "nextPageToken, files(id, name)");
    //
    // drive.File? selectedFolder;
    // if (context.mounted) {
    //   // Mostrar un diálogo para que el usuario seleccione una carpeta
    //   selectedFolder = await showCupertinoModalBottomSheet<drive.File?>(
    //     context: context,
    //     builder: (context) => Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Select folder for save file'),
    //       ),
    //       body: SingleChildScrollView(
    //         child: Column(
    //             children: (folderList.files ?? [])
    //                 .map(
    //                   (folder) => ListTile(
    //                     title: Text(folder.name ?? ""),
    //                     onTap: () => Navigator.pop(context, folder),
    //                   ),
    //                 )
    //                 .toList()),
    //       ),
    //     ),
    //   );
    // }

    final driveFile = drive.File()
      ..name = file.path.split('/').last // Utilizamos el nombre del archivo como el nombre del archivo en Google Drive
      ..parents = [];

    // Crear un objeto drive.Media a partir del archivo seleccionado y su tamaño
    final media = drive.Media(file.openRead(), file.lengthSync());

    // Subir el archivo a Google Drive utilizando el método files.create() del objeto driveApi
    final result = await driveApi.files.create(driveFile, uploadMedia: media);

    // Devolver el objeto drive.File que representa el archivo subido
    if (context.mounted) Utils.showSnack(context, iconData: FontAwesomeIcons.googleDrive, title: "Google Drive", message: "File backup has saved", type: FlashType.success);
    return result;
  }

  Future<File?> pickFile(BuildContext context) async {
    final driveApi = drive.DriveApi(MyHttpClient(await state!.authHeaders));
    final drive.FileList files =
        await driveApi.files.list(q: "mimeType='application/octet-stream' and name contains '.isar'", $fields: 'nextPageToken, files(id, name, createdTime)');
    final List<drive.File>? items = files.files;
    if (context.mounted && items != null) {
      ref.read(rlP.notifier).stop();

      drive.File? result = await showCupertinoModalBottomSheet(
        context: context,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Select a file'),
              actions: const [Icon(FontAwesomeIcons.googleDrive), SizedBox(width: kDefaultRefNumber)],
            ),
            body: items.isEmpty
                ? const EmptyScreen(name: "BackUp File on GoogleDrive")
                : SingleChildScrollView(
                    child: Column(
                      children: items
                          .map(
                            (file) => ListTile(
                              title: Text(file.name!),
                              subtitle: Text(file.createdTime!.toString()),
                              onTap: () {
                                Navigator.of(context).pop(file);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
          );
        },
      );
      ref.read(rlP.notifier).start();
      if (result != null) {
        final fileId = result.id!;
        drive.Media media = await driveApi.files.get(fileId, downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;
        final directory = await getApplicationDocumentsDirectory();
        final tempFile = File("${directory.path}/${result.name}");
        final bytes = await media.stream.fold<List<int>>([], (list, element) => list..addAll(element));
        await tempFile.writeAsBytes(bytes);
        return tempFile;
      }
    }
    return null;
  }
}

final googleAuthProvider = StateNotifierProvider<GoogleAuthNotifier, signIn.GoogleSignInAccount?>((ref) {
  return GoogleAuthNotifier(ref);
});
