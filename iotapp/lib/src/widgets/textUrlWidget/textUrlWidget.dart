import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TextUrlWidget extends StatelessWidget{

  final String label;
  final String url;

  const TextUrlWidget({super.key, required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
              child: Text(label),
              onTap: () => launchUrlString(url)
              );
  }
}