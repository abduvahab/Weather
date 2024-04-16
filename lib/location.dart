import 'package:geolocator/geolocator.dart';

Future<bool> getPermission() async{
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied)
  {
    return false;
  }
  return true;
}

