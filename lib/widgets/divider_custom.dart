import 'package:flutter/material.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 4,
      thickness: 2,
      color: Colors.amber.shade300,
    );
  }
}
