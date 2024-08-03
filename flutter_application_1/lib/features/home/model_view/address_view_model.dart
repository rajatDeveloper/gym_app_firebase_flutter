import 'package:flutter_application_1/features/home/model/address_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AddressModelView {
  Future<AddressModel?> getAddressFromLocation() async {
    try {
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();
      // Get the current position with a timeout duration
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 10));

      // Get the address from the position
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      // Concatenate address components into a single string
      AddressModel? addressModel;
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        addressModel = AddressModel(
          id: 0,
          address: placemark.street.toString(),
          pin_code: int.parse(placemark.postalCode.toString()),
          city: placemark.locality.toString(),
          state: placemark.administrativeArea.toString(),
          country: placemark.country.toString(),
          latitude: position.latitude,
          longitude: position.longitude,
          user: 0,
        );
      }
      return addressModel;
    } catch (e) {
      // print('Error getting location: $e');
      return null;
    }
  }
}
