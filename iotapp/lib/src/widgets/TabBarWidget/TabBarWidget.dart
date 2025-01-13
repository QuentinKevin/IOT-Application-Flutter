import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;

  const TabBarWidget({
    super.key,
    required this.tabController,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        controller: tabController,
        labelStyle: const TextStyle(
          fontFamily: 'PipBoyFont',
          fontSize: 20,
        ),
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2, // Épaisseur de la barre
            color: Color(0xFF00FF00), // Couleur verte fluo comme les labels
          ),
        ),
        labelColor: const Color(0xFF00FF00),
        unselectedLabelColor: const Color(0xFF00FF00).withOpacity(0.4),
        tabs: tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }
}
