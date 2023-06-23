import 'package:flutter/material.dart';
import 'package:lucio/data/const.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Section extends MultiSliver {
  Section({
    Key? key,
    required Widget title,
    Widget? subtitle,
    Widget? leading,
    Widget? trailing,
    BoxDecoration? boxDecoration,
    required List<Widget> items,
    Widget? action,
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
                  subtitle: subtitle,
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
            SliverToBoxAdapter(child: action),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultRefNumber),
                child: Divider(),
              ),
            )
          ],
        );
}
