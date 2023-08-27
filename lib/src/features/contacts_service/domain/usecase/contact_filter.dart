import 'package:kindblood_common/core_entities.dart';
import 'package:kindblood_common/utils.dart';
import 'dart:convert';

bool _doesContactPassFilter({
  required OnlineContactInfo retrievedContact,
  required OnlineSearchInfo searchInfo,
}) {
  bool shouldPass = false;
  // TODO: separate blood checking, distance and all that into seperate functions

  // Blood Check

  if (searchInfo.bloodGroup == BloodGroup.Unknown) {
    shouldPass = true;
  } else {
    if (getBloodCompatibility(
      receiver: searchInfo.bloodGroup,
      donor: retrievedContact.bloodGroup ?? BloodGroup.Unknown,
    ) is Compatible) {
      shouldPass = true;
    } else {
      return false;
    }
  }

  final contactLocation = retrievedContact.locationCoordinates;
  if (contactLocation == null) {
    if (searchInfo.maxDistance is InfiniteMeter) {
      // If 'within' is no limit then we want to return everything
      shouldPass = true;
    } else {
      return false;
    }
  } else {
    final distance = getDistanceBetweenTwoLatLongs(
        from: searchInfo.userLocation, to: contactLocation);
    if (distance.lengthInMeters > searchInfo.maxDistance.lengthInMeters &&
        searchInfo.maxDistance is! InfiniteMeter) {
      return false;
    } else {
      shouldPass = true;
    }
    // If 'within' is no limit then we want to return everything
  }

  return shouldPass;
}

class ContactFilterSQLUtils {
  // TODO: For now, contact will be stored as a json string in a row, sorry!
  // We should probably change it.

  bool doesContactPassFilterSQLFunction(args,
      {required OnlineSearchInfo searchInfo}) {
    /*
    args should contain [id, json]
    */
    var mapWithoutId = jsonDecode(args[1]);
    mapWithoutId["id"] = args[0].toString();
    var retrievedContact = OnlineContactInfo.fromJson(mapWithoutId);
    return _doesContactPassFilter(
      retrievedContact: retrievedContact,
      searchInfo: searchInfo,
    );
  }
}
