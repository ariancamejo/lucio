import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:lucio/data/const.dart';

class NotFoundPage extends StatelessWidget {
  final GoRouterState state;

  const NotFoundPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber, size: 100, color: Theme.of(context).colorScheme.error),
          const SizedBox(height: kDefaultRefNumber),
          SizedBox(
            width: double.maxFinite,
            child: Text(
              "${state.location} NOT FOUND",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
