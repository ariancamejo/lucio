import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/sales/sales_tab.dart';

import 'package:lucio/app/home/sales/widgets/sub_sale_item.dart';
import 'package:lucio/app/screens/type_of_sale/type_of_sale_page.dart';
import 'package:lucio/app/widgets/dropdowns.dart';

import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/data/repositories/sales/sales_provider.dart';
import 'package:lucio/data/repositories/sales/sub_sales_provider.dart';
import 'package:lucio/data/repositories/type_of_sale/type_of_sale_provider.dart';
import 'package:lucio/device/device.dart';
import 'package:lucio/device/helpers/biometric/fingerprint.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';

class SaleForm extends ConsumerStatefulWidget {
  final SaleModel? model;
  final Map<String, dynamic>? initial;

  const SaleForm({Key? key, this.model, this.initial}) : super(key: key);

  @override
  ConsumerState<SaleForm> createState() => _SaleFormState();
}

class _SaleFormState extends ConsumerState<SaleForm> {
  final GlobalKey<FormState> _key = GlobalKey();
  late TextEditingController _client;
  DateTime dateTime = DateTime.now();
  SaleModel? model;
  SaleTypeModel? saleTypeModel;
  final FocusNode _clientFocus = FocusNode();

  @override
  void initState() {
    model = widget.model;
    saleTypeModel = widget.model?.saleType.value ?? (widget.initial ?? {})['saleType'];
    _client = TextEditingController(text: model?.client ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final subsales = ref.watch(subSalesProvider).where((element) => element.sale.value?.id == model?.id);
    final options = ref.watch(optionsP);
    final salesTypes = ref.watch(saleTypeModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(model == null ? "New Sale" : "Update Sale"),
        actions: [
          // if (model?.pendingSales ?? false)
          //   const Tooltip(
          //     message: "sales pending for production",
          //     child: Icon(FontAwesomeIcons.clock),
          //   ),
          IconButton(
            onPressed: () {
              checkAuth(ref, message: "Change Date", onSuccess: () async {
                DateTime? result = await showDatePicker(
                    context: context, initialDate: dateTime, firstDate: DateTime.now().subtract(Duration(days: options.daysOfRangeDateProduction)), lastDate: DateTime.now());
                setState(() {
                  result = result ?? DateTime.now();
                  TimeOfDay selectedTime = TimeOfDay.now();
                  dateTime = DateTime(
                    result!.year,
                    result!.month,
                    result!.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );
                });
              });
            },
            icon: const Icon(Icons.date_range_sharp),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: TextFormField(
                  controller: _client,
                  focusNode: _clientFocus,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: "Client Name"),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Client Name required";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: DropdownSearch<SaleTypeModel>(
                  validator: (SaleTypeModel? value) {
                    if (value == null) {
                      return "Sale required";
                    }
                    return null;
                  },
                  clearButtonProps: ClearButtonProps(
                    isVisible: true,
                    onPressed: () {
                      setState(() {
                        saleTypeModel = null;
                      });
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  selectedItem: saleTypeModel,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  popupProps: popUpsProps<SaleTypeModel>(context, onPressed: () => TypeOfSalePage.fireForm(context), title: "Type of Sales"),
                  asyncItems: (String filter) => Future.value(salesTypes),
                  itemAsString: (SaleTypeModel u) => u.name,
                  onChanged: (SaleTypeModel? data) => setState(() => saleTypeModel = data),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(labelText: "Type"),
                  ),
                ),
              ),
              if (model != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                  child: Row(
                    children: [
                      Checkbox(
                          value: model!.deposit,
                          onChanged: (value) async {
                            checkAuth(ref, message: "${value == true ? "Check" : "Uncheck"} Deposit of sale", onSuccess: () async {
                              final object = await ref.read(saleProvider.notifier).update(widget.model!, values: {"deposit": value}, object: true);
                              setState(() => model = object);
                            });
                          }),
                      const Text("Deposit")
                    ],
                  ),
                ),
              ...subsales.map((e) => SubSaleItem(model: e)).toList(),
              if (model != null)
                Padding(
                  padding: const EdgeInsets.only(right: kDefaultRefNumber),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            SalesTab.fireSubForm(context, model);
                          },
                          child: const Text("New SubSale"))
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(DateFormat(dateFormat).format(dateTime)),
        onPressed: () async {
          if (_key.currentState?.validate() ?? false) {
            if (model == null) {
              ref.read(saleProvider.notifier).insert(client: _client.text, saleType: saleTypeModel!, date: dateTime, object: true).then((value) {
                setState(() {
                  model = value;
                });
                _clientFocus.unfocus();
              });
            } else {
              ref
                  .read(saleProvider.notifier)
                  .update(model!, values: {"client": _client.text, "saleType": saleTypeModel!, "date": dateTime}).then((value) => Navigator.pop(context));
            }
          }
        },
        icon: Icon(widget.model == null && model == null ? Icons.save : Icons.update),
      ),
    );
  }
}
