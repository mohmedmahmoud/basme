import 'package:location/location.dart';
import 'dart:math' show cos, sqrt, asin;

class LocationDivice {
  Location location = Location();

  // position is ok
  bool positionIsOk(
      {double? latitude,
      double? longitude,
      double? latitudeAgency,
      double? longitudeAgency}) {
    print(
        'positions : $latitude, $longitude, $latitudeAgency, $longitudeAgency');
    if (latitude == null ||
        longitude == null ||
        latitudeAgency == null ||
        longitudeAgency == null) {
      return false;
    } else {
      double distance = calculateDistance(
          latitude, longitude, latitudeAgency, longitudeAgency);

      if (distance < 50) {
        return true;
      } else {
        return false;
      }
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * 1000 * asin(sqrt(a));
  }

  //  get location
  Future<LocationData?> getLocation() async {
    print('get location');

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      while (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
      }
    }

    _permissionGranted = await location.hasPermission();
    while (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('location permission is not granted');
      }
    }
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   // Use current location
    //   _locationData = currentLocation;
    //   latitude = _locationData.latitude;
    //   longitude = _locationData.longitude;
    //   print('latitude: ${_locationData.latitude}');
    //   print('longitude: ${_locationData.longitude}');
    //   update();
    // });
    // location.getLocation().then((value) {
    //   print('latitude: ---${value.latitude}');
    //   return value;
    // });
    return await location.getLocation();
    // _attendance.clockIn =
    //     DateTime.fromMillisecondsSinceEpoch(_locationData.time!.toInt());
    // print(_attendance.clockIn.toString());
  }
}
