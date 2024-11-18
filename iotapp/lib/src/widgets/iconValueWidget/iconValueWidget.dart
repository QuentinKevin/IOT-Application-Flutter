import 'package:flutter/material.dart';

class IconValueWidget extends StatefulWidget{

  final IconData icon;
  final String value;
  final Color iconColor;

  const IconValueWidget({super.key, required this.icon, required this.value, required this.iconColor});

  @override
  State<StatefulWidget> createState() => _IconValueWidget();
}

class _IconValueWidget extends State<IconValueWidget> {

  IconData icon = Icons.abc;
  String value = "";
  Color iconColor = Colors.purple;

  @override
  Widget build(BuildContext context) {
    icon = widget.icon;
    iconColor = widget.iconColor;
    value = widget.value;
    return SizedBox(
        child: (
              Stack(
                children: <Widget> [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                    child: Icon(icon,color: iconColor)
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 0, 10.0, 0),
                    child: Text(value)
                  )
                  ]
              )
          )
    );
  }

}