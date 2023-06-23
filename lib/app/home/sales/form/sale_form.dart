import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/sales/sales_tab.dart';

import 'package:lucio/app/home/sales/widgets/sub_sale_item.dart';

import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/data/repositories/sales/sales_provider.dart';
import 'package:lucio/data/repositories/sales/sub_sales_provider.dart';
import 'package:lucio/device/helpers/biometric/fingerprint.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';

class SaleForm extends ConsumerStatefulWidget {
  final SaleModel? model;

  const SaleForm({Key? key, this.model}) : super(key: key);

  @override
  ConsumerState<SaleForm> createState() => _SaleFormState();
}

class _SaleFormState extends ConsumerState<SaleForm> {
  final GlobalKey<FormState> _key = GlobalKey();
  late TextEditingController _client;
  DateTime dateTime = DateTime.now();
  SaleModel? model;

  @override
  void initState() {
    model = widget.model;
    _client = TextEditingController(text: model?.client ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final subsales = ref.watch(subSalesProvider).where((element) => element.sale.value?.id == model?.id);
    final options = ref.watch(optionsP);
    return Scaffold(
      appBar: AppBar(
        title: Text(model == null ? "New Sale" : "Update Sale"),
        actions: [
          IconButton(
            onPressed: () {
              checkAuth(context, obli: false, useBiometric: true, onSuccess: () async {
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
              ref.read(saleProvider.notifier).insert(client: _client.text, date: dateTime, object: true).then((value) {
                setState(() {
                  model = value;
                });
              });
            } else {
              ref.read(saleProvider.notifier).update(model!, values: {"client": _client.text, "date": dateTime}).then((value) => Navigator.pop(context));
            }
          }
        },
        icon: const Icon(Icons.save),
      ),
    );
  }
}
