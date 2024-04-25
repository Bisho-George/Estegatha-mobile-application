import 'package:estegatha/features/landing/domain/models/permissions.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPermission extends PermissionDescription {
  CameraPermission() :super(name: 'Camera',
      description: 'Estegatha uses your camera to scan the QR code');
  @override
  grantPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      var result = await Permission.camera.request();
    }
  }
}