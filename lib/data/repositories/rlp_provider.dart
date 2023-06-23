import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:lucio/device/helpers/storage/secure.dart';

class RequestLoadingNotifier extends StateNotifier<bool> {
  RequestLoadingNotifier() : super(false);

  start({String? info}) => SecureStorage.set('rlP_info', value: info ?? "").then((value) => state = true);

  stop() => SecureStorage.delete('rlP_info').then((value) => state = false);
}

final rlP = StateNotifierProvider<RequestLoadingNotifier, bool>((ref) {
  return RequestLoadingNotifier();
});

class RequestLoadingWidget extends ConsumerWidget {
  const RequestLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    return ref.watch(rlP)
        ? SizedBox.expand(
            child:
                // rlPInfo != null
                //     ? Center(
                //         child: Card(
                //           child: Container(
                //             constraints: BoxConstraints(minHeight: size.width * 0.3),
                //             width: size.width * 0.3,
                //             child: Column(
                //               mainAxisSize: MainAxisSize.min,
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children: [
                //                 const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                //                 const SizedBox(height: kDefaultRefNumber),
                //                 Padding(padding: const EdgeInsets.all(kDefaultRefNumber / 3), child: Text(rlPInfo, textAlign: TextAlign.center))
                //               ],
                //             ),
                //           ),
                //         ),
                //       )
                //
                //     :
                AbsorbPointer(
              absorbing: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  LinearProgressIndicator(
                    minHeight: 2,
                    color: scheme.primary,
                  ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
