import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/sales/form/sale_form.dart';

import 'package:lucio/app/home/sales/form/subsale_form.dart';
import 'package:lucio/app/home/sales/widgets/sale_item.dart';
import 'package:lucio/app/widgets/empty.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/sales/sales_provider.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SalesTab extends ConsumerStatefulWidget {
  const SalesTab({Key? key}) : super(key: key);

  static fireSubForm(BuildContext context, SaleModel? sale, {SubSaleModel? model}) => showCupertinoModalBottomSheet(
        context: context,
        builder: (_) => SubSaleForm(
          model: model,
          saleModel: sale,
        ),
      );

  static fireForm(BuildContext context, {SaleModel? model}) => showCupertinoModalBottomSheet(
        context: context,
        builder: (_) => SaleForm(model: model),
      );

  static Future<bool> fireSubDelete(BuildContext context, {required SubSaleModel model}) async {
    bool? res = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Can you sure ?"),
        content: Text(
            "Press 'Delete' for remove sale for '${model.sale.value?.client ?? ""}' on ${model.sale.value == null ? "--" : DateFormat(dateFormat).format(model.sale.value!.date)}"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              "Delete",
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
    return res ?? false;
  }

  @override
  ConsumerState<SalesTab> createState() => _SalesTabState();
}

class _SalesTabState extends ConsumerState<SalesTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sales = ref.watch(saleProvider);
    final dones = sales.where((element) => !element.pendingSales).toList();
    final pendings = sales.where((element) => element.pendingSales).toList();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => ref.read(saleProvider.notifier).findData(),
        child: SizedBox(
          height: double.maxFinite,
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(
                    icon: Icon(FontAwesomeIcons.listCheck),
                  ),
                  Tab(
                    icon: Icon(FontAwesomeIcons.clock),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    dones.isEmpty
                        ? EmptyScreen(
                            name: "Sale",
                            onTap: () => SalesTab.fireForm(context),
                          )
                        : CustomScrollView(
                            slivers: [
                              MultiSliver(
                                pushPinnedChildren: true,
                                children: dones.map((e) => SaleItem(model: e)).toList(),
                              ),
                              const SliverToBoxAdapter(child: SizedBox(height: 60))
                            ],
                          ),
                    pendings.isEmpty
                        ? EmptyScreen(
                            name: "Sale",
                            onTap: () => SalesTab.fireForm(context),
                          )
                        : CustomScrollView(
                            slivers: [
                              MultiSliver(
                                pushPinnedChildren: true,
                                children: pendings.map((e) => SaleItem(model: e)).toList(),
                              ),
                              const SliverToBoxAdapter(child: SizedBox(height: 60))
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(onPressed: () => SalesTab.fireForm(context), child: const Icon(Icons.add)),
    );
  }
}
