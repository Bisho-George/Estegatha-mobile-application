import 'package:flutter/foundation.dart';

class ConstantVariables {
  static const String uri =
  kIsWeb ? 'http://127.0.0.1:8080' : 'http://192.168.1.13:8080';
  // 'http://192.168.1.13:8080' => ahmed IP

  static final List<Map<String, dynamic>> memberHelpNotes = [
    {
      'image': 'assets/org_settings_reg_1.png',
      'title': 'Organization management',
      'text':
      'Changes you make here apply only to the current selected organization.',
    },
    {
      'image': 'assets/org_settings_reg_2.png',
      'title': 'Organization rule',
      'text':
      'Location sharing, places, and tracking apply to a specific organization.',
    },
    // Add more help notes as needed
  ];

  static final List<Map<String, dynamic>> ownerHelpNotes = [
    {
      'image': 'assets/org_settings_reg_3.png',
      'title': 'Admin permissions',
      'text':
      'Only admins can edit, delete organization, and change members role.',
    },
    {
      'image': 'assets/org_settings_reg_1.png',
      'title': 'Organization management',
      'text':
      'Changes you make here apply only to the current selected organization.',
    },
    {
      'image': 'assets/org_settings_reg_2.png',
      'title': 'Admin permissions',
      'text':
      'Only admins can edit, delete organization, and change members role.',
    },
  ];
  static final List<Map<String, dynamic>> userHealthRecordsNotes = [
    {
      'image': 'assets/health-record-note-1.png',
      'title': 'Health records',
      'text': 'Here you can add your chronic diseases, medical history.',
    },
    {
      'image': 'assets/health-record-note-1.png',
      'title': 'Tips & health catalogs',
      'text':
      'We can take care of you by providing tips and health catalogs for your condition.',
    },
  ];
}
