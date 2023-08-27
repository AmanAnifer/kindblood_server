import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:kindblood_server/src/core/status_objects/failure.dart';
import 'package:kindblood_common/core_entities.dart';

import '../repository/contact_repository.dart';

class GetContactUseCase {
  final ContactRepository contactRepository;
  GetContactUseCase({required this.contactRepository});

  Future<Either<Failure, List<OnlineContactInfo>>> getSearchResultContacts(
      {required String searchInfoJsonString}) async {
    var thing = jsonDecode(
      searchInfoJsonString,
    );

    // print(thing.runtimeType);
    final OnlineSearchInfo searchInfo =
        OnlineSearchInfo.fromJson(thing as Map<String, dynamic>);
    return contactRepository.getSearchResultContacts(searchInfo: searchInfo);
  }
}
