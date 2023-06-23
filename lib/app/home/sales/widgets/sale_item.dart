import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/sales/sales_tab.dart';
import 'package:lucio/app/home/sales/widgets/sub_sale_item.dart';
import 'package:lucio/app/widgets/section_widget.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/sales/sales_provider.dart';
import 'package:lucio/data/repositories/sales/sub_sales_provider.dart';
import 'package:lucio/device/helpers/biometric/fingerprint.dart';

import 'package:lucio/domain/scheme/sale/sale_model.dart';

class SaleItem extends ConsumerStatefulWidget {
  final SaleModel model;
  final bool showChildren;

  const SaleItem({Key? key, required this.model, this.showChildren = false}) : super(key: key);

  @override
  ConsumerState<SaleItem> createState() => _SaleItemState();
}

class _SaleItemState extends ConsumerState<SaleItem> {
  bool showChildren = false;

  @override
  void initState() {
    showChildren = widget.showChildren;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final subSales = ref.watch(subSalesProvider);

    final filteredSales = subSales.where((sale) => sale.sale.value?.id == widget.model.id);
    final salesItems = filteredSales.map((saleItem) => SubSaleItem(model: saleItem)).toList();
    final scheme = Theme.of(context).colorScheme;
    return Section(
      titleIsBig: true,
      title: ListTile(
        title: Text(
          widget.model.client,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        subtitle: Text(
          DateFormat("$dateFormat hh:mm a").format(widget.model.date),
        ),
        leading: Checkbox(
          value: widget.model.deposit,
          visualDensity: VisualDensity.compact,
          onChanged: (value) {
            checkAuth(ref, message: "${value == true ? "Check" : "Uncheck"} Deposit of sale", onSuccess: () {
              ref.read(saleProvider.notifier).update(widget.model, values: {"deposit": value});
            });
          },
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => SalesTab.fireForm(context, model: widget.model),
              icon: const Icon(FontAwesomeIcons.pencil),
            ),
            if (salesItems.isEmpty)
              IconButton(
                onPressed: () {
                  ref.read(saleProvider.notifier).delete([widget.model]);
                },
                icon: const Icon(FontAwesomeIcons.trash),
              ),
            IconButton(
              onPressed: () => setState(
                () {
                  showChildren = !showChildren;
                },
              ),
              icon: Icon(showChildren ? FontAwesomeIcons.circleChevronUp : FontAwesomeIcons.circleChevronDown),
            ),
          ],
        ),
      ),
      action: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (showChildren)
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => SalesTab.fireSubForm(context, widget.model),
                  child: const Text("Add new Sub Sale"),
                ),
              ),
            ),
        ],
      ),
      boxDecoration: BoxDecoration(color: scheme.surface),
      items: showChildren ? salesItems : [],
    );
  }
}
