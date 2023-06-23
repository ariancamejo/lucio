import 'package:dropdown_search/dropdown_search.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/materials/materials_provider.dart';
import 'package:lucio/data/repositories/units/units_provider.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';

class MaterialForm extends ConsumerStatefulWidget {
  final MaterialModel? model;

  const MaterialForm({Key? key, this.model}) : super(key: key);

  @override
  ConsumerState<MaterialForm> createState() => _MaterialFormState();
}

class _MaterialFormState extends ConsumerState<MaterialForm> {
  final GlobalKey<FormState> _key = GlobalKey();
  late Color dialogPickerColor;
  late TextEditingController _name;
  UnitOfMeasurementModel? unitModel;

  @override
  void initState() {
    _name = TextEditingController(text: widget.model?.name ?? "");
    dialogPickerColor = widget.model?.color == null ? Colors.blue : Color(widget.model!.color);
    unitModel = widget.model?.unit.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final units = ref.watch(unitsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model == null ? "New Material" : "Update Material"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: TextFormField(
                  controller: _name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Name required";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: DropdownSearch<UnitOfMeasurementModel>(
                  validator: (UnitOfMeasurementModel? value) {
                    if (value == null) {
                      return "Unit required";
                    }
                    return null;
                  },
                  selectedItem: unitModel,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  popupProps: const PopupProps.bottomSheet(),
                  asyncItems: (String filter) => Future.value(units.units),
                  itemAsString: (UnitOfMeasurementModel u) => "${u.value} (${u.key})",
                  onChanged: (UnitOfMeasurementModel? data) => setState(() => unitModel = data),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(labelText: "Unit Of Measurement"),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Color to represent the material'),
                subtitle: const Text("Click on color for change this"),
                trailing: ColorIndicator(
                  width: 30,
                  height: 30,
                  borderRadius: 4,
                  color: dialogPickerColor,
                  onSelectFocus: false,
                  onSelect: () async {
                    final Color colorBeforeDialog = dialogPickerColor;
                    Color result = await showColorPickerDialog(context, colorBeforeDialog);
                    setState(() {
                      dialogPickerColor = result;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_key.currentState?.validate() ?? false) {
            if (widget.model == null) {
              await ref.read(materialsProvider.notifier).insert(
                    name: _name.text,
                    color: dialogPickerColor.value,
                    unit: unitModel!,
                  );
            } else {
              await ref.read(materialsProvider.notifier).update(widget.model!, values: {
                "name": _name.text,
                "color": dialogPickerColor.value,
                "unit": unitModel,
              });
            }
            if (context.mounted) Navigator.pop(context);
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
