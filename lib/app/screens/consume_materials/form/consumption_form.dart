import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/app/screens/materials/materials_page.dart';
import 'package:lucio/app/screens/type_of_production/type_of_production_page.dart';
import 'package:lucio/app/widgets/dropdowns.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/consume_materials/consume_material_provider.dart';
import 'package:lucio/data/repositories/materials/materials_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class ConsumptionForm extends ConsumerStatefulWidget {
  final ConsumptionModel? model;
  final Map<String, dynamic>? initial;

  const ConsumptionForm({Key? key, this.model, this.initial}) : super(key: key);

  @override
  ConsumerState<ConsumptionForm> createState() => _ConsumeMaterialFormState();
}

class _ConsumeMaterialFormState extends ConsumerState<ConsumptionForm> {
  final GlobalKey<FormState> _key = GlobalKey();
  ProductionTypeModel? productionTypeModel;
  MaterialModel? materialModel;
  late TextEditingController _quantityType;
  late TextEditingController _quantityMaterial;

  @override
  void initState() {
    productionTypeModel = widget.model?.type.value ?? (widget.initial ?? {})['type'];
    materialModel = widget.model?.material.value ?? (widget.initial ?? {})['material'];
    _quantityType = TextEditingController(text: widget.model?.quantityType.toString() ?? (widget.initial ?? {})['quantityType'] ?? "");
    _quantityMaterial = TextEditingController(text: widget.model?.quantityMaterial.toString() ?? (widget.initial ?? {})['quantityMaterial'] ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productTypes = ref.watch(productionTypeModelProvider);
    final materials = ref.watch(materialsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model == null ? "New Consumption" : "Update Consumption"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: DropdownSearch<ProductionTypeModel>(
                  enabled: widget.model == null,
                  validator: (ProductionTypeModel? value) {
                    if (value == null) {
                      return "Production Type required";
                    }
                    return null;
                  },
                  selectedItem: productionTypeModel,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  clearButtonProps: ClearButtonProps(
                      onPressed: () {
                        _quantityType.text = '';
                        setState(() => productionTypeModel = null);
                      },
                      icon: const Icon(Icons.clear),
                      isVisible: true),
                  popupProps: popUpsProps<ProductionTypeModel>(context, onPressed: () => TypeOfProductionPage.fireForm(context), title: "Production Type"),
                  asyncItems: (String filter) => Future.value(productTypes),
                  itemAsString: (ProductionTypeModel u) => "${u.name} ${u.unit.value == null ? "" : "(${u.unit.value?.key ?? ""})"}",
                  onChanged: (ProductionTypeModel? data) => setState(() => productionTypeModel = data),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(labelText: "Production Type"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: TextFormField(
                  controller: _quantityType,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Quantity Type"),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Quantity Type required";
                    }
                    if (double.tryParse(value ?? '-') == null) {
                      return "Enter valid cant";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: DropdownSearch<MaterialModel>(
                  enabled: widget.model == null,
                  validator: (MaterialModel? value) {
                    if (value == null) {
                      return "Material required";
                    }
                    return null;
                  },
                  selectedItem: materialModel,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  clearButtonProps: ClearButtonProps(
                      onPressed: () {
                        _quantityMaterial.text = '';
                        setState(() => materialModel = null);
                      },
                      icon: const Icon(Icons.clear),
                      isVisible: true),
                  popupProps: popUpsProps<MaterialModel>(context, onPressed: () => MaterialsPage.fireForm(context), title: "Materials"),
                  asyncItems: (String filter) => Future.value(materials),
                  itemAsString: (MaterialModel u) => "${u.name} ${u.unit.value == null ? "" : "(${u.unit.value?.key ?? ""})"}",
                  onChanged: (MaterialModel? data) => setState(() => materialModel = data),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(labelText: "Material"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: TextFormField(
                  controller: _quantityMaterial,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Quantity Material"),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Quantity Material required";
                    }
                    if (double.tryParse(value ?? '-') == null) {
                      return "Enter valid cant";
                    }
                    return null;
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
              await ref.read(consumeMaterialsProvider.notifier).insert(
                    type: productionTypeModel!,
                    material: materialModel!,
                    quantityType: double.tryParse(_quantityType.text) ?? 0,
                    quantityMaterial: double.tryParse(_quantityMaterial.text) ?? 0,
                  );
            } else {
              await ref.read(consumeMaterialsProvider.notifier).update(widget.model!, values: {
                "type": productionTypeModel!,
                "material": materialModel!,
                "quantityType": double.tryParse(_quantityType.text) ?? 0,
                "quantityMaterial": double.tryParse(_quantityMaterial.text) ?? 0,
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
