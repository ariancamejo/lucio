import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/sales/widgets/sub_sale_item.dart';

import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/sales/sales_provider.dart';
import 'package:lucio/data/repositories/sales/sub_sales_provider.dart';
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

  @override
  void initState() {
    _client = TextEditingController(text: widget.model?.client ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final subsales = ref.watch(subSalesProvider).where((element) => element.sale.value?.id == widget.model?.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model == null ? "New Sale" : "Update Sale"),
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
              ...subsales.map((e) => SubSaleItem(model: e)).toList()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(DateFormat(dateFormat).format(dateTime)),
        onPressed: () async {
          if (_key.currentState?.validate() ?? false) {
            if (widget.model == null) {
              ref.read(saleProvider.notifier).insert(client: _client.text);
            } else {
              ref.read(saleProvider.notifier).update(widget.model!, values: {"client": _client.text});
            }
            if (context.mounted) Navigator.pop(context);
          }
        },
        icon: const Icon(Icons.save),
      ),
    );
  }
}
