import 'package:kindblood_common/core_entities.dart';
import 'package:kindblood_common/utils.dart';
import 'dart:convert';

class SQLBusinessLogicFunctions {
  // TODO: For now, contact will be stored as a json string in a row, sorry!
  // We should probably change it.

  bool doesContactPassFilterSQLFunction(args,
      {required SearchInfo searchInfo}) {
    /*
    args should contain [id, json]
    */
    var contactMap = jsonDecode(args[1]);
    contactMap["id"] = args[0].toString();
    contactMap["contactSourceType"] = ContactSourceType.online.name;
    var retrievedContact = ContactInfo.fromJson(contactMap);
    final filterUtil = ContactFilterUtil();
    return filterUtil.runAllFilters(
      contact: retrievedContact,
      searchInfo: searchInfo,
    );
  }
}
