import 'package:flutter/material.dart';
import 'package:iotapp/src/services/MqttService.dart';
import 'package:iotapp/src/settings/setting.dart';

class StatusWidget extends StatefulWidget {
  final String label;
  final bool initialStatus;
  final Color buttonColor;
  final double widthButton;
  final double heightButton;
  final VoidCallback? onPressed; // Callback for custom actions
  final MqttService mqttService;

  const StatusWidget({
    super.key,
    required this.label,
    required this.initialStatus,
    required this.buttonColor,
    this.widthButton = 200,
    this.heightButton = 60,
    this.onPressed,
    required this.mqttService,
  });

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget>
    implements CellStatusWidget {
  late bool status;
  late Color buttonColor;
  late MqttService mqttService;

  @override
  void initState() {
    super.initState();
    status = widget.initialStatus; // Use initialStatus to set the starting state
    buttonColor = widget.buttonColor;
    mqttService = widget.mqttService;
  }

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
          // Trigger the custom callback if provided
          if (widget.onPressed != null) {
            // widget.onPressed!();
          }
            mqttService.publishMessage('home/lights', status ? 'on' : 'off');
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

abstract class CellStatusWidget implements AtomStatusWidget {
  void changeColor();
}

abstract class AtomStatusWidget {
  bool getStatus();
  void setStatus(bool status);
}
