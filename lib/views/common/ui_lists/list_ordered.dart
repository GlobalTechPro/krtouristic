import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;

class OrderedList extends StatelessWidget {
  const OrderedList(this.texts, {super.key});
  final List<dynamic> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    int counter = 0;
    for (var text in texts) {
      counter++;
      widgetList.add(OrderedListItem(counter, text));
      widgetList.add(const SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }
}

class OrderedListItem extends StatelessWidget {
  const OrderedListItem(this.counter, this.text, {super.key});
  final int counter;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "  $counter. ",
          style: font_styles.aboutDialogText,
        ),
        Expanded(
          child: Text(
            text,
            style: font_styles.aboutDialogText,
          ),
        ),
      ],
    );
  }
}
