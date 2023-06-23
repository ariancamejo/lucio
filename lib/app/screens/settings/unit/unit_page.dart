import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/units/units_provider.dart';

class _MyUnitForm {
  late GlobalKey<FormState> state;
  late TextEditingController key;
  late TextEditingController value;

  _MyUnitForm() {
    state = GlobalKey<FormState>();
    key = TextEditingController(text: '');
    value = TextEditingController(text: '');
  }
}

class UnitPage extends ConsumerStatefulWidget {
  static String name = 'UnitPage';

  const UnitPage({Key? key}) : super(key: key);

  @override
  ConsumerState<UnitPage> createState() => _UnitPageState();
}

class _UnitPageState extends ConsumerState<UnitPage> {
  List<_MyUnitForm> _forms = [];

  @override
  Widget build(BuildContext context) {
    final units = ref.watch(unitsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Unit of Measurement")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...units.units.map(
              (e) => ListTile(
                leading: CircleAvatar(child: Text(e.key)),
                title: Text(e.value),
                trailing: IconButton(
                  onPressed: () async {
                    bool? result = await showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("Remove ${e.value} (${e.key})"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Theme.of(context).colorScheme.error),
                              )),
                          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
                        ],
                      ),
                    );

                    result == true ? ref.read(unitsProvider.notifier).delete([e]) : print("canceled");
                  },
                  icon: const Icon(FontAwesomeIcons.trash),
                ),
              ),
            ),
            ..._forms.map(
              (e) => Form(
                key: e.state,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                      child: TextFormField(
                        controller: e.key,
                        decoration: const InputDecoration(labelText: "Key"),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Key required";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                      child: TextFormField(
                        controller: e.value,
                        decoration: const InputDecoration(labelText: "Name"),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Name required";
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              _forms.removeWhere((element) => element.state == e.state);
                              setState(() {});
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Theme.of(context).colorScheme.error),
                            )),
                        TextButton(
                            onPressed: () {
                              if (e.state.currentState?.validate() ?? false) {
                                ref.read(unitsProvider.notifier).insert(key: e.key.text, value: e.value.text);
                                _forms.removeWhere((element) => element.state == e.state);
                                setState(() {});
                              }
                            },
                            child: Text("Save")),
                        const SizedBox(width: kDefaultRefNumber),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _forms.add(_MyUnitForm());
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
