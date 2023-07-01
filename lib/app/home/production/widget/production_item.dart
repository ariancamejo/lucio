import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/production/widget/production_employee_list.dart';
import 'package:lucio/app/home/production/widget/production_item_info.dart';
import 'package:lucio/app/screens/type_of_production/widgets/type_of_production_item.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/sales/sub_sales_provider.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProductionItem extends ConsumerStatefulWidget {
  final ProductionModel model;
  final bool showChildren;

  const ProductionItem({Key? key, required this.model, this.showChildren = false}) : super(key: key);

  @override
  ConsumerState<ProductionItem> createState() => _ProductionItemState();
}

class _ProductionItemState extends ConsumerState<ProductionItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber / 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                DateFormat(dateFormat).format(widget.model.date),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      showCupertinoModalBottomSheet(context: context, builder: (_) => PrductionEmployeeList(model: widget.model));
                    },
                    icon: const Icon(Icons.production_quantity_limits),
                  ),
                ],
              ),
            ),
            FadeIn(child: ProductionByTypeInfo(model: widget.model))
          ],
        ),
      ),
    );
  }
}
