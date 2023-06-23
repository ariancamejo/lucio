
import 'package:flutter/material.dart';
import 'package:lucio/data/const.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Section extends MultiSliver {
  Section({
    Key? key,
    required Widget title,
    Widget? leading,
    Widget? trailing,
    BoxDecoration? boxDecoration,
    required List<Widget> items,
  }) : super(
    key: key,
    pushPinnedChildren: true,
    children: [
      SliverPinnedHeader(
        child: Container(
          decoration: boxDecoration,
          child: ListTile(
            leading: leading,
            title: title,
            trailing: trailing,
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber / 2),
        sliver: SliverList(
          delegate: SliverChildListDelegate.fixed(items),
        ),
      ),
    ],
  );
}
