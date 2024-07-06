
import 'package:permission_handler/permission_handler.dart';

class PermissionDescription{
  final String name;
  final String description;
  PermissionDescription({required this.name, required this.description});
}
class PermissionList{
  static List<PermissionDescription> permissions = [
    PermissionDescription(name: 'Location', description: 'Location data is used to enable the in-app map, place Alerts, and location sharing with Organization.'),
    PermissionDescription(name: 'Camera', description: 'Estegatha uses your camera to scan the QR code'),
    PermissionDescription(name: 'Storage', description: 'Estegatha uses your storage to save your data'),
    PermissionDescription(name: 'Activity Recognition', description: 'Estegatha need to read your activity to track your health data'),
  ];
  static int length = permissions.length;
}

class Permissions{
  final List<Permission> _permissions = [
    Permission.location,
    Permission.camera,
    Permission.storage,
    Permission.activityRecognition,
    Permission.sensors,
    Permission.sensorsAlways,
  ];
  Future<void> grantPermissions() async{
    List<Permission> deniedPermissions = [];
    for (var permission in _permissions) {
      var status = await permission.status;
      if(!status.isGranted){
        deniedPermissions.add(permission);
      }
    }
    if(deniedPermissions.isNotEmpty){
      await deniedPermissions.request();
    }
  }
}