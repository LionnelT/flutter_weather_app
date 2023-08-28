import 'package:flutter/material.dart';

class Destination {
  const Destination(this.icon, this.label);
  final IconData icon;
  final String label;
}

const List<Destination> destinations = <Destination>[
  Destination(Icons.home, 'Home'),
  Destination(Icons.map_rounded, 'Map'),
  Destination(Icons.info, 'Info'),
  Destination(Icons.settings, 'Settings'),
];