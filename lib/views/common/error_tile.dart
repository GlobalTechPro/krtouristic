import 'package:flutter/material.dart';

class ErrorTile extends StatelessWidget {
  const ErrorTile({Key? key, required this.errorMessage}) : super(key: key);
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(errorMessage),
          ),
        ),
      ),
    );
  }
}
