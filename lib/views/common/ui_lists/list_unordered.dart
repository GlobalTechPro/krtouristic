import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;

class UnorderedList extends StatelessWidget {
  const UnorderedList(this.texts, {super.key});
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      widgetList.add(UnorderedListItem(text));
      widgetList.add(const SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "  • ",
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
