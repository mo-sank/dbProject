import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Check and request location permission
  Future<bool> checkAndRequestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    
    return true;
  }

  /// Get current location coordinates
  Future<Position?> getCurrentLocation() async {
    try {
      final hasPermission = await checkAndRequestPermission();
      if (!hasPermission) return null;
      
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  /// Convert coordinates to address
  Future<String?> getAddressFromCoordinates(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final parts = [
          if (place.locality != null) place.locality,
          if (place.administrativeArea != null) place.administrativeArea,
          if (place.country != null) place.country,
        ];
        return parts.join(', ');
      }
    } catch (e) {
      print('Error geocoding: $e');
    }
    return null;
  }

  /// Get user's current location as formatted address
  Future<String?> getCurrentLocationAddress() async {
    final position = await getCurrentLocation();
    if (position == null) return null;
    
    return await getAddressFromCoordinates(
      position.latitude,
      position.longitude,
    );
  }
}

