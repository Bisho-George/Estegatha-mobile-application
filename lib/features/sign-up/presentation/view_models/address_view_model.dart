import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../utils/services/location_service.dart';

class AddressViewModel {
  late TextEditingController addressController;
  final ScrollController scrollController = ScrollController();
  late LocationService locationService;
  GoogleMapController? controller;

  AddressViewModel() {
    addressController = TextEditingController();
  }



// Other methods and properties...
}
