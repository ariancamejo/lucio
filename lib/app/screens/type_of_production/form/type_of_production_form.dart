import 'package:dropdown_search/dropdown_search.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/app/screens/settings/unit/unit_page.dart';
import 'package:lucio/app/widgets/dropdowns.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/data/repositories/units/units_provider.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TypeOfProductionForm extends ConsumerStatefulWidget {
  final ProductionTypeModel? model;

  const TypeOfProductionForm({Key? key, this.model}) : super(key: key);

  @override
  ConsumerState<TypeOfProductionForm> createState() => _MaterialFormState();
}

class _MaterialFormState extends ConsumerState<TypeOfProductionForm> {
  final GlobalKey<FormState> _key = GlobalKey();
  late Color _dialogPickerColor;
  late TextEditingController _name;
  late TextEditingController _price;
  late TextEditingController _daysToByReady;
  UnitOfMeasurementModel? _unitModel;

  @override
  void initState() {
    _name = TextEditingController(text: widget.model?.name ?? "");
    _daysToByReady = TextEditingController(text: widget.model?.daysToBeReady.toString() ?? "17");
    _price = TextEditingController(text: widget.model?.price.toString() ?? "");
    _unitModel = widget.model?.unit.value;
    _dialogPickerColor = widget.model?.color == null ? Colors.blue : Color(widget.model!.color);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final units = ref.watch(unitsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model == null ? "New Type of Production" : "Update Type of Production"),
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
                    return null;
                  },
                  selectedItem: _unitModel,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  clearButtonProps: ClearButtonProps(
                      onPressed: () {
                        setState(() => _unitModel = null);
                      },
                      icon: const Icon(Icons.clear),
                      isVisible: true),
                  popupProps: popUpsProps<UnitOfMeasurementModel>(
                    context,
                    onPressed: () => showCupertinoModalBottomSheet(
                      context: context,
                      builder: (_) => const UnitPage(),
                    ),
                    iconData: Icons.settings,
                    title: "Unit Of Measurement",
                  ),
                  asyncItems: (String filter) => Future.value(units.units),
                  itemAsString: (UnitOfMeasurementModel u) => "${u.value} (${u.key})",
                  onChanged: (UnitOfMeasurementModel? data) => setState(() => _unitModel = data),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(labelText: "Unit Of Measurement"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: TextFormField(
                  controller: _price,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Price"),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Price required";
                    }
                    if (double.tryParse(value ?? '-') == null) {
                      return "Enter a valid number";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: TextFormField(
                  controller: _daysToByReady,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Days to be ready"),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Days required";
                    }
                    if (int.tryParse(value ?? '-') == null) {
                      return "Enter a valid number";
                    }
                    return null;
                  },
                ),
              ),
              // Pick color in a dialog.
              ListTile(
                title: const Text('Color to represent the type of production'),
                subtitle: const Text("Click on color for change this"),
                trailing: ColorIndicator(
                  width: 30,
                  height: 30,
                  borderRadius: 4,
                  color: _dialogPickerColor,
                  onSelectFocus: false,
                  onSelect: () async {
                    final Color colorBeforeDialog = _dialogPickerColor;
                    Color result = await showColorPickerDialog(context, colorBeforeDialog);
                    setState(() {
                      _dialogPickerColor = result;
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
              await ref.read(productionTypeModelProvider.notifier).insert(
                    name: _name.text,
                    price: double.tryParse(_price.text) ?? 0,
                    daysToBeReady: int.tryParse(_daysToByReady.text) ?? 17,
                    unit: _unitModel,
                    color: _dialogPickerColor.value,
                  );
            } else {
              await ref.read(productionTypeModelProvider.notifier).update(widget.model!, values: {
                "name": _name.text,
                "price": double.tryParse(_price.text) ?? 0,
                "daysToBeReady": int.tryParse(_daysToByReady.text) ?? 17,
                "color": _dialogPickerColor.value,
                "unit": _unitModel
              });
            }
            if (context.mounted) Navigator.pop(context);
          }
        },
        child: Icon(widget.model == null ? Icons.save : Icons.update),
      ),
    );
  }
}
