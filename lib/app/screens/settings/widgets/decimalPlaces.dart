import 'package:customizable_counter/customizable_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucio/data/repositories/options_provider.dart';

class DecimalPlacesWidget extends ConsumerWidget {
  const DecimalPlacesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = ref.watch(optionsP);
    return ListTile(
      leading: const Icon(FontAwesomeIcons.hashtag),
      title: const Text("Decimal Places"),
      subtitle: Text("Decimals after the point (${options.decimals})"),
      trailing: CustomizableCounter(
        step: 1,
        minCount: 0,
        maxCount: 4,
        buttonText: "Change",
        borderColor: Colors.transparent,
        incrementIcon: const Icon(Icons.add),
        decrementIcon: const Icon(Icons.remove),
        onCountChange: (count) {
          ref.read(optionsP.notifier).decimals = count.toInt();
        },
        onIncrement: (count) {},
        onDecrement: (count) {},
      ),
    );
  }
}
