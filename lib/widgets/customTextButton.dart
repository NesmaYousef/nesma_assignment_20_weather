import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class customTextButton extends StatelessWidget {
  final IconData icon;
  final Function() func;
  const customTextButton({required this.icon, required this.func});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: func,
      child: Icon(
        icon,
        size: 50.0,
        color: kSecondaryColor,
      ),
    );
  }
}
