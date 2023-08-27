import 'package:fpdart/fpdart.dart';
import 'package:kindblood_common/core_entities.dart';
import 'package:kindblood_server/src/core/status_objects/exceptions.dart';
import 'package:kindblood_server/src/core/status_objects/success.dart';

import 'package:sqlite3/sqlite3.dart';
import '../../domain/usecase/contact_filter.dart';
import 'package:kindblood_server/src/core/string_contacts.dart';
import 'dart:convert';

abstract class ContactDataStore {
  Future<Either<Exception, List<OnlineContactInfo>>> getSearchResultContacts(
      {required OnlineSearchInfo searchInfo});
  Future<Either<Exception, Success>> submitContact(
      {required MyInfo submittedContact});
}

class SQLiteContactDataStore implements ContactDataStore {
  final Database db;
  final ContactFilterSQLUtils contactFilterSQLUtils;
  SQLiteContactDataStore({
    required this.contactFilterSQLUtils,
    required this.db,
  });

  @override
  Future<Either<Exception, List<OnlineContactInfo>>> getSearchResultContacts(
      {required OnlineSearchInfo searchInfo}) async {
    try {
      db.createFunction(
        functionName: contactFilterFunctionName,
        argumentCount: const AllowedArgumentCount(2),
        function: (arguments) =>
            contactFilterSQLUtils.doesContactPassFilterSQLFunction(arguments,
                searchInfo: searchInfo),
      );
      var result = db.select("""
      SELECT * 
      FROM contacts 
      WHERE $contactFilterFunctionName(id, contactJson)==1
      LIMIT 100; 
    """);
      /* 
      ? This is not vulnerable to SQL injection, right?
      The string being inserted is a constant string, holding the function name
      which is a safe string, so I hope its not vulnerable
      */
      List<OnlineContactInfo> contactsList = [];
      for (var contact in result) {
        var contactMap = jsonDecode(contact["contactJson"]);
        contactMap["id"] = contact["id"].toString();
        contactsList.add(OnlineContactInfo.fromJson(contactMap));
      }
      return Either.right(contactsList);
    } catch (error) {
      rethrow;
      return Either.left(DatabaseException());
    }
  }

  @override
  Future<Either<Exception, Success>> submitContact(
      {required MyInfo submittedContact}) async {
    try {
      var jsonString = jsonEncode(submittedContact.toJson());
      db.execute(
        """
        INSERT INTO contacts
          (contactJson)
        VALUES 
          (?)
        """,
        [jsonString],
      );
      return Either.right(ContactSaveSuccess());
    } catch (error) {
      rethrow;
      return Either.left(DatabaseException());
    }
  }
}
