import 'package:permission_handler/permission_handler.dart';

class Handler {
  static Future<void> requestLocationPermission() async {
  PermissionStatus status = await Permission.location.request();

  if (status.isGranted) {
    // La permission de localisation a été accordée
  
  } else {
    // La permission de localisation a été refusée
    // Gérer en conséquence (afficher un message d'erreur, désactiver les fonctionnalités dépendant de la localisation, etc.)
  }
}

}


