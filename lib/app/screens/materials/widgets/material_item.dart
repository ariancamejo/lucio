import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucio/app/screens/materials/materials_page.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/materials/materials_provider.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';

class MaterialItem extends ConsumerWidget {
  final MaterialModel model;

  const MaterialItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: ValueKey(model.id),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            spacing: 2,
            onPressed: (_) async =>
                await MaterialsPage.fireDelete(context, model: model).then((bool value) => value == true ? ref.read(materialsProvider.notifier).delete([model]) : null),
            backgroundColor: scheme.error,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
          ),
          const SizedBox(width: 1),
          SlidableAction(
            onPressed: (_) => MaterialsPage.fireForm(context, model: model),
            backgroundColor: scheme.primary,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
          ),
          const SizedBox(width: 1),
        ],
      ),
      child: ListTile(
        title: Text(model.name, style: TextStyle(color: Color(model.color))),
        trailing: Text(
          model.unit.value?.key ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        // trailing: ColorIndicator(
        //   width: 30,
        //   height: 30,
        //   borderRadius: 4,
        //   color: Color(model.color),
        //   onSelectFocus: false,
        //   onSelect: () async {
        //     final Color colorBeforeDialog = Color(model.color);
        //     Color result = await showColorPickerDialog(context, colorBeforeDialog);
        //     await ref.read(materialsProvider.notifier).update(model, values: {"color": result.value});
        //   },
        // ),
        onLongPress: () => MaterialsPage.fireForm(context, model: model),
      ),
    );
  }
}
