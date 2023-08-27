import 'package:kindblood_server/src/core/entities/contact_info.dart';
import '../entities/search_info.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kindblood_server/src/core/status_objects/failure.dart';
import 'package:kindblood_server/src/core/status_objects/success.dart';
import 'package:kindblood_server/src/core/entities/myinfo_entity.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<OnlineContactInfo>>> getSearchResultContacts(
      {required OnlineSearchInfo searchInfo});
  Future<Either<Failure, Success>> submitContact(
      {required MyInfo submittedContact});
}
