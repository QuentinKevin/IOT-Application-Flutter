// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:iotapp/src/settings/setting.dart';

class StatusWidget extends StatefulWidget {
  String label;
  bool status;
  Color buttonColor;
  double widthButton;
  double heightButton;

  StatusWidget({super.key, required this.label, required this.status, required this.buttonColor, required this.widthButton, required this.heightButton});

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
        child: FloatingActionButton(      
                  onPressed: () => {
                    setState(() {
                      setStatus(!status);
                    })
                  },
                  backgroundColor: buttonColor,
                  child: 
                    Text(widget.label),
                )
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
      buttonColor = status ? Setting.activeColor : Setting.disableColor;
  }
}

abstract class CellStatusWidget implements AtomSatusWidget {
  void changeColor();
}

abstract class AtomSatusWidget {
  bool getStatus();
  void setStatus(bool status);
} 