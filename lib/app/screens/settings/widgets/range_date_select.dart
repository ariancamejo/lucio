import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/device/helpers/biometric/fingerprint.dart';

class RangeDateSelectWidget extends ConsumerWidget {
  const RangeDateSelectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = ref.watch(optionsP);
    return ListTile(
      leading: const Icon(FontAwesomeIcons.timeline),
      title: const Text('Select date range for show information'),
      subtitle: Text("${DateFormat(dateFormat).format(options.startFilter)} ---- ${DateFormat(dateFormat).format(options.endFilter)}"),
      trailing: Icon(Icons.date_range_sharp, color: options.permanentDates ? Colors.green : null),
      onLongPress: () {
        ref.read(optionsP.notifier).permanentDates(!options.permanentDates);
      },
      onTap: () async {
        checkAuth(ref, message: "Change date range for show information of application", onSuccess: () async {
          DateTimeRange? result = await showDateRangePicker(
              context: context,
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime(
                DateTime.now().year,
                DateTime.now().month + 1,
                0,
              ),
              initialDateRange: DateTimeRange(start: options.startFilter, end: options.endFilter));

          ref.read(optionsP.notifier).dateRange = result;
        });
      },
    );
  }
}
