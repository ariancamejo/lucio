import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/production/production_tab.dart';
import 'package:lucio/app/screens/type_of_production/type_of_production_page.dart';
import 'package:lucio/app/widgets/dropdowns.dart';

import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/production/production_provider.dart';
import 'package:lucio/data/repositories/sales/sales_provider.dart';
import 'package:lucio/data/repositories/sales/sub_sales_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';

import 'package:lucio/domain/scheme/production/production_model.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';

class SubSaleForm extends ConsumerStatefulWidget {
  final SaleModel? saleModel;
  final SubSaleModel? model;

  const SubSaleForm({Key? key, this.saleModel, this.model}) : super(key: key);

  @override
  ConsumerState<SubSaleForm> createState() => _SaleFormState();
}

class _SaleFormState extends ConsumerState<SubSaleForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  ProductionModel? productionModel;
  SaleModel? saleModel;
  ProductionTypeModel? productionTypeModel;
  late TextEditingController _quantity;
  late TextEditingController _breaks;

  @override
  void initState() {
    saleModel = widget.saleModel;
    productionModel = widget.model?.lot.value;
    productionTypeModel = widget.model?.type.value;
    _quantity = TextEditingController(text: widget.model?.quantity.toString() ?? "");
    _breaks = TextEditingController(text: widget.model?.breaks.toString() ?? "0");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productions = ref.watch(productionProvider);
    final sales = ref.watch(saleProvider);
    final typeProductions = ref.watch(productionTypeModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model == null ? "New SubSale" : "Update SubSale"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              if (saleModel == null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                  child: DropdownSearch<SaleModel>(
                    validator: (SaleModel? value) {
                      if (value == null) {
                        return "Sale required";
                      }
                      return null;
                    },
                    selectedItem: saleModel,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    popupProps: const PopupProps.bottomSheet(),
                    asyncItems: (String filter) => Future.value(sales),
                    itemAsString: (SaleModel u) => "${u.client} ${DateFormat("$dateFormat hh:mm a").format(u.date)}",
                    onChanged: (SaleModel? data) => setState(() => saleModel = data),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(labelText: "Lote"),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: DropdownSearch<ProductionModel>(
                  validator: (ProductionModel? value) {
                    return null;
                  },
                  clearButtonProps: ClearButtonProps(onPressed: () => setState(() => productionModel = null), icon: const Icon(Icons.clear), isVisible: true),
                  selectedItem: productionModel,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  popupProps: popUpsProps<ProductionModel>(context, title: "Lots"),
                  asyncItems: (String filter) => Future.value(productions),
                  itemAsString: (ProductionModel u) => DateFormat(dateFormat).format(u.date),
                  onChanged: (ProductionModel? data) => setState(() => productionModel = data),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(labelText: "Lote"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: DropdownSearch<ProductionTypeModel>(
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
                        _quantity.text = '';
                        _breaks.text = '0';
                        setState(() => productionTypeModel = null);
                      },
                      icon: const Icon(Icons.clear),
                      isVisible: true),
                  popupProps: popUpsProps<ProductionTypeModel>(context, onPressed: () => TypeOfProductionPage.fireForm(context), title: "Production Type"),
                  asyncItems: (String filter) => Future.value(typeProductions),
                  itemAsString: (ProductionTypeModel u) => u.name,
                  onChanged: (ProductionTypeModel? data) => setState(() => productionTypeModel = data),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(labelText: "Production Type"),
                  ),
                ),
              ),
              FutureBuilder<double?>(
                  future: productionModel == null ? Future.value(null) : productionModel!.details(productionTypeModel, typeResult: ProductionTypeResult.available),
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                      child: TextFormField(
                        controller: _quantity,
                        enabled: productionTypeModel != null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(labelText: "Quantity"),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Quantity required";
                          }
                          if (double.tryParse(value ?? "-") == null) {
                            return "Enter correct number";
                          }
                          if (double.tryParse(value ?? "0") == 0) {
                            return "Please,specify a number greater than zero";
                          }
                          if (snapshot.data != null && (double.tryParse(value ?? "0") ?? 0) > (snapshot.data ?? 0)) {
                            if ((snapshot.data ?? 0) == 0) {
                              return "No available";
                            }
                            return "Only ${snapshot.data ?? 0} available";
                          }

                          return null;
                        },
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: TextFormField(
                  controller: _breaks,
                  enabled: productionTypeModel != null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: "Breaks"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Breaks required";
                    }
                    if (double.tryParse(value ?? "-") == null) {
                      return "Enter correct number";
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
              ref.read(subSalesProvider.notifier).insert(
                    type: productionTypeModel!,
                    lot: productionModel,
                    sale: saleModel!,
                    quantity: double.tryParse(_quantity.text) ?? 0,
                    breaks: double.tryParse(_breaks.text) ?? 0,
                  );
            } else {
              ref.read(subSalesProvider.notifier).update(widget.model!, values: {
                "type": productionTypeModel!,
                "lot": productionModel,
                "sale": saleModel!,
                "quantity": double.tryParse(_quantity.text) ?? 0,
                "breaks": double.tryParse(_breaks.text) ?? 0,
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
