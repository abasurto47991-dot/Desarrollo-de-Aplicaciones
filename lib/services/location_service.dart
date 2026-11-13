import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> obtenerUbicacion() async {
    // Verificar si el GPS esta encendido
    bool gpsActivo = await Geolocator.isLocationServiceEnabled();

    if (!gpsActivo) {
      throw Exception('Activa el GPS de tu dispositivo');
    }

    // Verificar permisos
    LocationPermission permiso = await Geolocator.checkPermission();

    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
    }

    if (permiso == LocationPermission.denied) {
      throw Exception('No se concedio el permiso de ubicacion');
    }

    if (permiso == LocationPermission.deniedForever) {
      throw Exception('Debes habilitar los permisos desde configuracion');
    }

    // Obtener coordenadas actuales
    Position posicion = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    return posicion;
  }
}
