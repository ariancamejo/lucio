import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/type_of_sale/type_of_sale_provider.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';

class TypeOfSaleForm extends ConsumerStatefulWidget {
  final SaleTypeModel? model;

  const TypeOfSaleForm({Key? key, this.model}) : super(key: key);

  @override
  ConsumerState<TypeOfSaleForm> createState() => _MaterialFormState();
}

class _MaterialFormState extends ConsumerState<TypeOfSaleForm> {
  final GlobalKey<FormState> _key = GlobalKey();

  late TextEditingController _name;

  @override
  void initState() {
    _name = TextEditingController(text: widget.model?.name ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model == null ? "New Type of Sale" : "Update Type of Sale"),
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
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_key.currentState?.validate() ?? false) {
            if (widget.model == null) {
              await ref.read(saleTypeModelProvider.notifier).insert(name: _name.text);
            } else {
              await ref.read(saleTypeModelProvider.notifier).update(widget.model!, values: {"name": _name.text});
            }
            if (context.mounted) Navigator.pop(context);
          }
        },
        child:  Icon(widget.model == null ? Icons.save : Icons.update),
      ),
    );
  }
}
