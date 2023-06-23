import 'package:flutter/material.dart';
import 'package:lucio/data/const.dart';

class EmptyScreen extends StatelessWidget {
  final Function()? onTap;
  final String name;

  const EmptyScreen({Key? key, required this.name, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/empty.png"),
          ],
        ),
      ),
    );
  }
}
