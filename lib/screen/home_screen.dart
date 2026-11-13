import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../services/location_service.dart';
import '../services/camera_service.dart';
import '../widgets/evidence_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocationService locationService = LocationService();
  final CameraService cameraService = CameraService();

  Position? ubicacion;
  File? foto;
  DateTime? fecha;

  bool cargando = false;

  Future<void> registrarEvidencia() async {
    setState(() {
      cargando = true;
    });

    try {
      // Primero obtener la ubicacion GPS
      Position posicion = await locationService.obtenerUbicacion();

      // Despues abrir la camara
      XFile? imagen = await cameraService.tomarFoto();

      if (imagen == null) {
        return;
      }

      // Registrar la fecha y hora
      DateTime ahora = DateTime.now();

      setState(() {
        ubicacion = posicion;
        foto = File(imagen.path);
        fecha = ahora;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          cargando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Bitácora'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const Icon(Icons.location_on, size: 80, color: Colors.blue),

            const SizedBox(height: 15),

            const Text(
              'Registro de evidencias de campo',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              'Obtén tu ubicación y toma una fotografía '
              'para registrar tu evidencia.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton.icon(
                onPressed: cargando ? null : registrarEvidencia,

                icon: const Icon(Icons.camera_alt),

                label: const Text(
                  'Registrar Evidencia',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (cargando) const CircularProgressIndicator(),

            if (foto != null && ubicacion != null && fecha != null)
              EvidenceCard(foto: foto!, ubicacion: ubicacion!, fecha: fecha!),
          ],
        ),
      ),
    );
  }
}
