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
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/empty.png"),
          ),
        ),
      ),
    );
  }
}
