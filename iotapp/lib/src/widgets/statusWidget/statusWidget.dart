import 'package:flutter/material.dart';
import 'package:iotapp/src/settings/setting.dart';

// ignore: must_be_immutable
class StatusWidget extends StatefulWidget {
  String label;
  bool status;
  Color buttonColor;
  double widthButton;
  double heightButton;

  StatusWidget({
    super.key,
    required this.label,
    required this.status,
    required this.buttonColor,
    this.widthButton = 200,
    this.heightButton = 60,
  });

  @override
  State<StatefulWidget> createState() => _StatusWidget();
}

class _StatusWidget extends State<StatusWidget> implements CellStatusWidget {
  Color buttonColor = Setting.activeColor;
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.widthButton,
      height: widget.heightButton,
      child: TextButton(
        onPressed: () {
          setState(() {
            setStatus(!status);
          });
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          side: WidgetStateProperty.all(
            BorderSide(
              color: status ? Colors.green : Colors.red,
              width: 2,
            ),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: status ? Colors.green : Colors.red,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  @override
  bool getStatus() {
    return status;
  }

  @override
  void setStatus(bool newStatus) {
    status = newStatus;
    changeColor();
  }

  @override
  void changeColor() {
    setState(() {
      buttonColor = status ? Setting.activeColor : Setting.disableColor;
    });
  }
}

abstract class CellStatusWidget implements AtomSatusWidget {
  void changeColor();
}

abstract class AtomSatusWidget {
  bool getStatus();
  void setStatus(bool status);
}
