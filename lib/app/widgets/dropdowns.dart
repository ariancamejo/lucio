import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:lucio/data/const.dart';

popUpsProps<T>(BuildContext context, {String? title, Function()? onPressed, IconData? iconData}) => PopupProps<T>.bottomSheet(
      title: title == null
          ? const SizedBox(height: kDefaultRefNumber)
          : Container(
              margin: const EdgeInsets.all(kDefaultRefNumber),
              child: Row(
                children: [
                  if (onPressed != null)
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onPressed.call();
                        },
                        icon: Icon(iconData ?? Icons.add)),
                  Expanded(child: Text(title))
                ],
              ),
            ),
    );
