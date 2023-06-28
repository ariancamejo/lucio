import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucio/app/widgets/empty.dart';
import 'package:lucio/data/const.dart';
import 'package:googleapis/drive/v3.dart' as drive;

class GoogleDriveIsarFilesPage extends StatefulWidget {
  final List<drive.File> files;
  final drive.DriveApi driveApi;

  const GoogleDriveIsarFilesPage({Key? key, required this.driveApi, required this.files}) : super(key: key);

  @override
  State<GoogleDriveIsarFilesPage> createState() => _GoogleDriveIsarFilesPageState();
}

class _GoogleDriveIsarFilesPageState extends State<GoogleDriveIsarFilesPage> {
  List<drive.File> files = [];
  String? deleting;

  @override
  void initState() {
    files = widget.files;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a file'),
        actions: const [Icon(FontAwesomeIcons.googleDrive), SizedBox(width: kDefaultRefNumber)],
      ),
      body: files.isEmpty
          ? const EmptyScreen(name: "BackUp File on GoogleDrive")
          : SingleChildScrollView(
              child: Column(
                children: files
                    .map(
                      (file) => ListTile(
                        title: Text(file.name!),
                        subtitle: Text(DateFormat("$dateFormat hh:mm a").format(file.createdTime!)),
                        onTap: () {
                          Navigator.of(context).pop(file);
                        },
                        trailing: deleting == file.id
                            ? const SizedBox(
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation(Colors.red),
                                    ),
                                  ),
                                ),
                              )
                            : IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  setState(() {
                                    deleting = file.id;
                                  });
                                  await widget.driveApi.files.delete(file.id!).whenComplete(() {
                                    files.remove(file);
                                    setState(() => deleting = null);
                                  });
                                },
                              ),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
