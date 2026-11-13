import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class EvidenceCard extends StatelessWidget {
  final File foto;
  final Position ubicacion;
  final DateTime fecha;

  const EvidenceCard({
    super.key,
    required this.foto,
    required this.ubicacion,
    required this.fecha,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Evidencia registrada',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                foto,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 15),

            Text('Latitud: ${ubicacion.latitude}'),

            const SizedBox(height: 8),

            Text('Longitud: ${ubicacion.longitude}'),

            const SizedBox(height: 8),

            Text('Hora: ${fecha.toLocal().toString().split('.')[0]}'),
          ],
        ),
      ),
    );
  }
}
