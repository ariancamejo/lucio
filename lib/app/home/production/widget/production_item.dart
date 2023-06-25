import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/production/widget/work_prodction_item.dart';
import 'package:lucio/app/widgets/section_widget.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/production/production_provider.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class ProductionItem extends ConsumerStatefulWidget {
  final ProductionModel model;
  final bool showChildren;

  const ProductionItem({Key? key, required this.model, this.showChildren = false}) : super(key: key);

  @override
  ConsumerState<ProductionItem> createState() => _ProductionItemState();
}

class _ProductionItemState extends ConsumerState<ProductionItem> {
  bool showChildren = false;

  @override
  void initState() {
    showChildren = widget.showChildren;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final workProductions = ref.watch(workProductionProvider);
    final productionTypes = ref.watch(productionTypeModelProvider);
    final filteredWorkProductions =
        workProductions.where((workProduction) => DateFormat(dateFormat).format(workProduction.datetime) == DateFormat(dateFormat).format(widget.model.date));
    final workProductionItems = filteredWorkProductions.map((workProduction) => WorkProductionItem(model: workProduction)).toList();
    return Section(
      key: Key(widget.model.id.toString()),
      titleIsBig: true,
      title: Column(
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
                workProductionItems.isEmpty
                    ? IconButton(
                        icon: const Icon(FontAwesomeIcons.trash),
                        onPressed: () => ref.read(productionProvider.notifier).delete([widget.model]),
                      )
                    : const SizedBox(),
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
          FutureBuilder(
              future: widget.model.types(),
              builder: (context, typess) {
                return Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if ((typess.data ?? []).isNotEmpty) const Text("In process"),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber),
                              child: Wrap(
                                spacing: 5,
                                children: (typess.data ?? [])
                                    .map(
                                      (e) => FutureBuilder<int>(
                                        future: widget.model.forSale(e, available: false),
                                        builder: (_, snap) => Tooltip(
                                          message: e.name,
                                          child: Chip(
                                            label: Text(snap.data.toString()),
                                            avatar: CircleAvatar(
                                              radius: 10,
                                              backgroundColor: Color(e.color),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if ((typess.data ?? []).isNotEmpty) const Text("Available"),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber),
                              child: Wrap(
                                spacing: 5,
                                children: (typess.data ?? [])
                                    .map(
                                      (e) => FutureBuilder<int>(
                                        future: widget.model.forSale(e),
                                        builder: (_, snap) => Tooltip(
                                          message: e.name,
                                          child: Chip(
                                            label: Text(snap.data.toString()),
                                            avatar: CircleAvatar(
                                              radius: 10,
                                              backgroundColor: Color(e.color),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
      divider: false,
      boxDecoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      items: showChildren ? workProductionItems : [],
    );
  }
}
